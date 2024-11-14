import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

// This function initializes Firebase and sets up Firebase Storage with a custom bucket
Future<FirebaseStorage> initializeFirebase() async {
  await Firebase.initializeApp();
  FirebaseStorage _storage = FirebaseStorage.instanceFor(
    app: Firebase.app(),
    bucket: 'gs://soundfit-bfedd.firebasestorage.app', // Specify your bucket
  );
  return _storage;
}
