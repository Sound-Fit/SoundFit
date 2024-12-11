import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:soundfit/common/widgets/text/based_text.dart';
import 'package:soundfit/presentation/widgets/artist/artistsCardList.dart';
import 'package:soundfit/presentation/widgets/recognition/recognition_result.dart';
import 'package:soundfit/presentation/widgets/song/songCardList.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // final FirebaseAuth _auth = FirebaseAuth.instance;

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
        final username = userDoc.data()?['username'];

        return {
          'recognitionPath': recognitionPath,
          'age': age?.toString(),
          'username': username?.toString()
        };
      }
    } catch (e) {
      print('Error getting user data: $e');
    }
    return {
      'recognitionPath': null,
      'age': null,
      'username': null
    }; // Fallback jika data tidak ditemukan
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Scaffold(
        appBar: AppBar(
          title: FutureBuilder<Map<String, String?>>(
            future: _getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text(
                  'Hi...',
                  style: TextStyle(fontSize: 17, color: Colors.grey),
                );
              } else if (snapshot.hasError || !snapshot.hasData) {
                return Text(
                  'Hi, User',
                  style: TextStyle(fontSize: 17, color: Colors.grey),
                );
              }

              // Safely get the username
              final username = snapshot.data?['username'] ?? 'User';
              return Text(
                'Hi, $username 👋',
                style: TextStyle(fontSize: 20, color: Colors.grey),
              );
            },
          ),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
        ),
        backgroundColor: Colors.white,
        body: FutureBuilder<Map<String, String?>>(
          future: _getUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Failed to load data: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData ||
                snapshot.data?['recognitionPath'] == null) {
              return const Center(
                child: Text('No recognition path found.'),
              );
            } else {
              final recognitionPath = snapshot.data?['recognitionPath'];
              final ageRange = snapshot.data?['age'] ?? 'Unknown';

              return SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      children: [
                        // Artist List
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BasedText(
                              text: 'Artists',
                              fontWeight: FontWeight.bold,
                            ),
                            Gap(10),
                            ArtistsCardList(),
                          ],
                        ),

                        // Recent Recognition
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BasedText(
                              text: 'Recent Recognition',
                              fontWeight: FontWeight.bold,
                            ),
                            Gap(10),
                            RecognitionResult(
                                recognitionPath: recognitionPath,
                                ageRange: ageRange),
                          ],
                        ),
                        Gap(20),

                        // Song Card List From Firebase
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BasedText(
                                text: 'Songs',
                                fontWeight: FontWeight.bold,
                              ),
                              SongCardlist(),
                            ]),
                      ],
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
