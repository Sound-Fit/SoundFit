import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soundfit/common/widgets/text/based_text.dart';
import 'package:soundfit/common/widgets/text/title_text.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool _isLoading = false;

  final TextEditingController _oldPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _newPasswordConfirm = TextEditingController();

  // GlobalKey for form validation
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: GoogleFonts.lexendGiga(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _changePassword,
            child: Text(
              'Save',
              style: GoogleFonts.poppins(
                color: Colors.blue,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      // AppBar(
      //   title: TitleText(text: 'Change Password', textAlign: TextAlign.center),
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   centerTitle: true,
      //   actions: [
      //     TextButton(
      //       onPressed: () async {
      //         if (_formKey.currentState!.validate()) {
      //           // Only proceed if form is valid
      //           await _changePassword();
      //         }
      //       },
      //       child: Text(
      //         'Save',
      //         style: GoogleFonts.poppins(
      //           color: Colors.blue,
      //           fontSize: 16,
      //           fontWeight: FontWeight.w600,
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              key: _formKey, // Attach the form key here
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Old Password field
                          BasedText(
                            text: "Old Password",
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          SizedBox(height: 8),
                          TextFormField(
                            controller: _oldPassword,
                            decoration: InputDecoration(
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your old password';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                          Gap(16),

                          // New Password field
                          BasedText(
                            text: "New Password",
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          SizedBox(height: 8),
                          TextFormField(
                            controller: _newPassword,
                            decoration: InputDecoration(
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your new password';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                          Gap(16),

                          // Confirm New Password field
                          BasedText(
                            text: "Confirm New Password",
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          SizedBox(height: 8),
                          TextFormField(
                            controller: _newPasswordConfirm,
                            decoration: InputDecoration(
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your confirm new password';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              if (value != _newPassword.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          if (_isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _changePassword() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      final cred = EmailAuthProvider.credential(
        email: user!.email!,
        password: _oldPassword.text,
      );

      // Verifikasi password lama
      await user.reauthenticateWithCredential(cred);

      // Cek apakah password baru dan konfirmasi password cocok
      if (_newPassword.text != _newPasswordConfirm.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('New passwords do not match')),
        );
        return;
      }

      // Update password baru
      await user.updatePassword(_newPassword.text);

      // Informasikan pengguna dan navigasi ke halaman profil
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password changed successfully')),
      );
      Navigator.pushReplacementNamed(context, '/profile');
    } on FirebaseAuthException catch (e) {
      // Menangani error jika password lama salah
      if (e.code == 'invalid-credential') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'The old password you entered is incorrect. Please try again.')),
        );
      } else {
        // Menangani error lainnya
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to change password: ${e.message}')),
        );
      }
    } catch (e) {
      // Menangani error umum lainnya
      print('Error changing password: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to change password: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
