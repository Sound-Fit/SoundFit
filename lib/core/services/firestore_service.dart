import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Sends the recognition path to Firestore
  Future<void> sendRecognitionPath(String recognitionPath) async {
    try {
      await _firestore.collection('requests').add({
        'recognition_path': recognitionPath,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to send recognition path to Firestore: $e');
    }
  }

  /// Retrieves user data from Firestore by user ID
  Future<DocumentSnapshot<Map<String, dynamic>>> getUser(String? userId) async {
    if (userId == null || userId.isEmpty) {
      throw Exception('User ID cannot be null or empty');
    }

    try {
      return await _firestore.collection('users').doc(userId).get();
    } catch (e) {
      throw Exception('Failed to retrieve user data: $e');
    }
  }
}
