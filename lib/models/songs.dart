class Songs {
  Duration? duration;
  String trackId;
  String? artistName;
  String? songTitle;
  String? coverImage;
  String? artistImage;
  String? year;
  List<String>? songGenre;

  Songs(
      {this.duration,
      required this.trackId,
      this.artistName,
      this.songTitle,
      this.coverImage,
      this.artistImage,
      this.year,
      this.songGenre});
}
