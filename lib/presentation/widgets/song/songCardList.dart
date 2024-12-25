import 'package:flutter/material.dart';
import 'package:soundfit/common/widgets/card/song_card.dart';
import 'package:soundfit/core/services/song_service.dart';
import 'package:soundfit/data/models/songs.dart';

class SongCardlist extends StatefulWidget {
  final List<String> songIds; // Menerima list songIds
  const SongCardlist({super.key, required this.songIds});

  @override
  State<SongCardlist> createState() => _SongCardlistState();
}

class _SongCardlistState extends State<SongCardlist> {
  final SongService _songService = SongService();

  // Fungsi untuk mendapatkan informasi lengkap lagu berdasarkan songIds
  Future<List<Songs>> _getFullSongInfoFromIds(List<String> songIds) async {
    // Ambil trackIds dari songIds
    List<String?> trackIds = await Future.wait(songIds.map(
        (songId) async => await _songService.getTrackIdFromSongId(songId)));

    // Hapus nilai null dan ambil hanya trackIds yang valid
    trackIds = trackIds.whereType<String>().toList();

    // Ambil informasi lagu berdasarkan trackIds
    final songs = await _songService
        .getSongsInfoFromTrackIds(trackIds.whereType<String>().toList());
    return songs.whereType<Songs>().toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Songs>>(
      future: _getFullSongInfoFromIds(widget.songIds),
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
        // songs.shuffle(); // Randomize the order of the songs

        return SizedBox(
          height: 220,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: songs.asMap().entries.map((entry) {
              final index = entry.key;
              final song = entry.value;
              return SongCard(
                song: song, // Kirim informasi lagu
                songs: songs, // Kirim daftar lagu
                index: index, // Kirim indeks lagu
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
