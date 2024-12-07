import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soundfit/common/widgets/text/based_text.dart';
import 'package:soundfit/common/widgets/text/poin_text.dart';
import 'package:soundfit/common/widgets/text/title_text.dart';

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
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BasedText(
                      text: "Welcome to SoundFit",
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins"),

                  // About Soundfit
                  Gap(20),
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
                      fontFamily: "Poppins"),

                  // Key Features
                  Gap(20),
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

                  // Privacy and Security
                  Gap(20),
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
                      fontFamily: "Poppins"),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
