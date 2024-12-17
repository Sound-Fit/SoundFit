import 'package:flutter/material.dart';
import 'package:soundfit/common/widgets/button/song_button.dart';
import 'package:soundfit/core/services/song_service.dart';
import 'package:soundfit/data/models/songs.dart';

class SongLists extends StatefulWidget {
  final List<String> songIds; // Menerima list songIds
  const SongLists({super.key, required this.songIds});

  @override
  State<SongLists> createState() => _SongListsState();
}

class _SongListsState extends State<SongLists> {
  final SongService _songService = SongService(); // Instansiasi SongService

  // Fungsi untuk mendapatkan informasi lengkap lagu berdasarkan songIds
  Future<List<Songs>> _getFullSongInfoFromIds(List<String> songIds) async {
    // Ambil trackIds dari songIds
    List<String?> trackIds = await Future.wait(
        songIds.map((songId) async => await _songService.getTrackIdFromSongId(songId)));

    // Hapus nilai null dan ambil hanya trackIds yang valid
    trackIds = trackIds.whereType<String>().toList();

    // Ambil informasi lagu berdasarkan trackIds
    final songs = await _songService.getSongsInfoFromTrackIds(trackIds.whereType<String>().toList());
    return songs.whereType<Songs>().toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Songs>>(
      future: _getFullSongInfoFromIds(widget.songIds), // Mengambil informasi lagu dari songIds
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
        final maxSongs = songs.length > 15 ? 15 : songs.length;

        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(), // Non-scrollable
          shrinkWrap: true, // Ensure it wraps content dynamically
          itemCount: maxSongs,
          itemBuilder: (context, index) {
            final song = songs[index];
            return SongButton(
              songTitle: song.songTitle ?? 'Unknown Title',
              artistName: song.artistName ?? 'Unknown Artist',
              coverImage: song.coverImage ?? '',
              year: song.year ?? '',
              musicId: song.trackId,
            );
          },
        );
      },
    );
  }
}