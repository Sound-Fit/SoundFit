import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soundfit/common/widgets/card/playlist_card.dart';
import 'package:soundfit/common/widgets/text/title_text.dart';
import 'package:soundfit/core/services/playlist_service.dart';
import 'package:soundfit/presentation/pages/playlist/playlist_detail.dart';

class Playlist extends StatefulWidget {
  const Playlist({super.key});

  @override
  State<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  final PlaylistService _playlistService = PlaylistService();
  late Future<List<Map<String, dynamic>>> _playlistsFuture;
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _playlistsFuture = _fetchPlaylists();
  }

  Future<List<Map<String, dynamic>>> _fetchPlaylists() async {
    try {
      // Fetch playlists associated with the current user
      final userRef =
          FirebaseFirestore.instance.collection('users').doc(user?.uid);
      final userSnapshot = await userRef.get();

      if (!userSnapshot.exists) {
        return [];
      }

      final userData = userSnapshot.data();
      final playlistIds = List<String>.from(userData?['playlistIds'] ?? []);

      // Fetch playlists by IDs
      final playlistSnapshots = await Future.wait(
        playlistIds.map((playlistId) => FirebaseFirestore.instance
            .collection('playlists')
            .doc(playlistId)
            .get()),
      );

      // Extract data from each playlist snapshot
      return playlistSnapshots
          .where((snapshot) => snapshot.exists)
          .map((snapshot) {
        final playlistData = snapshot.data();
        return {
          'id': snapshot.id,
          'name': playlistData?['name'] ?? 'Unnamed Playlist',
          'image': playlistData?['image'] ?? 'assets/images/SongCover.jpg',
        };
      }).toList();
    } catch (e) {
      print("Error fetching playlists: $e");
      return [];
    }
  }

  void _createNewPlaylist() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String playlistName = '';
        return AlertDialog(
          title: Text('Create New Playlist'),
          content: TextField(
            onChanged: (value) {
              playlistName = value;
            },
            decoration: InputDecoration(hintText: "Enter playlist name"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Create'),
              onPressed: () async {
                if (playlistName.isNotEmpty) {
                  if (user != null) {
                    await _playlistService.createPlaylist(
                        user!.uid, playlistName);
                  }
                  setState(() {
                    _playlistsFuture =
                        _fetchPlaylists(); // Refresh playlist after creation
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: TitleText(text: "Playlist", textAlign: TextAlign.center)),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              size: 30,
              color: Colors.black,
            ),
            onPressed: _createNewPlaylist, // Handle playlist creation
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _playlistsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                  child: Text("Error loading playlists: ${snapshot.error}"));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No playlists found."));
            }

            final playlists = snapshot.data!;
            return ListView.builder(
              itemCount: playlists.length,
              itemBuilder: (context, index) {
                final playlist = playlists[index];
                return PlaylistCard(
                  title: playlist['name'],
                  onPressed: () {
                    // Handle navigation to the playlist
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PlaylistDetailPage(
                                playlistId: playlist['id'])));
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
