import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soundfit/common/widgets/button/basic_button.dart';
import 'package:soundfit/core/configs/theme/app_colors.dart';
import 'package:soundfit/presentation/pages/auth/welcomePage.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    // Future.delayed(Duration(seconds: 2), () {
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(builder: (context) => const WelcomePage()),
    //   );
    // });

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
                  height: screenHeight * 0.20,
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
                        ),
                        const Gap(10),
                        Text(
                          'SoundFit is a smart app that uses facial analysis to detect a users age and suggest personalized music playlists.',
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: GoogleFonts.lexendGiga().fontFamily),
                          textAlign: TextAlign.justify,
                        )
                      ],
                    ),
                  ),
                )),
            Card(
                color: Color(0xFFC3E6D0),
                child: SizedBox(
                  height: screenHeight * 0.67,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Image.asset('assets/images/first-page.jpg'),
                          Gap(30),
                          BasicButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const WelcomePage()));
                              },
                              title: 'Fit Your Playlist Now!',
                              bgColor: AppColors.white,
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
