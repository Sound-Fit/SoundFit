import 'package:flutter/material.dart';

class BasedText extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;
  final double fontSize;
  final String fontFamily;
  final TextAlign textAlign;

  const BasedText(
      {required this.text,
      this.fontSize = 18,
      this.fontWeight = FontWeight.normal,
      this.fontFamily = "LexendGiga",
      this.textAlign = TextAlign.justify,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: Colors.black,
        fontFamily: fontFamily,
      ),
    );
  }
}
