import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:soundfit/common/widgets/text/based_text.dart';

class SongButton extends StatelessWidget {
  final String songTitle;
  final String artistName;
  final Image image;
  final year;
  final VoidCallback onPressed;

  const SongButton(
      {Key? key,
      required this.songTitle,
      required this.artistName,
      required this.image,
      required this.year,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
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
                      image: image.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Gap(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BasedText(
                      text: songTitle,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
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
