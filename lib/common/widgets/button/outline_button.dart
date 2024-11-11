import 'package:flutter/material.dart';

class OutlineButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final Color outlineColor;
  final Color textColor;
  const OutlineButton(
      {required this.onPressed,
      required this.title,
      required this.outlineColor,
      required this.textColor,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(15.0), // Set the corner radius here
        ),
        side: BorderSide(
            color: outlineColor), // Optional: set the border color
      ),
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
