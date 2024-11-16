import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:soundfit/common/widgets/button/basic_button.dart';
import 'package:soundfit/common/widgets/text/title_text.dart';
import 'package:soundfit/core/configs/theme/app_colors.dart';
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
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
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
              'The supplied auth credential is incorrect, malformed, or expired. Please check your email and password and try again.';
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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Login Error'),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
                                    'Lupa password?',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            ForgetPassword(),
                                      ),
                                    ),
                                    child: const Text(
                                      'Reset Password',
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
