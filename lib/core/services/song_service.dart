import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soundfit/core/configs/constants/app_urls.dart';
import 'package:soundfit/models/songs.dart';
import 'package:spotify/spotify.dart';

class SongService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> getRandomMusicId() async {
    try {
      // Fetch the list of songs
      List<Songs> songs = await fetchSongsInformation();

      if (songs.isEmpty) {
        print("No songs found.");
        return null; // Return null if no songs are available
      }

      // Randomly select a song and return its trackId
      final randomIndex = Random().nextInt(songs.length);
      return songs[randomIndex].trackId;
    } catch (e) {
      print("Error fetching random music ID: $e");
      return null;
    }
  }

  Future<List<Songs>> fetchSongsInformation() async {
    final credentials =
        SpotifyApiCredentials(AppUrls.clientId, AppUrls.clientSecret);
    final spotify = SpotifyApi(credentials);

    try {
      // Fetch data from Firestore
      final QuerySnapshot snapshot = await _firestore.collection('songs').get();

      // Process each document
      return await Future.wait(snapshot.docs.map((doc) async {
        final data = doc.data() as Map<String, dynamic>;
        String trackId = data['trackId'];
        List<String> songGenre = List<String>.from(data['songGenre'] ?? []);

        // Initialize song with minimal data
        Songs song = Songs(
          trackId: trackId,
          songGenre: songGenre,
        );

        // Fetch data from Spotify API
        try {
          final track = await spotify.tracks.get(trackId);
          song.songTitle = track.name;
          song.artistName = track.artists?.first.name;
          song.coverImage = track.album?.images?.first.url;
          // Safely extract year from releaseDate
          if (track.album?.releaseDate != null) {
            final releaseDate = track.album!.releaseDate!;
            final year = releaseDate.split('-').first; // Extract year part
            song.year = year; // Assign year as string
          } else {
            song.year = null; // Handle null case
          }
        } catch (error) {
          print("Error fetching data from Spotify: $error");
        }

        return song;
      }).toList());
    } catch (e) {
      print("Error fetching songs: $e");
      throw Exception("Failed to load songs");
    }
  }

  Future<List<Songs>> fetchArtistInformation() async {
    final credentials =
        SpotifyApiCredentials(AppUrls.clientId, AppUrls.clientSecret);
    final spotify = SpotifyApi(credentials);

    try {
      // Fetch data from Firestore
      final QuerySnapshot snapshot = await _firestore.collection('songs').get();

      // Use a Set to ensure no duplicate artist IDs
      final Set<String> uniqueArtistIds = {};

      // Collect artist IDs while avoiding duplicates
      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final trackId = data['trackId'] as String?;

        if (trackId != null) {
          try {
            // Use Spotify API to fetch track details
            final track = await spotify.tracks.get(trackId);

            // Extract artist ID from track data
            final artistId = track.artists?.first.id;

            if (artistId != null) {
              uniqueArtistIds.add(artistId); // Add to set to avoid duplicates
            }
          } catch (error) {
            print("Error fetching data for track $trackId: $error");
          }
        }
      }

      // Fetch details for unique artist IDs
      final topArtistIds = uniqueArtistIds.take(10).toList(); // Limit to top 10

      // Fetch artist details from Spotify
      return await Future.wait(topArtistIds.map((artistId) async {
        Songs song = Songs(trackId: artistId);

        try {
          final artist = await spotify.artists.get(artistId);
          song.artistName = artist.name;

          if (artist.images != null && artist.images!.isNotEmpty) {
            song.artistImage = artist.images!.first.url;
          } else {
            song.artistImage = null; // Fallback if no image
          }
        } catch (error) {
          print("Error fetching data for artist $artistId: $error");
        }

        return song;
      }).toList());
    } catch (e) {
      print("Error fetching artists: $e");
      throw Exception("Failed to load top artists");
    }
  }

  // Get TrackID
  Future<String?> getTrackIdFromSongId(String songId) async {
    try {
      // Fetch the song data from Firestore using the songId
      songId = songId.toString().replaceAll(' ', '');
      final songDoc = await _firestore.collection('songs').doc(songId).get();

      if (!songDoc.exists) {
        print("Song not found.");
        return null; // Return null if song is not found
      }

      final songData = songDoc.data() as Map<String, dynamic>;
      final trackId = songData['trackId'] as String?;

      if (trackId == null) {
        print("Track ID not found for this song.");
        return null; // Return null if trackId is not available
      }

      return trackId; // Return the trackId
    } catch (e) {
      print("Error fetching trackId from songId: $e");
      return null;
    }
  }

  // Song Information from TrackId
  Future<List<Songs?>> getSongsInfoFromTrackIds(List<String> trackIds) async {
    final credentials =
        SpotifyApiCredentials(AppUrls.clientId, AppUrls.clientSecret);
    final spotify = SpotifyApi(credentials);

    try {
      // Fetch details for all trackIds
      List<Songs?> songs = await Future.wait(trackIds.map((trackId) async {
        try {
          // Fetch track data from Spotify API using the trackId
          final track = await spotify.tracks.get(trackId);

          // Initialize a new Songs object with track data
          Songs song = Songs(trackId: trackId, songGenre: []);

          // Set song details from the track data
          song.songTitle = track.name;
          song.artistName = track.artists?.first.name;
          song.coverImage = track.album?.images?.first.url;

          // Safely extract year from releaseDate
          if (track.album?.releaseDate != null) {
            final releaseDate = track.album!.releaseDate!;
            final year = releaseDate.split('-').first; // Extract year part
            song.year = year; // Assign year as string
          } else {
            song.year = null; // Handle null case
          }

          return song; // Return the populated song object
        } catch (error) {
          print(
              "Error fetching track data from Spotify for trackId $trackId: $error");
          return null; // Return null if an error occurs
        }
      }).toList());

      return songs
          .whereType<Songs>()
          .toList(); // Filter out null values and return the list of Songs
    } catch (e) {
      print("Error fetching track data for list of trackIds: $e");
      return [];
    }
  }

  // Get SongId from TrackId
  Future<String?> getSongIdFromTrackId(String trackId) async {
    try {
      // Fetch the song data from Firestore using the trackId
      final snapshot = await _firestore
          .collection('songs')
          .where('trackId', isEqualTo: trackId)
          .get();

      if (snapshot.docs.isEmpty) {
        print("Song not found for the given trackId.");
        return null; // Return null if no song is found
      }

      // Extract the songId from the first document found
      final songDoc = snapshot.docs.first;
      final songId = songDoc.id; // The Firestore document ID is the songId

      return songId; // Return the songId
    } catch (e) {
      print("Error fetching songId from trackId: $e");
      return null;
    }
  }

  // Get Song Playlist by genre
  Future<List<String>> getSongIdsByGenre(String genre) async {
    try {
      // Query Firestore collection 'songs' untuk menemukan dokumen dengan songGenre yang mengandung genre tertentu
      final QuerySnapshot snapshot = await _firestore
          .collection('songs')
          .where('songGenre',
              arrayContains: genre.toLowerCase().replaceAll(' ', ''))
          .get();

      // Jika tidak ada dokumen ditemukan, cetak pesan dan kembalikan array kosong
      if (snapshot.docs.isEmpty) {
        print("No songs found for the genre: $genre.");
        return [];
      }

      // Map dokumen menjadi list songId (Firestore document ID)
      return snapshot.docs.map((doc) => doc.id).toList();
    } catch (e) {
      // Tangani error dan cetak pesan kesalahan
      print("Error fetching songIds for genre $genre: $e");
      return [];
    }
  }
}
