import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:soundfit/common/widgets/button/song_button.dart';
import 'package:soundfit/common/widgets/text/based_text.dart';
import 'package:soundfit/common/widgets/text/title_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RecommendationPage extends StatelessWidget {
  const RecommendationPage({Key? key}) : super(key: key);

  // Method to fetch recognition path and age from Firestore
  Future<Map<String, String?>> _getUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Ambil data pengguna dari Firestore
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        // Ambil recognition_path dan age
        final recognitionPath = userDoc.data()?['recognition_path'];
        final age = userDoc.data()?['age'];

        return {
          'recognitionPath': recognitionPath,
          'age': age?.toString(),
        };
      }
    } catch (e) {
      print('Error getting user data: $e');
    }
    return {
      'recognitionPath': null,
      'age': null
    }; // Fallback jika data tidak ditemukan
  }

  // Method to determine age range based on the age value
  String getAgeRange(String? ageStr) {
    if (ageStr == null) return '[Unknown Age]';

    final age = int.tryParse(ageStr);
    if (age == null) return '[Invalid Age]';

    switch (age) {
      case 0:
        return '0-5 Years';

      case 1:
        return '6-10 Years';

      case 2:
        return '11-15 Years';

      case 3:
        return '16-20 Years';

      case 4:
        return '21-30 Years';

      case 5:
        return '31-40 Years';

      case 6:
        return '41-50 Years';

      case 7:
        return '51-60 Years';

      case 8:
        return '61-70 Years';

      case 9:
        return '71-80 Years';

      case 10:
        return '81+ Years';

      default:
        return 'Can' 't determine age range';
    }
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
      body: FutureBuilder<Map<String, String?>>(
        future: _getUserData(),
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
          } else if (!snapshot.hasData ||
              snapshot.data?['recognitionPath'] == null) {
            // No data state
            return const Center(
              child: Text('No recognition path found.'),
            );
          } else {
            // Success state
            final recognitionPath = snapshot.data?['recognitionPath'];
            final age = snapshot.data?['age'];
            final ageRange = getAgeRange(age);

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
                                  image: NetworkImage(recognitionPath!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            BasedText(text: "$ageRange") // Show the age range
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
