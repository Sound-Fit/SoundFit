import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add a new playlist to Firestore
  Future<void> addSongToPlaylist(
      String playlistId, Map<String, dynamic> songData) async {
    try {
      await _firestore
          .collection('playlists')
          .doc(playlistId)
          .collection('songs')
          .add(songData);
      print('Song added to playlist successfully');
    } catch (e) {
      print('Failed to add song to playlist: $e');
    }
  }
}
