import 'package:dartz/dartz.dart';
import 'package:soundfit/core/usecase/usecase.dart';
import 'package:soundfit/data/repository/song/song_repository_impl.dart';
import 'package:soundfit/service_locator.dart';

class GetNewsSongsUseCase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({params}) async {
    return sl<SongRepositoryImpl>().getNewsSongs();
  }
  
  @override
  Future<Either> execute(params) {
    return sl<SongRepositoryImpl>().getNewsSongs();
  }
}
