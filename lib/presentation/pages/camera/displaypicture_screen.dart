import 'package:flutter/material.dart';
import 'package:soundfit/common/widgets/text/based_text.dart';
import 'dart:io';
import 'package:soundfit/common/widgets/text/title_text.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:soundfit/firebase_config.dart';

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  DisplayPictureScreen({super.key, required this.imagePath});

  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> _processAndUploadImageWithAuth(BuildContext context) async {
    try {
      // Initialize Firebase Storage
      FirebaseStorage _storage = await initializeFirebase();

      // Your existing image upload code
      final imageFile = File(imagePath);
      final savedFile = await _saveImageLocally(XFile(imageFile.path));

      final ref = _storage
          .ref()
          .child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final uploadTask = await ref.putFile(savedFile);
      final firebaseUrl = await uploadTask.ref.getDownloadURL();

      // Navigate or handle the firebaseUrl
      Navigator.pushNamed(context, '/recommendation');
    } catch (e) {
      // Handle errors
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to upload image: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Future<File> _saveImageLocally(XFile imageFile) async {
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = 'IMG_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final filePath = join(appDir.path, fileName);

    // Save the file to local storage
    await imageFile.saveTo(filePath);
    return File(filePath);
  }

  Future<String?> _uploadToFirebaseStorage(File imageFile) async {
    try {
      final ref = _storage
          .ref()
          .child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');

      final uploadTask = await ref.putFile(imageFile);
      return await uploadTask.ref.getDownloadURL();
    } catch (e) {
      throw FirebaseException(
          plugin: 'firebase_storage',
          message: 'Failed to upload to Firebase Storage: $e');
    }
  }

  Future<void> _processAndUploadImage(BuildContext context) async {
    try {
      // Check if the user is authenticated
      FirebaseAuth auth = FirebaseAuth.instance;
      User? user = auth.currentUser;

      if (user == null) {
        // Show error dialog if not authenticated
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Error'),
            content: Text('Please log in to upload images.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
        return; // Return early as the user is not authenticated
      }

      // User is authenticated, proceed with the image upload
      final imageFile = File(imagePath);

      // Save the image locally
      final savedFile = await _saveImageLocally(XFile(imageFile.path));

      // Upload to Firebase Storage
      final firebaseUrl = await _uploadToFirebaseStorage(savedFile);

      // You can handle the firebaseUrl, such as saving it or navigating
      // For example, navigate to the recommendation page after the upload
      Navigator.pushNamed(context, '/recommendation');
    } catch (e) {
      // Handle errors appropriately
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to process image: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

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
                        _processAndUploadImageWithAuth(context);
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
