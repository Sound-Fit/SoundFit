import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:soundfit/common/widgets/notif/error_notification.dart';
import 'package:soundfit/common/widgets/text/based_text.dart';
import 'package:soundfit/common/widgets/text/title_text.dart';
import 'package:soundfit/core/services/playlist_service.dart';

class DisplayPictureScreen extends StatefulWidget {
  final String imagePath;

  DisplayPictureScreen({super.key, required this.imagePath});

  @override
  _DisplayPictureScreenState createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final PlaylistService _playlistService = PlaylistService();
  late Future<List<Map<String, dynamic>>> _playlistsFuture;
  bool _isLoading = false;

  Future<String?> _getUserNameOrUid() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Cek nama pengguna di Firestore
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        return userDoc.data()?['username'] ?? user.uid; // Gunakan nama atau UID
      }
    } catch (e) {
      showErrorDialog(context, 'Error getting user name: $e');
    }
    return null; // Fallback jika terjadi error
  }

  Future<String?> _uploadToFirebaseStorage(File imageFile) async {
    try {
      final userNameOrUid = await _getUserNameOrUid();

      if (userNameOrUid == null) {
        showErrorDialog(context, 'Failed to retrieve user information.');
        return null;
      }

      final ref = _storage.ref().child(
          'recognition_images/${userNameOrUid}_${DateTime.now().millisecondsSinceEpoch}.jpg');

      final uploadTask = await ref.putFile(imageFile);
      return await uploadTask.ref.getDownloadURL();
    } catch (e) {
      showErrorDialog(
          context, 'Failed to upload image to Firebase Storage: $e');
      return null;
    }
  }

  Future<void> _savePathToFirestore(String imageUrl) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({'recognition_path': imageUrl});
      }
    } catch (e) {
      showErrorDialog(context, 'Error saving path to Firestore: $e');
    }
  }

  String getAgeRange(String age) {
    switch (age) {
      case "0":
        return 'Children (0-12 years)';
      case "1":
        return 'Teenagers (13-20 years)';
      case "2":
        return 'Young Adults (21-30 years)';
      case "3":
        return 'Adults (31-40 years)';
      case "4":
        return 'Middle-Aged Adults (41-50 years)';
      case "5":
        return 'Elderly Adults (51+ years)';
      default:
        return 'Unknown Age Range';
    }
  }

  Future<void> _processAndUploadImage(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final imageFile = File(widget.imagePath);
      final firebaseUrl = await _uploadToFirebaseStorage(imageFile);

      if (firebaseUrl != null) {
        await _savePathToFirestore(firebaseUrl);

        // Dapatkan prediksi usia dari API Flask
        final agePrediction = await _getAgePredictionFromAPI(firebaseUrl);

        if (agePrediction != null) {
          // Perbarui kunci `age` di Firestore
          final user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .update({'age': agePrediction});

            // salin playlist
            await _playlistService.createRecommendationsPlaylist(
                user.uid, agePrediction);
          }

          final ageRange = getAgeRange(agePrediction);

          // Tampilkan hasil prediksi
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text('Age Prediction'),
              content: Text(
                  'Successfully determined age: $ageRange. Please click OK to see your playlist.'),
              actions: [
                TextButton(
                  onPressed: () => // Close the dialog
                      Navigator.pushNamed(context, '/recommendation'),
                  child: Text('OK'),
                ),
              ],
            ),
          );
        }
      }
    } catch (e) {
      showErrorDialog(context, 'Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<String?> _getAgePredictionFromAPI(String imageUrl) async {
    try {
      final response = await http.post(
        Uri.parse('https://soundfit-ml.et.r.appspot.com/age_detection'),  
        // Uri.parse('http://192.168.229.237:5000/age_detection'),
        // Ganti dengan URL Flask Anda
        body: {'recognition_path': imageUrl},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['predicted_age'] == 6) {
          showErrorDialog(context, 'Face not detected.');
          return null;
        } else if (data['predicted_age'] != null) {
          return data['predicted_age'].toString();
        } else {
          showErrorDialog(context,
              'Age prediction error: ${data['error'] ?? 'Unknown error'}');
          return null;
        }
      } else {
        showErrorDialog(context, 'Failed to fetch age prediction.');
        return null;
      }
    } catch (e) {
      showErrorDialog(context, 'Error fetching age prediction: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title:
                TitleText(text: 'Fit My Playlist', textAlign: TextAlign.center),
            backgroundColor: Colors.white,
          ),
          body: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Display the captured image
                SizedBox(
                  height: screenHeight * 0.68,
                  child: Image.file(File(widget.imagePath)),
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
                            _processAndUploadImage(context);
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
        ),
        if (_isLoading)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}
