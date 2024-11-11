import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soundfit/common/widgets/button/basic_button.dart';
import 'package:soundfit/common/widgets/button/outline_button.dart';
import 'package:soundfit/core/configs/theme/app_colors.dart';
import 'package:soundfit/presentation/pages/auth/login.dart';
import 'package:soundfit/presentation/pages/auth/register.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
                shadowColor: Colors.black,
                color: Colors.grey.shade200,
                child: SizedBox(
                  height: screenHeight * 0.10,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'SoundFit',
                          style: TextStyle(
                              fontSize: 24,
                              fontFamily: GoogleFonts.lexendGiga().fontFamily,
                              fontWeight: FontWeight.bold),
                          // textAlign: TextAlign.left,
                        )
                      ],
                    ),
                  ),
                )),
            Card(
                color: Color(0xFFC3E6D0),
                child: SizedBox(
                  height: screenHeight * 0.77,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Image.asset('assets/images/first-page.jpg'),
                          Gap(50.0),
                          BasicButton(
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Login())),
                              title: "LOGIN",
                              bgColor: AppColors.white,
                              textColor: AppColors.black),
                          Gap(20.0),
                          OutlineButton(
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Register())),
                              title: "REGISTER",
                              outlineColor: AppColors.black,
                              textColor: AppColors.black)
                        ]),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
