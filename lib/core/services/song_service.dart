import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soundfit/core/configs/constants/app_urls.dart';
import 'package:soundfit/models/songs.dart';
import 'package:spotify/spotify.dart';

class SongService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
}
