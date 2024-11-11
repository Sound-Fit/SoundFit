import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soundfit/common/widgets/button/basic_button.dart';
import 'package:soundfit/core/configs/theme/app_colors.dart';
import 'package:soundfit/presentation/pages/auth/login.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

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
              'Forgot Password?',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.lexendGiga().fontFamily),
            ),
            Gap(20),
            Text('No Worries, we’ll send reset password link via email! 😉',
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: GoogleFonts.lexendGiga().fontFamily)),
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Gap(36.0),
              TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      labelText: 'Email')),
              Gap(36.0),
              BasicButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Login())),
                  title: "SEND",
                  bgColor: AppColors.black,
                  textColor: AppColors.white)
            ]),
          ],
        ),
      ),
    );
  }
}
