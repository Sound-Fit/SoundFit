import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:soundfit/common/widgets/text/based_text.dart';
import 'package:soundfit/core/configs/theme/app_colors.dart';

class PlaylistCard extends StatelessWidget {
  final String title;
  final Image image;
  final VoidCallback onPressed;

  const PlaylistCard(
      {Key? key,
      required this.title,
      required this.image,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              SizedBox(
                width: 50,
                height: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: image,
                ),
              ),
              Gap(15),
              BasedText(
                text: title,
              ),
            ]),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.black,
              size: 16,
            ),
          ],
        ));
  }
}
