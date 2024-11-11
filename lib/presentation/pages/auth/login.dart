import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soundfit/common/widgets/button/basic_button.dart';
import 'package:soundfit/core/configs/theme/app_colors.dart';
import 'package:soundfit/data/models/auth/signin_user_req.dart';
import 'package:soundfit/domain/usecases/auth/signin.dart';
import 'package:soundfit/presentation/pages/forgetPassword/forgetPassword.dart';
// import 'package:soundfit/presentation/pages/home.dart';
import 'package:soundfit/presentation/widgets/navBar.dart';
import 'package:soundfit/service_locator.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Set the back icon here
          onPressed: () {
            Navigator.pop(context); // Navigates back when pressed
          },
        ),
        backgroundColor:
            Colors.transparent, // Optional: make the app bar transparent
        elevation: 0, // Optional: remove shadow
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hey!👋',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.lexendGiga().fontFamily),
            ),
            Text('Login Now!',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.lexendGiga().fontFamily)),
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Gap(30.0),
              TextField(
                  controller: _email,
                  autofocus: true,
                  decoration: InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      labelText: 'Email')),
              Gap(30.0),
              TextField(
                  controller: _password,
                  obscureText: true,
                  decoration: InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      labelText: 'Password')),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('forgot password?', style: TextStyle(color: Colors.grey)),
                TextButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ForgetPassword())),
                    child: Text(
                      'reset password',
                      style: TextStyle(color: Colors.black),
                    ))
              ]),
              Gap(30.0),
              BasicButton(
                  onPressed: () async {
                    try {
                      var result = await sl<SigninUseCase>().call(
                          params: SignInUserReq(
                              email: _email.text.toString(),
                              password: _password.text.toString()));
                      result.fold(
                        (l) {
                          // Display error in AlertDialog
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Login Error"),
                                content: Text(l.contains("network")
                                    ? "Kesalahan jaringan, silakan periksa koneksi internet Anda."
                                    : l.contains("password")
                                        ? "Password salah, silakan coba lagi."
                                        : l.contains("not found")
                                            ? "Akun tidak ditemukan, silakan periksa email Anda."
                                            : "Terjadi kesalahan saat login. Silakan coba lagi."),
                                actions: [
                                  TextButton(
                                    child: Text("OK"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                          // var snackBar = SnackBar(
                          //     content: Text(l),
                          //     behavior: SnackBarBehavior.floating);
                          // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        (r) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    CustomNavBar()),
                            (route) => false,
                          );
                        },
                      );
                    } on Exception catch (e) {
                      print(e);
                    }
                  },
                  title: "Login",
                  bgColor: AppColors.black,
                  textColor: AppColors.white)
            ]),
          ],
        ),
      ),
    );
  }
}
