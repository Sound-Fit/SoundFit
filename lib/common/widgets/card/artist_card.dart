import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:soundfit/common/widgets/text/based_text.dart';
import 'package:soundfit/core/configs/theme/app_colors.dart';

class ArtistCard extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback onPressed;

  const ArtistCard(
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
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 3,
                ),
              ],
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(image),
              radius: 25,
            ),
          ),
          const Gap(15),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: BasedText(text: title),
          )
        ],
      ),
    );
  }
}
