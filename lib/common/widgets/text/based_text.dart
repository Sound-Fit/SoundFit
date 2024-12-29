import 'package:flutter/material.dart';

class BasedText extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;
  final double fontSize;
  final String fontFamily;
  final TextAlign textAlign;
  final bool profile;

  const BasedText(
      {required this.text,
      this.fontSize = 18,
      this.fontWeight = FontWeight.normal,
      this.fontFamily = "LexendGiga",
      this.textAlign = TextAlign.justify,
      this.profile = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      softWrap: true,
      overflow: profile ? TextOverflow.visible : TextOverflow.ellipsis,
      maxLines: profile ? 10 : 2,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: Colors.black,
        fontFamily: fontFamily,
      ),
    );
  }
}
