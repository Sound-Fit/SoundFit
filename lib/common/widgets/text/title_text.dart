import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final FontWeight fontWeight;
  const TitleText({required this.text, required this.textAlign, this.fontWeight = FontWeight.w900, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: "LexendGiga",
        fontSize: 24,
        fontWeight: fontWeight,
        color: Colors.black,
      ),
    );
  }
}
