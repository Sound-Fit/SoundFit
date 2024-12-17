import 'package:flutter/material.dart';
import 'package:soundfit/common/widgets/card/song_card.dart';
import 'package:soundfit/core/services/song_service.dart';
import 'package:soundfit/data/models/songs.dart';

class SongCardlist extends StatefulWidget {
  const SongCardlist({super.key});

  @override
  State<SongCardlist> createState() => _SongCardlistState();
}

class _SongCardlistState extends State<SongCardlist> {
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

        // Get the list of songs and shuffle it
        final songs = snapshot.data!;
        songs.shuffle(); // Randomize the order of the songs

        return SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: songs.length,
            itemBuilder: (context, index) {
              final song = songs[index];
              return SongCard(
                  songTitle: song.songTitle ?? 'Unknown Title',
                  artistName: song.artistName ?? 'Unknown Artist',
                  coverImage: song.coverImage ?? '',
                  musicId: song.trackId);
            },
          ),
        );
      },
    );
  }
}
