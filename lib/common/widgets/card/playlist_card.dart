import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:soundfit/common/widgets/text/based_text.dart';
import 'package:soundfit/core/configs/theme/app_colors.dart';

class PlaylistCard extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const PlaylistCard({Key? key, required this.title, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 3.0),
      child: Column(
        children: [
          TextButton(
            onPressed: onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  SizedBox(
                    width: 45,
                    height: 45,
                    child: Image.asset('assets/images/playlist.png'),
                    // child: ClipRRect(
                    //   borderRadius: BorderRadius.circular(8),
                    // ),
                  ),
                  Gap(15),
                  BasedText(
                    text: title,
                    fontWeight: FontWeight.bold,
                  ),
                ]),
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.black,
                  size: 16,
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
