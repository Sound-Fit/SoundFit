import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soundfit/common/widgets/card/song_card.dart';
import 'package:soundfit/presentation/pages/playMusic.dart';

class PlaylistScreen extends StatefulWidget {
  final String playlistId;

  const PlaylistScreen({Key? key, required this.playlistId}) : super(key: key);

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Playlist'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('playlists')
            .doc(widget.playlistId)
            .collection('songs')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No songs in this playlist'));
          }

          final songs = snapshot.data!.docs;

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
            ),
            itemCount: songs.length,
            itemBuilder: (context, index) {
              final song = songs[index];
              return SongCard(
                songTitle: song['songTitle'],
                artistName: song['artistName'],
                coverImage: song['coverImage'],
                onPressed: () {
                  // Navigate to PlayMusic screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlayMusic(
                        musicId:
                            song.id, // Use Firestore document ID as musicId
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
