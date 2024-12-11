import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:soundfit/common/widgets/text/based_text.dart';
import 'package:soundfit/common/widgets/text/title_text.dart';
import 'package:soundfit/presentation/widgets/recognition/recognition_result.dart';
import 'package:soundfit/presentation/widgets/song/songLists.dart';

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
            final ageRange = snapshot.data?['age'] ?? 'Unknown';

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
                        RecognitionResult(recognitionPath: recognitionPath, ageRange: ageRange),
                        Gap(30),

                        // Recommended Playlist
                        BasedText(
                          text: "Recommended Songs",
                          fontWeight: FontWeight.bold,
                        ),
                        Gap(30),

                        SongLists(),
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
