import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:soundfit/domain/entities/song/song.dart';

abstract class SongFirebaseService {
  Future<Either> getNewsSongs();
}

class SongFirebaseServiceImpl implements SongFirebaseService {
  @override
  Future<Either> getNewsSongs() async {
    try {
      List<SongModel> songs = [];
      var data = await FirebaseFirestore.instance
          .collection('songs')
          .orderBy('released', descending: true)
          .limit(30)
          .get();

      for (var doc in data.docs) {
        var songModel = SongModel.fromJSON(doc.data());
        songs.add(songModel.toEntity());
      }
      return Right(songs);
    } catch (e) {
      return left('An error occured while fetching songs');
    }
  }
}
