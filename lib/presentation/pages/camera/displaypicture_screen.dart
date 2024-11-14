import 'package:flutter/material.dart';
import 'package:soundfit/common/widgets/text/based_text.dart';
import 'dart:io';

import 'package:soundfit/common/widgets/text/title_text.dart';

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: TitleText(text: 'Fit My Playlist', textAlign: TextAlign.center),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Camera Screen
            SizedBox(
              height: screenHeight * 0.68,
              child: Image.file(File(imagePath)),
            ),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.replay_rounded,
                        size: 50,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    BasedText(
                      text: "Retake",
                      fontSize: 14,
                    )
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.check_circle,
                        size: 50,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/recommendation',
                        );
                      },
                    ),
                    BasedText(
                      text: "Confirm",
                      fontSize: 14,
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
