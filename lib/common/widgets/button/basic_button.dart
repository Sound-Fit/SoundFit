import 'package:flutter/material.dart';

class BasicButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final Color bgColor;
  final Color textColor;
  const BasicButton(
      {required this.onPressed,
      required this.title,
      required this.bgColor,
      required this.textColor,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(bgColor),
          shape: WidgetStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0)))),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(
          title,
          style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              fontFamily: 'LexendGiga'),
        ),
      ),
    );
  }
}
