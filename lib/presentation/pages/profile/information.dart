import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soundfit/common/widgets/text/based_text.dart';
import 'package:soundfit/common/widgets/text/poin_text.dart';

class Information extends StatelessWidget {
  const Information({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Information',
          style: GoogleFonts.lexendGiga(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
        child: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // About Soundfit
                  BasedText(
                      text: "About Soundfit",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins"),
                  Gap(10),
                  BasedText(
                      text:
                          "SoundFit is your personalized music companion, using cutting-edge face recognition technology to suggest music playlists tailored to your age and mood. Whether you’re looking to energize, relax, or explore new sounds, SoundFit adapts to fit your vibe.",
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      fontFamily: "Poppins",
                      profile: true),

                  // Key Features
                  Gap(10),
                  BasedText(
                      text: "Key Feature",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins"),
                  Gap(10),
                  PoinText(
                      text:
                          "Face Recognition for Playlist Recommendations: Simply enable the camera, and SoundFit will detect your age to recommend playlists suited to your taste."),
                  PoinText(
                      text:
                          "Curated Playlists: Enjoy music playlists crafted to suit different moods, genres, and age groups."),
                  PoinText(
                      text:
                          "Intuitive Design: Navigate effortlessly with a clean interface that makes finding music simple and fun."),
                  Gap(10),

                  // How to use
                  BasedText(
                    text: "How to Use SoundFit",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins",
                  ),
                  Gap(10),
                  PoinText(
                      point: '1.',
                      text:
                          'Download and install the SoundFit app on your device.'),
                  PoinText(
                      point: '2.',
                      text: 'Open the app and grant access to your camera.'),
                  PoinText(
                      point: '3.',
                      text:
                          'Let SoundFit analyze your face to generate tailored playlist recommendations.'),
                  PoinText(
                      point: '4.',
                      text:
                          'Enjoy playlists curated specifically for your age.'),

                  // Why choose
                  Gap(10),
                  BasedText(
                    text: "Why Choose SoundFit",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins",
                  ),
                  Gap(10),
                  BasedText(
                    text:
                        "SoundFit combines advanced technology and user-friendly design to bring you a music experience like no other. Here’s why you should choose us:",
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    fontFamily: "Poppins",
                    profile: true,
                  ),
                  PoinText(
                      text:
                          "Personalized Playlists: Music tailored to your unique preferences."),
                  PoinText(
                      text:
                          "Privacy First: We securely process your data without storing sensitive information."),
                  PoinText(
                      text:
                          "Easy to Use: Navigate the app with ease and find your perfect soundtrack instantly."),

                  // Privacy and Security
                  Gap(10),
                  BasedText(
                      text: "Privacy and Security",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins"),
                  Gap(10),
                  BasedText(
                      text:
                          "At SoundFit, we prioritize your privacy. Your face data is securely processed and not stored, ensuring that your personal information remains protected.",
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      fontFamily: "Poppins",
                      profile: true),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
