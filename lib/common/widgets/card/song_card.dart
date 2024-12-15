import 'package:flutter/material.dart';
import 'package:soundfit/core/configs/theme/app_colors.dart';
import 'package:soundfit/presentation/pages/playMusic.dart';

class SongCard extends StatelessWidget {
  final String songTitle;
  final String artistName;
  final String coverImage;
  final String musicId;

  const SongCard(
      {Key? key,
      required this.songTitle,
      required this.artistName,
      required this.coverImage,
      required this.musicId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.all(8),
      ),
      onPressed: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlayMusic(
              musicId: musicId,
            ),
          ),
        )
      },
      child: Column(
        children: [
          Container(
            width: 140,
            height: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                image: coverImage != null
                    ? NetworkImage(coverImage!)
                    : AssetImage('assets/images/nullSongCover.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 140,
            child: Text(
              songTitle,
              style: TextStyle(
                  color: AppColors.black, fontWeight: FontWeight.w900),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            artistName,
            style: TextStyle(color: AppColors.black, fontSize: 12),
          )
        ],
      ),
    );
  }
}
