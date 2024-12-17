import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:soundfit/common/widgets/text/based_text.dart';
import 'package:soundfit/common/widgets/text/title_text.dart';
import 'package:soundfit/core/services/playlist_service.dart';
import 'package:soundfit/data/models/songs.dart';
import 'package:soundfit/presentation/widgets/recognition/recognition_result.dart';
import 'package:soundfit/presentation/widgets/song/songLists.dart';

class RecommendationPage extends StatefulWidget {
  const RecommendationPage({Key? key}) : super(key: key);

  @override
  _RecommendationPageState createState() => _RecommendationPageState();
}

class _RecommendationPageState extends State<RecommendationPage> {
  final PlaylistService _playlistService = PlaylistService();
  late Future<Map<String, String?>> _userData;
  late Future<List<Songs>> _recommendedSongs;

  @override
  void initState() {
    super.initState();
    _userData = _getUserData();
  }

  // Method to fetch recognition path, age, and playlist from Firestore
  Future<Map<String, String?>> _getUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        final recognitionPath = userDoc.data()?['recognition_path'];
        final age = userDoc.data()?['age'];
        final playlist =
            userDoc.data()?['playlistIds'][0]; // Ensure playlist exists

        return {
          'recognitionPath': recognitionPath,
          'age': age?.toString(),
          'playlist': playlist?.toString(), // Ensure playlist is not null
        };
      }
    } catch (e) {
      print('Error getting user data: $e');
    }
    return {'recognitionPath': null, 'age': null, 'playlist': null};
  }

  // Create a recommendations playlist based on the existing playlist
  Future<void> _createRecommendationPlaylist(String playlistId) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await _playlistService.createRecommendationsPlaylist(
          user.uid,
          playlistId,
        );
      }
    } catch (e) {
      print('Error creating recommendations playlist: $e');
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
        future: _userData,
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
            final playlistId = snapshot.data?['playlist'];

            if (playlistId != null) {
              // Call _createRecommendationPlaylist to create it if necessary
              _createRecommendationPlaylist(playlistId);
            }

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Result Classification
                          RecognitionResult(
                              recognitionPath: recognitionPath,
                              ageRange: ageRange),
                          Gap(30),

                          // Recommended Playlist
                          BasedText(
                            text: "Recommended Songs",
                            fontWeight: FontWeight.bold,
                          ),
                          Gap(30),

                          // Fetch songs for the recommended playlist
                          FutureBuilder<List<String>>(
                            future: _playlistService.getSongIdsFromPlaylist(
                                playlistId ??
                                    ''), // Ambil songIds dari playlist
                            builder: (context, songSnapshot) {
                              if (songSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (songSnapshot.hasError) {
                                return Center(
                                  child: Text(
                                      'Failed to load song IDs: ${songSnapshot.error}'),
                                );
                              } else if (!songSnapshot.hasData ||
                                  songSnapshot.data!.isEmpty) {
                                return const Center(
                                  child:
                                      Text('No recommended songs available.'),
                                );
                              } else {
                                // Kirimkan daftar songIds ke SongLists
                                return SongLists(
                                  songIds: songSnapshot.data!, // Daftar songIds
                                );
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
