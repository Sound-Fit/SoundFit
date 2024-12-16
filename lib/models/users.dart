class Users {
  String? age;
  String email;
  String username;
  String? profilePath;
  String? recognitionPath;
  List<String>? playlistIds;

  Users(
      {this.age,
      required this.email,
      required this.username,
      this.profilePath,
      this.recognitionPath,
      this.playlistIds});
}
