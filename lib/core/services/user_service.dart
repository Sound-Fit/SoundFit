import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  /// Mendapatkan data pengguna dari Firestore
  Future<Map<String, String?>> getUserData() async {
    try {
      final user = _auth.currentUser;

      if (user == null) {
        throw FirebaseAuthException(
            code: 'user-not-logged-in', message: 'User is not logged in');
      }

      // Ambil data pengguna dari Firestore
      final userDoc = await _firestore.collection('users').doc(user.uid).get();

      if (!userDoc.exists) {
        throw FirebaseException(
          plugin: 'cloud_firestore',
          code: 'user-data-not-found',
          message: 'User data not found in Firestore',
        );
      }

      final data = userDoc.data();

      return {
        'recognitionPath': data?['recognition_path'] as String?,
        'age': data?['age'] as String?,
        'username': data?['username'] as String?,
        'email': data?['email'] as String?,
        'profilePath': data?['profile_path'] as String?,
        'recognitionPath': data?['recognition_path'] as String?,
      };
    } catch (e) {
      print('Error getting user data: $e');
      return {
        'recognitionPath': null,
        'age': null,
        'username': null,
        'email': null,
        'profilePath': null,
        'recognitionPath': null,
      };
    }
  }

  /// Menghapus data pengguna dari Firestore
  Future<bool> deleteUserData() async {
    try {
      final user = _auth.currentUser;

      if (user == null) {
        throw FirebaseAuthException(
            code: 'user-not-logged-in', message: 'User is not logged in');
      }

      // Hapus data pengguna di Firestore
      await _firestore.collection('users').doc(user.uid).delete();
      return true;
    } catch (e) {
      print('Error deleting user data: $e');
      return false;
    }
  }

  // Verif Old Password
  Future<void> reauthenticateUser(String email, String oldPassword) async {
    final user = _auth.currentUser;
    final cred =
        EmailAuthProvider.credential(email: email, password: oldPassword);
    await user!.reauthenticateWithCredential(cred);
  }

  // Update Password
  Future<void> updatePassword(String newPassword) async {
    final user = _auth.currentUser;
    await user!.updatePassword(newPassword);
  }

// Change Password
  Future<void> changeUserPassword({
    required String email,
    required String oldPassword,
    required String newPassword,
  }) async {
    await reauthenticateUser(email, oldPassword);
    await updatePassword(newPassword);
  }
}
