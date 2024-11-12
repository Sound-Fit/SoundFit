import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:soundfit/core/configs/theme/app_colors.dart';

class Information extends StatelessWidget {
  const Information({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleText(text: 'Information', textAlign: TextAlign.center),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextStyled(text: "Welcome to SoundFit", fontSize: 18),

                  // About Soundfit
                  Gap(20),
                  TextStyled(text: "About Soundfit", fontSize: 18),
                  Gap(10),
                  TextStyled(
                      text:
                          "SoundFit is your personalized music companion, using cutting-edge face recognition technology to suggest music playlists tailored to your age and mood. Whether you’re looking to energize, relax, or explore new sounds, SoundFit adapts to fit your vibe.",
                      fontSize: 14,
                      fontWeight: FontWeight.normal),

                  // Key Features
                  Gap(20),
                  TextStyled(text: "Key Feature", fontSize: 18),
                  Gap(10),
                  pointText(
                      text:
                          "Face Recognition for Playlist Recommendations: Simply enable the camera, and SoundFit will detect your age to recommend playlists suited to your taste."),
                  pointText(
                      text:
                          "Curated Playlists: Enjoy music playlists crafted to suit different moods, genres, and age groups."),
                  pointText(
                      text:
                          "Intuitive Design: Navigate effortlessly with a clean interface that makes finding music simple and fun."),

                  // Privacy and Security
                  Gap(20),
                  TextStyled(text: "Privacy and Security", fontSize: 18),
                  Gap(10),
                  TextStyled(
                      text:
                          "At SoundFit, we prioritize your privacy. Your face data is securely processed and not stored, ensuring that your personal information remains protected.",
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget TitleText({required String text, TextAlign? textAlign}) {
    return Text(
      text,
      textAlign: textAlign,
    );
  }

  Widget TextStyled(
      {required String text,
      required double fontSize,
      FontWeight fontWeight = FontWeight.bold}) {
    return Text(
      text,
      textAlign: TextAlign.justify,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: AppColors.black,
        fontFamily: 'Poppins',
      ),
    );
  }

  Widget pointText({required String text}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("•"),
        Gap(10),
        Expanded(
          child: TextStyled(
            text: text,
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
