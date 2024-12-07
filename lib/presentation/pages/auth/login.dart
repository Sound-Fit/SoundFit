import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:soundfit/common/widgets/button/basic_button.dart';
import 'package:soundfit/common/widgets/text/title_text.dart';
import 'package:soundfit/core/configs/theme/app_colors.dart';
import 'package:soundfit/presentation/pages/auth/register.dart';
import 'package:soundfit/presentation/pages/forgetPassword/forgetPassword.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _isPasswordHidden = true;

  Future<void> loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email.trim(), password: password.trim());
      print('User logged in: ${userCredential.user?.email}');

      // Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      // Ambil data pengguna dari Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user?.uid)
          .get();

      // Periksa apakah 'age' null
      if (userDoc.exists && userDoc.data() != null) {
        var userData = userDoc.data() as Map<String, dynamic>;
        if (userData['age'] == null) {
          // Arahkan ke /camera jika age null
          Navigator.pushNamedAndRemoveUntil(
              context, '/camera', (route) => false);
        } else {
          // Arahkan ke /home jika age tidak null
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        }
      } else {
        _showErrorDialog('User data not found in Firestore');
      }
    } on FirebaseAuthException catch (e) {
      print('Firebase Auth Exception: ${e.message}');
      String message = '';
      print(message);
      switch (e.code) {
        case 'wrong-password':
          message = 'Password is incorrect. Please try again.';
          break;
        case 'user-not-found':
          message = 'Account not found. Please register first.';
          break;
        case 'invalid-credential':
          message =
              'Invalid email or password. Please check your email and password and try again.';
          break;
        case 'invalid-email':
          message =
              'The email address is not valid. Please check and try again.';
          break;
        case 'network-request-failed':
          message =
              'Network error. Please check your internet connection and try again.';
          break;
        default:
          message = 'An error occurred: ${e.message}';
      }
      _showErrorDialog(message);
    } catch (e) {
      print('Unknown Exception: $e');
      _showErrorDialog('An unexpected error occurred. Please try again.');
    }
  }

  void _showErrorDialog(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context); // Kembali ke rute sebelumnya
                },
              )
            : null,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleText(
                          text: 'Hey!👋',
                          textAlign: TextAlign.left,
                          fontWeight: FontWeight.bold),
                      TitleText(
                          text: 'Login Now!',
                          textAlign: TextAlign.left,
                          fontWeight: FontWeight.bold),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Gap(30.0),
                            // Email text field
                            TextFormField(
                              controller: _email,
                              autofocus: true,
                              decoration: InputDecoration(
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                labelText: 'Email',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                // Validasi format email
                                final emailRegex =
                                    RegExp(r'^[^@]+@[^@]+\.[^@]+$');
                                if (!emailRegex.hasMatch(value)) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                            ),
                            Gap(30.0),

                            // Password text field
                            TextFormField(
                              controller: _password,
                              obscureText: _isPasswordHidden,
                              decoration: InputDecoration(
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                labelText: 'Password',
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isPasswordHidden
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordHidden = !_isPasswordHidden;
                                    });
                                  },
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Don' 't have an account?',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            Register(),
                                      ),
                                    ),
                                    child: const Text(
                                      'Sign Up',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ]),
                            Gap(30.0),
                            // Login Button
                            BasicButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  await loginUser(_email.text, _password.text);
                                }
                              },
                              title: "Login",
                              bgColor: AppColors.black,
                              textColor: AppColors.white,
                            )
                          ]),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
