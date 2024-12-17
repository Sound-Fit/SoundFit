import 'package:cloud_firestore/cloud_firestore.dart';

class PlaylistService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create New Playlist
  Future<void> createPlaylist(String userId, String playlistName) async {
    try {
      final playlistRef =
          FirebaseFirestore.instance.collection('playlists').doc();
      await playlistRef.set({
        'name': playlistName,
        'userId': userId, // ID pengguna yang membuat playlist
        'songIds': [], // Array kosong, nanti akan diisi dengan ID lagu
      });
      final playlistId = playlistRef.id;
      await savePlaylistToUser(userId, playlistId);
    } catch (e) {
      print("Error creating playlist: $e");
    }
  }

  // Save Playlist id into database
  Future<void> savePlaylistToUser(String userId, String playlistId) async {
    try {
      final userRef = _firestore.collection('users').doc(userId);
      await userRef.update({
        'playlistIds': FieldValue.arrayUnion(
            [playlistId]), // Menambah playlistId ke dalam array playlistIds
      });
    } catch (e) {
      print("Error saving playlist to user: $e");
    }
  }

  // Get user playlists
  Future<List<Map<String, dynamic>>> getUserPlaylists(String userId) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('playlists')
          .where('userId', isEqualTo: userId)
          .get();

      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print('Error fetching playlists: $e');
      return [];
    }
  }

  // Add Song to playlist
  Future<void> addSongToPlaylist(String playlistId, String songId) async {
    try {
      final playlistRef =
          FirebaseFirestore.instance.collection('playlists').doc(playlistId);
      await playlistRef.update({
        'songIds': FieldValue.arrayUnion(
            [songId]), // Menambah songId ke dalam playlist
      });
    } catch (e) {
      print("Error adding song to playlist: $e");
    }
  }

// Create Recommendation
  Future<void> createRecommendationsPlaylist(
      String userId, String sourcePlaylistId) async {
    try {
      // Get source playlist data
      sourcePlaylistId = sourcePlaylistId.trim();
      final sourcePlaylistRef =
          _firestore.collection('playlists').doc(sourcePlaylistId);
      final sourcePlaylistSnapshot = await sourcePlaylistRef.get();

      if (!sourcePlaylistSnapshot.exists) {
        print("Source playlist not found");
        return;
      }

      final sourcePlaylistData = sourcePlaylistSnapshot.data();
      final songIds = List<String>.from(sourcePlaylistData?['songIds'] ?? []);

      // Check if the 'Recommendations' playlist already exists for the user
      final recommendationsQuerySnapshot = await _firestore
          .collection('playlists')
          .where('userId', isEqualTo: userId)
          .where('name', isEqualTo: 'Recommendations')
          .get();

      if (recommendationsQuerySnapshot.docs.isEmpty) {
        // If the playlist does not exist, create a new one
        final targetPlaylistRef = _firestore.collection('playlists').doc();
        final playlistId = targetPlaylistRef.id;
        await targetPlaylistRef.set({
          'name': "Recommendations", // Name of the new playlist
          'userId': userId, // User who created the new playlist
          'songIds': songIds, // Copy songIds from the source playlist
        });

        // Save the new playlistId to the user's profile
        await savePlaylistToUser(userId, playlistId);

        print(
            "Playlist 'Recommendations' successfully created with songs from the source playlist.");
      } else {
        // If the playlist exists, update the existing one
        final existingPlaylistRef =
            recommendationsQuerySnapshot.docs.first.reference;
        await existingPlaylistRef.update({
          'songIds':
              songIds, // Update songIds with the new source playlist's songIds
        });

        print(
            "Playlist 'Recommendations' updated with songs from the source playlist.");
      }
    } catch (e) {
      print("Error creating or updating 'Recommendations' playlist: $e");
    }
  }

  // Get Song ID
  Future<List<String>> getSongIdsFromPlaylist(String playlistId) async {
    try {
      // Get playlist data from Firestore
      final playlistSnapshot =
          await _firestore.collection('playlists').doc(playlistId).get();

      if (!playlistSnapshot.exists) {
        print("Playlist not found.");
        return [];
      }

      final playlistData = playlistSnapshot.data();
      final songIds = List<String>.from(playlistData?['songIds'] ?? []);

      if (songIds.isEmpty) {
        print("No songs in this playlist.");
        return [];
      }

      return songIds; // Return the list of songIds from the playlist
    } catch (e) {
      print("Error fetching songIds from playlist: $e");
      return [];
    }
  }

  // Add Liked Song to a Playlist
  Future<void> addLikedSong(String userId, String songId) async {
    try {
      // Check if the 'Liked Songs' playlist exists
      final likedSongsQuerySnapshot = await _firestore
          .collection('playlists')
          .where('userId', isEqualTo: userId)
          .where('name', isEqualTo: 'Liked Songs')
          .get();

      if (likedSongsQuerySnapshot.docs.isEmpty) {
        // If the playlist does not exist, create a new one
        final targetPlaylistRef = _firestore.collection('playlists').doc();
        final playlistId = targetPlaylistRef.id;
        await targetPlaylistRef.set({
          'name': 'Liked Songs',
          'userId': userId,
          'songIds': [songId], // Add the liked song to the playlist
        });

        // Save the new playlistId to the user's profile
        await savePlaylistToUser(userId, playlistId);

        print("Playlist 'Liked Songs' successfully created with song.");
      } else {
        // If the playlist exists, update the existing one
        final existingPlaylistRef =
            likedSongsQuerySnapshot.docs.first.reference;
        await existingPlaylistRef.update({
          'songIds':
              FieldValue.arrayUnion([songId]), // Add the songId to the playlist
        });

        print("Playlist 'Liked Songs' updated with new song.");
      }
    } catch (e) {
      print("Error adding liked song: $e");
    }
  }

  // Get PlaylistId from PlaylistName
  Future<String?> getPlaylistIdFromName(
      String playlistName, String userId) async {
    try {
      // Fetch the playlist data from Firestore using the playlist name and userId
      final snapshot = await FirebaseFirestore.instance
          .collection('playlists')
          .where('name',
              isEqualTo:
                  playlistName) // Replace with any field that identifies the playlist
          .where('userId',
              isEqualTo: userId) // Assuming playlists are user-specific
          .get();

      if (snapshot.docs.isEmpty) {
        print("Playlist not found for the given name and userId.");
        return null; // Return null if no playlist is found
      }

      // Extract the playlistId from the first document found
      final playlistDoc = snapshot.docs.first;
      final playlistId =
          playlistDoc.id; // The Firestore document ID is the playlistId

      return playlistId; // Return the playlistId
    } catch (e) {
      print("Error fetching playlistId from playlistName: $e");
      return null;
    }
  }
}
