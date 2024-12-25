import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:soundfit/common/widgets/text/based_text.dart';
import 'package:soundfit/data/models/songs.dart';
import 'package:soundfit/presentation/pages/music/playMusic.dart';

class SongButton extends StatelessWidget {
  final Songs song;
  final List<Songs> songs; // Tambahkan parameter daftar lagu
  final int index;

  const SongButton({
    Key? key,
    required this.song,
    required this.songs,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlayMusic(
              songs: songs, // Kirim daftar lagu
              index: index, // Kirim indeks
            ),
          ),
        )
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      image: song.coverImage != null
                          ? NetworkImage(song.coverImage!)
                          : AssetImage('assets/images/nullSongCover.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Gap(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 210,
                      child: Text(
                        song.songTitle ?? 'Unknown Title',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w900),
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    BasedText(
                      text: song.artistName ?? 'Unknown Artist',
                      fontSize: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
          BasedText(
            text: song.year ?? '-',
            fontSize: 10,
          ),
        ],
      ),
    );
  }
}
