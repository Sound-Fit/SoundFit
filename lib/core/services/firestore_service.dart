import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
}
