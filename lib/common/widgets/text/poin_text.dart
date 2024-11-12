import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:soundfit/common/widgets/text/based_text.dart';

class PoinText extends StatelessWidget {
  final String text;
  const PoinText({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("•"),
        Gap(10),
        Expanded(
          child: BasedText(
            text: text,
            fontSize: 14,
            fontWeight: FontWeight.normal,
            fontFamily: "Poppins",
          ),
        ),
      ],
    );
  }
}
