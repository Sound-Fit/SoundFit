import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:soundfit/common/widgets/text/based_text.dart';

class ArtistList extends StatelessWidget {
  final String artistName;
  final String artistImage;
  // final VoidCallback onPressed;

  const ArtistList({
    Key? key,
    required this.artistName,
    required this.artistImage,
    // required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.only(left: 3),
        ),
        onPressed: () {},
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage:
                  artistImage != null ? NetworkImage(artistImage!) : null,
              radius: 35,
            ),
            Gap(2),
            SizedBox(
              width: 80,
              child: BasedText(
                text: artistName,
                fontSize: 10,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ));
  }
}
