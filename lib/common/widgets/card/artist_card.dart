import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:soundfit/common/widgets/text/based_text.dart';
import 'package:soundfit/core/configs/theme/app_colors.dart';

class ArtistCard extends StatelessWidget {
  final String title;
  final Image image;
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
      child: Row(children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              color: Colors.white, // Warna latar belakang untuk kontras
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.1), // Warna bayangan
                  spreadRadius: 2, // Seberapa jauh bayangan menyebar
                  blurRadius: 3, // Ketajaman bayangan
                ),
              ],
              borderRadius: BorderRadius.circular(25.0)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25.0),
            child: Image.asset('assets/images/Artist.jpg'),
          ),
        ),
        Gap(15),
        BasedText(text: title),
      ]),
    );
  }
}
