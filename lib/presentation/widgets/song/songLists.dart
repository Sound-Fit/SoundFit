import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:soundfit/common/widgets/button/basic_button.dart';
import 'package:soundfit/common/widgets/button/song_button.dart';
import 'package:soundfit/core/services/song_service.dart';
import 'package:soundfit/data/models/songs.dart';
import 'package:soundfit/presentation/pages/music/playMusic.dart';

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
      future: _getFullSongInfoFromIds(
          widget.songIds), // Mengambil informasi lagu dari songIds
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

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BasicButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlayMusic(
                        songs: songs, // Kirim daftar lagu
                        index: 0, // Kirim indeks
                      ),
                    ),
                  );
                },
                title: "Play All",
                bgColor: Colors.black,
                textColor: Colors.white),
            Gap(10),
            Column(
              children: songs.asMap().entries.map((entry) {
                final index = entry.key;
                final song = entry.value;
                return SongButton(
                  song: song, // Kirim informasi lagu
                  songs: songs, // Kirim daftar lagu
                  index: index, // Kirim indeks lagu
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}
