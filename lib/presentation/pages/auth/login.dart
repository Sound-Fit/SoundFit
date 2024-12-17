import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:soundfit/common/widgets/button/basic_button.dart';
import 'package:soundfit/common/widgets/text/title_text.dart';
import 'package:soundfit/core/configs/theme/app_colors.dart';
import 'package:soundfit/data/repositories/auth_repository.dart';
import 'package:soundfit/logic/blocs/auth/auth_bloc.dart';
import 'package:soundfit/logic/blocs/auth/auth_event.dart';
import 'package:soundfit/logic/blocs/auth/auth_state.dart';
import 'package:soundfit/presentation/pages/auth/register.dart';

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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(AuthRepository()),
      child: Scaffold(
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
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              Navigator.pushReplacementNamed(
                  context, state.isAgeNull ? '/camera' : '/home');
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage)),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
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
                                        borderRadius:
                                            BorderRadius.circular(15.0),
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
                                        borderRadius:
                                            BorderRadius.circular(15.0),
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
                                            _isPasswordHidden =
                                                !_isPasswordHidden;
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
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      ]),
                                  Gap(30.0),
                                  // Login Button
                                  BasicButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        context.read<AuthBloc>().add(
                                            LoginRequested(
                                                email: _email.text,
                                                password: _password.text));
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
            );
          },
        ),
      ),
    );
  }
}
