import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:soundfit/common/widgets/text/based_text.dart';

class SongButton extends StatelessWidget {
  final String songTitle;
  final String artistName;
  final String coverImage;
  final year;
  final VoidCallback onPressed;

  const SongButton(
      {Key? key,
      required this.songTitle,
      required this.artistName,
      required this.coverImage,
      required this.year,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
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
                      image: coverImage != null
                          ? NetworkImage(coverImage!)
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
                        songTitle,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w900),
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    BasedText(
                      text: artistName,
                      fontSize: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
          BasedText(
            text: year.toString(),
            fontSize: 10,
          ),
        ],
      ),
    );
  }
}
