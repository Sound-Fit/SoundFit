import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashPage extends StatelessWidget {
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
                  height: screenHeight * 0.24,
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
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset('images/first-page.jpg'),
                        ),
                        Gap(10),
                        TextButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white)),
                            onPressed: () =>
                                Navigator.pushNamed(context, '/welcome'),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Fit Your Playlist Now!',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    fontFamily:
                                        GoogleFonts.lexendGiga().fontFamily),
                              ),
                            ))
                      ]),
                )),
          ],
        ),
      ),
    );
  }
}
