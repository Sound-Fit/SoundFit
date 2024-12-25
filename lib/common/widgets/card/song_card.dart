import 'package:flutter/material.dart';
import 'package:soundfit/core/configs/theme/app_colors.dart';
import 'package:soundfit/data/models/songs.dart';
import 'package:soundfit/presentation/pages/music/playMusic.dart';

class SongCard extends StatelessWidget {
  final Songs song;
  final List<Songs> songs; // Tambahkan parameter daftar lagu
  final int index;

  const SongCard({
    Key? key,
    required this.song,
    required this.songs,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.all(8),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlayMusic(
              songs: songs, // Kirim daftar lagu
              index: index, // Kirim indeks
            ),
          ),
        );
      },
      child: Column(
        children: [
            Container(
              width: 140,
              height: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  image: song.coverImage != null
                      ? NetworkImage(song.coverImage!)
                      : const AssetImage('assets/images/nullSongCover.jpg')
                          as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          SizedBox(
            width: 140,
            child: Column(
              children: [
                Text(
                  song.songTitle ?? 'Unknown Title',
                  style: TextStyle(
                      color: AppColors.black, fontWeight: FontWeight.w900),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  song.artistName ?? 'Unknown Artist',
                  style: TextStyle(color: AppColors.black, fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
