class Songs {
  Duration? duration;
  String trackId;
  String? artistName;
  String? songTitle;
  String? coverImage;
  String? artistImage;
  List<String>? songGenre;

  Songs(
      {this.duration,
      required this.trackId,
      this.artistName,
      this.songTitle,
      this.coverImage,
      this.artistImage,
      this.songGenre});
}
