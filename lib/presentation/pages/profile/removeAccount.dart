import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:soundfit/common/widgets/button/basic_button.dart';
import 'package:soundfit/common/widgets/text/based_text.dart';
import 'package:soundfit/common/widgets/text/poin_text.dart';
import 'package:soundfit/common/widgets/text/title_text.dart';
import 'package:soundfit/core/configs/theme/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RemoveAccount extends StatefulWidget {
  const RemoveAccount({Key? key}) : super(key: key);

  @override
  _RemoveAccountState createState() => _RemoveAccountState();
}

class _RemoveAccountState extends State<RemoveAccount> {
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // Function to delete account
  Future<void> _deleteAccount() async {
    if (!_formKey.currentState!.validate()) {
      return; // Don't proceed if validation fails
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Reauthenticate the user using the password
        final credential = EmailAuthProvider.credential(
          email: user.email!,
          password: _passwordController.text.trim(),
        );

        await user.reauthenticateWithCredential(credential);

        // Delete the user account
        await user.delete();

        // Show success message and navigate to login page
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account deleted successfully')),
        );
        Navigator.pushReplacementNamed(context,
            '/login'); // Navigate to the login screen or wherever appropriate
      }
    } catch (e) {
      print('Error deleting account: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleText(text: 'Remove Account', textAlign: TextAlign.center),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // About Soundfit
                    Column(
                      children: [
                        BasedText(
                            text:
                                "Are you sure you want to delete your account? Deleting your account will permanently remove your profile, playlists, and all saved preferences. This action cannot be undone.",
                            fontSize: 14,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.normal),
                        PoinText(
                            text:
                                "To confirm, please enter your account password and tap Delete Account."),
                        PoinText(
                            text:
                                "If you’re not sure, you can go back and keep your account active."),
                      ],
                    ),

                    // Password Input Field
                    Gap(16),
                    BasedText(
                      text: "Confirm your password",
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins",
                      fontSize: 16,
                    ),
                    SizedBox(height: 8),
                    Form(
                      key: _formKey, // Attach the form key for validation
                      child: TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null; // No error if validation passes
                        },
                        obscureText: true, // Hide password text
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Button
            BasicButton(
              onPressed: _isLoading
                  ? () {}
                  : _deleteAccount, // Disable button while loading
              title: _isLoading ? 'Deleting...' : "Delete Account",
              bgColor: AppColors.red,
              textColor: AppColors.white,
            ),

            if (_isLoading)
              Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
