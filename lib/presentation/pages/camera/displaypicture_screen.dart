import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:soundfit/common/widgets/text/based_text.dart';
import 'dart:io';
import 'package:soundfit/common/widgets/text/title_text.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class DisplayPictureScreen extends StatefulWidget {
  final String imagePath;

  DisplayPictureScreen({super.key, required this.imagePath});

  @override
  _DisplayPictureScreenState createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
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

        return userDoc.data()?['name'] ?? user.uid; // Gunakan nama atau UID
      }
    } catch (e) {
      print('Error getting user name: $e');
    }
    return null; // Fallback jika terjadi error
  }

  Future<String?> _uploadToFirebaseStorage(File imageFile) async {
    try {
      final userNameOrUid = await _getUserNameOrUid();

      if (userNameOrUid == null) {
        throw Exception('Failed to retrieve user information.');
      }

      final ref = _storage.ref().child(
          'recognition_images/${userNameOrUid}_${DateTime.now().millisecondsSinceEpoch}.jpg');

      final uploadTask = await ref.putFile(imageFile);
      return await uploadTask.ref.getDownloadURL();
    } catch (e) {
      throw FirebaseException(
          plugin: 'firebase_storage',
          message: 'Failed to upload to Firebase Storage: $e');
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
      print('Error saving path to Firestore: $e');
      throw Exception('Failed to save image path to Firestore.');
    }
  }

  // Future<void> _processAndUploadImage(BuildContext context) async {
  //   setState(() {
  //     _isLoading = true;
  //   });

  //   try {
  //     // Check if the user is authenticated
  //     FirebaseAuth auth = FirebaseAuth.instance;
  //     User? user = auth.currentUser;

  //     if (user == null) {
  //       // Show error dialog if not authenticated
  //       showDialog(
  //         context: context,
  //         builder: (_) => AlertDialog(
  //           title: Text('Error'),
  //           content: Text('Please log in to upload images.'),
  //           actions: [
  //             TextButton(
  //               onPressed: () => Navigator.pop(context),
  //               child: Text('OK'),
  //             ),
  //           ],
  //         ),
  //       );
  //       return; // Return early as the user is not authenticated
  //     }

  //     // User is authenticated, proceed with the image upload
  //     final imageFile = File(widget.imagePath);

  //     // Upload to Firebase Storage
  //     final firebaseUrl = await _uploadToFirebaseStorage(imageFile);

  //     if (firebaseUrl != null) {
  //       // Save URL to Firestore
  //       await _savePathToFirestore(firebaseUrl);

  //       // Navigate to the recommendation screen
  //       Navigator.pushNamed(context, '/recommendation');
  //     }
  //   } catch (e) {
  //     // Handle errors appropriately
  //     showDialog(
  //       context: context,
  //       builder: (_) => AlertDialog(
  //         title: Text('Error'),
  //         content: Text('Failed to process image: $e'),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.pop(context),
  //             child: Text('OK'),
  //           ),
  //         ],
  //       ),
  //     );
  //   } finally {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }

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
          }

          // Tampilkan hasil prediksi
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text('Age Prediction'),
              content: Text('Predicted Age: $agePrediction'),
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
      print('Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<String?> _getAgePredictionFromAPI(String imageUrl) async {
    try {
      final response = await http.post(
        Uri.parse(
            'http://192.168.1.3:5000/age_detection'), // Ganti dengan URL Flask Anda
        body: {'recognition_path': imageUrl},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['predicted_age'] != null) {
          return data['predicted_age'].toString();
        } else {
          throw Exception(data['error'] ?? 'Prediction error');
        }
      } else {
        throw Exception('Failed to fetch prediction');
      }
    } catch (e) {
      print('Error fetching age prediction: $e');
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
