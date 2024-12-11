import 'package:flutter/material.dart';
import 'package:soundfit/common/widgets/button/song_button.dart';
import 'package:soundfit/core/services/song_service.dart';
import 'package:soundfit/models/songs.dart';
import 'package:soundfit/presentation/pages/playMusic.dart';

class SongLists extends StatefulWidget {
  const SongLists({super.key});

  @override
  State<SongLists> createState() => _SongListsState();
}

class _SongListsState extends State<SongLists> {
  final SongService _songService = SongService();
  late Future<List<Songs>> _songsFuture;

  @override
  void initState() {
    super.initState();
    _songsFuture = _songService.fetchSongsInformation();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Songs>>(
      future: _songsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Failed to load songs: ${snapshot.error}"),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No songs found."));
        }

        final songs = snapshot.data!;
        final maxSongs = songs.length > 10 ? 10 : songs.length;

        return ListView.builder(
          shrinkWrap:
              true, // Avoid unnecessary scrolling when used inside a Column
          itemCount: maxSongs, // Limit to 10 items
          itemBuilder: (context, index) {
            final song = songs[index];
            return SongButton(
              songTitle: song.songTitle ?? 'Unknown Title',
              artistName: song.artistName ?? 'Unknown Artist',
              coverImage: song.coverImage ?? '',
              year: song.year ?? '',
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlayMusic(
                      musicId: song.trackId,
                    ),
                  ),
                )
              },
            );
          },
        );
      },
    );
  }
}
