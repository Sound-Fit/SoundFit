import 'package:flutter/material.dart';

class PlaylistImage extends StatelessWidget {
  final String title;
  const PlaylistImage({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (title) {
      case 'Recommendations':
        return Image.asset('assets/images/recommendations.png');
      case 'Liked Songs':
        return Image.asset('assets/images/liked.png');
      default:
        return Image.asset('assets/images/playlist.png');
    }
  }
}
