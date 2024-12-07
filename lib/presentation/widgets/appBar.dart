import 'package:flutter/material.dart';
import 'package:soundfit/common/widgets/text/title_text.dart';
import 'package:soundfit/core/configs/theme/app_colors.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final bool backButton;

  const CustomAppBar({
    Key? key,
    required this.title,
    required this.backButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: TitleText(text: title, textAlign: TextAlign.center),
      backgroundColor: AppColors.white,
      automaticallyImplyLeading: backButton,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
