import 'package:cloud_firestore/cloud_firestore.dart';

class SongModel {
  // final String id;
  String ? song_title;
  // String ? artist;
  num ? duration;
  num ? released;
  String ? cover_path;
  String ? song_path;


  SongModel({
    // required this.id,
    required this.song_title,
    // required this.artist,
    required this.duration,
    required this.released,
    required this.cover_path,
    required this.song_path,
  });

  SongModel.fromJSON(Map<String, dynamic> data)
      : song_title = data['song_title'],
        // artist = data['artist'],
        duration = data['duration'],
        released = data['released'],
        cover_path = data['cover_path'],
        song_path = data['song_path'];
}

extension SongModelX on SongModel {
  SongModel toEntity() {
    return SongModel(
      song_title: song_title,
      // artist: artist,
      duration: duration,
      released: released,
      cover_path: cover_path,
      song_path: song_path,
    );
  }
}
