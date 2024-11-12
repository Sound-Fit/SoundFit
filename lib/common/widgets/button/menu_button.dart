import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:soundfit/core/configs/theme/app_colors.dart';

class MenuButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final IconData icon;

  const MenuButton(
      {required this.onPressed,
      required this.title,
      required this.icon,
      double iconSize = 16,
      Key? key})
      : super(key: key);

  get iconSize => null;

  @override
  Widget build(BuildContext context) {
    Color color = title == 'Logout' || title == 'Remove Account'
        ? AppColors.red
        : AppColors.black;
    return TextButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: iconSize,
              ),
              Gap(10),
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          if (title != 'Logout')
            Icon(
              Icons.arrow_forward_ios,
              color: color,
              size: 16,
            ),
        ],
      ),
    );
  }
}
