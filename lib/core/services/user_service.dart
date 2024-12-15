import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  // Function to get the current user's UID
  Future<String?> getUserUid() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Return the current user's UID
        return user.uid;
      } else {
        // User is not authenticated
        print('No user is currently logged in.');
        return null;
      }
    } catch (e) {
      print('Error getting user UID: $e');
      return null; // Fallback in case of an error
    }
  }

}
