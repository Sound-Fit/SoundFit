import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:soundfit/common/widgets/button/song_button.dart';
import 'package:soundfit/common/widgets/text/based_text.dart';
import 'package:soundfit/common/widgets/text/title_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RecommendationPage extends StatelessWidget {
  const RecommendationPage({Key? key}) : super(key: key);

  Future<String?> _getRecognitionPath() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Ambil data pengguna dari Firestore
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        // Kembalikan recognition_path
        return userDoc.data()?['recognition_path'];
      }
    } catch (e) {
      print('Error getting recognition_path: $e');
    }
    return null; // Fallback jika data tidak ditemukan
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleText(text: 'Recommendation', textAlign: TextAlign.center),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder<String?>(
        future: _getRecognitionPath(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Loading state
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // Error state
            return Center(
              child: Text('Failed to load data: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data == null) {
            // No data state
            return const Center(
              child: Text('No recognition path found.'),
            );
          } else {
            // Success state
            final recognitionPath = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Result Classification
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Display the image from recognitionPath
                            Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                  image: NetworkImage(recognitionPath),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            BasedText(
                                text: "[50-60] Years") // Example classification
                          ],
                        ),
                        Gap(30),

                        // Recommended Playlist
                        BasedText(
                          text: "Recommended Songs",
                          fontWeight: FontWeight.bold,
                        ),
                        Gap(30),

                        Row(
                          children: [
                            Expanded(
                                child: Column(
                              children: [
                                // Example songs
                                SongButton(
                                    songTitle: "Young and Beautiful",
                                    artistName: "Lana Del Rey",
                                    image: Image.asset("assets/images/YnB.jpg"),
                                    year: 2019,
                                    onPressed: () {}),
                                SongButton(
                                    songTitle: "Paradise",
                                    artistName: "Young Man",
                                    image: Image.asset(
                                        "assets/images/SongCover.jpg"),
                                    year: 2019,
                                    onPressed: () {}),
                                SongButton(
                                    songTitle: "Born To Die",
                                    artistName: "Lana Del Ray",
                                    image:
                                        Image.asset("assets/images/Artist.jpg"),
                                    year: 2019,
                                    onPressed: () {}),
                              ],
                            ))
                          ],
                        )
                      ],
                    ),
                  ))
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
