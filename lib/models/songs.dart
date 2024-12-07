import 'package:flutter/material.dart';

class Songs {
  Duration? duration;
  String trackId;
  String? artistName;
  String? songTitle;
  String? coverImage;
  String? artistImage;
  Color? songColor;

  Songs(
      {this.duration,
      required this.trackId,
      this.artistName,
      this.songTitle,
      this.coverImage,
      this.artistImage,
      this.songColor});
}