// import 'dart:io';
// import 'package:path/path.dart' show join;
// import 'package:camera/camera.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart';
// import 'dart:convert';

// class CameraService {
//   final FirebaseStorage _storage = FirebaseStorage.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
  
//   Future<String> _getAuthToken() async {
//     final user = _auth.currentUser;
//     if (user == null) {
//       throw UnauthorizedException('No authenticated user found');
//     }
    
//     final token = await user.getIdToken();
//     if (token == null) {
//       throw UnauthorizedException('Failed to get user token');
//     }
    
//     return token;
//   }
  
//   Future<File> _saveImageLocally(XFile imageFile) async {
//     final appDir = await getApplicationDocumentsDirectory();
//     final fileName = 'IMG_${DateTime.now().millisecondsSinceEpoch}.jpg';
//     final filePath = join(appDir.path, fileName);
    
//     // Save the file to local storage
//     await imageFile.saveTo(filePath);
//     return File(filePath);
//   }
  
//   Future<String?> _uploadToFirebaseStorage(File imageFile) async {
//     try {
//       final ref = _storage.ref().child(
//         'images/${DateTime.now().millisecondsSinceEpoch}.jpg'
//       );
      
//       final uploadTask = await ref.putFile(imageFile);
//       return await uploadTask.ref.getDownloadURL();
//     } catch (e) {
//       throw StorageException('Failed to upload to Firebase Storage: $e');
//     }
//   }
  
//   Future<Map<String, dynamic>> uploadToServer(
//     File imageFile,
//     String serverUrl,
//   ) async {
//     if (!imageFile.existsSync()) {
//       throw FileSystemException(
//         'File does not exist at path: ${imageFile.path}'
//       );
//     }

//     final token = await _getAuthToken();
//     final uri = Uri.parse(serverUrl);
//     final request = http.MultipartRequest('POST', uri);

//     try {
//       // Add the image file to the request
//       request.files.add(await http.MultipartFile.fromPath(
//         'image',
//         imageFile.path,
//         contentType: MediaType('image', 'jpeg'),
//       ));
      
//       // Add authorization header
//       request.headers['Authorization'] = 'Bearer $token';
      
//       // Send the request
//       final streamedResponse = await request.send();
//       final response = await http.Response.fromStream(streamedResponse);
      
//       if (response.statusCode == 200) {
//         return jsonDecode(response.body);
//       } else {
//         throw ApiException(
//           'Server error: ${response.statusCode}\n${response.body}'
//         );
//       }
//     } catch (e) {
//       throw ApiException('Failed to upload image: $e');
//     }
//   }
  
//   Future<CameraResult> takePicture(
//     CameraController controller,
//     String serverUrl,
//   ) async {
//     try {
//       // Ensure controller is initialized
//       if (!controller.value.isInitialized) {
//         throw CameraException('Camera not initialized');
//       }
      
//       // Take the picture
//       final XFile imageFile = await controller.takePicture();
      
//       // Save locally
//       final File savedFile = await _saveImageLocally(imageFile);
      
//       // Upload to Firebase Storage
//       final String? firebaseUrl = await _uploadToFirebaseStorage(savedFile);
      
//       // Upload to custom server
//       final serverResponse = await uploadToServer(savedFile, serverUrl);
      
//       return CameraResult(
//         localFile: savedFile,
//         firebaseUrl: firebaseUrl,
//         serverResponse: serverResponse,
//       );
//     } catch (e) {
//       throw CameraOperationException('Failed to process image: $e');
//     }
//   }
// }

// // Custom exceptions for better error handling
// class UnauthorizedException implements Exception {
//   final String message;
//   UnauthorizedException(this.message);
//   @override
//   String toString() => 'UnauthorizedException: $message';
// }

// class StorageException implements Exception {
//   final String message;
//   StorageException(this.message);
//   @override
//   String toString() => 'StorageException: $message';
// }

// class ApiException implements Exception {
//   final String message;
//   ApiException(this.message);
//   @override
//   String toString() => 'ApiException: $message';
// }

// class CameraOperationException implements Exception {
//   final String message;
//   CameraOperationException(this.message);
//   @override
//   String toString() => 'CameraOperationException: $message';
// }

// // Result class to hold all relevant data
// class CameraResult {
//   final File localFile;
//   final String? firebaseUrl;
//   final Map<String, dynamic> serverResponse;
  
//   CameraResult({
//     required this.localFile,
//     this.firebaseUrl,
//     required this.serverResponse,
//   });
// }