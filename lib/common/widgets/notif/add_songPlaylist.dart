import 'package:flutter/material.dart';
import 'package:soundfit/core/services/playlist_service.dart';

class AddSongPlaylist extends StatefulWidget {
  final String songId;
  final String userId;

  const AddSongPlaylist({
    Key? key,
    required this.songId,
    required this.userId,
  }) : super(key: key);

  @override
  State<AddSongPlaylist> createState() => _AddSongPlaylistState();
}

class _AddSongPlaylistState extends State<AddSongPlaylist> {
  final PlaylistService _playlistService = PlaylistService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _playlistService.getUserPlaylists(widget.userId),
      builder: (context, snapshot) {
        // Menampilkan indikator loading saat data sedang diambil
        if (snapshot.connectionState == ConnectionState.waiting) {
          return AlertDialog(
            title: const Text('Loading Playlists'),
            content: Center(child: CircularProgressIndicator()),
          );
        }

        // Menangani error jika data gagal diambil
        if (snapshot.hasError) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text(
                'Failed to fetch playlists. Please try again later.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          );
        }

        final playlists = snapshot.data ?? [];

        return AlertDialog(
          title: const Text('Select Playlist'),
          content: playlists.isEmpty
              ? const Text(
                  'You have no playlists. Create one to add this song.')
              : SizedBox(
                  width: double.maxFinite,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: playlists.length,
                    itemBuilder: (context, index) {
                      final playlist = playlists[index];
                      return ListTile(
                        title: Text(playlist['name']),
                        onTap: () async {
                          final playlistId =
                              await _playlistService.getPlaylistIdFromName(
                                  playlist['name'], widget.userId);

                          if (playlistId != null) {
                            // Lakukan sesuatu dengan playlistId (misalnya, tambahkan lagu ke playlist)
                            await _playlistService.addSongToPlaylist(
                                playlistId, widget.songId);
                            Navigator.pop(context);
                          } else {
                            // Handle case when playlist is not found
                            print("Playlist not found.");
                          }
                        },
                      );
                    },
                  ),
                ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
