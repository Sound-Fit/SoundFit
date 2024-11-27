import 'package:dartz/dartz.dart';
import 'package:soundfit/data/source/songs/song_firebase_service.dart';
import 'package:soundfit/domain/repository/song/song.dart';
import 'package:soundfit/service_locator.dart';

class SongRepositoryImpl extends SongsRepository {
  @override
  Future<Either> getNewsSongs() async {
    return await sl<SongFirebaseService>().getNewsSongs();
  }
  
}