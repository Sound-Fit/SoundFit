import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  const TitleText({required this.text, required this.textAlign, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: "LexendGiga",
        fontSize: 24,
        fontWeight: FontWeight.w900,
        color: Colors.black,
      ),
    );
  }
}
