import 'package:flutter/material.dart';
import 'package:soundfit/common/widgets/text/title_text.dart';
import 'package:soundfit/core/services/playlist_service.dart';
import 'package:soundfit/presentation/widgets/song/songLists.dart';

class PlaylistDetailPage extends StatefulWidget {
  final String playlistId;

  // Constructor to receive playlistId
  const PlaylistDetailPage({super.key, required this.playlistId});

  @override
  State<PlaylistDetailPage> createState() => _PlaylistDetailPageState();
}

class _PlaylistDetailPageState extends State<PlaylistDetailPage> {
  // This function will fetch songIds from Firestore based on playlistId
  Future<List<String>> _getSongIdsForPlaylist(String playlistId) async {
    // Fetch songIds from PlaylistService
    final playlistService = PlaylistService();
    return playlistService.getSongIdsFromPlaylist(playlistId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TitleText(text: 'Playlist Detail', textAlign: TextAlign.center),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0), // Padding around the content
        child: FutureBuilder<List<String>>(
          future: _getSongIdsForPlaylist(widget.playlistId), // Fetch songIds
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                  child: Text('Error loading songs: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                  child: Text('No songs available in this playlist.'));
            } else {
              final songIds = snapshot.data!;
              return SongLists(songIds: songIds); // Pass songIds to SongLists
            }
          },
        ),
      ),
    );
  }
}
