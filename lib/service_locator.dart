import 'package:get_it/get_it.dart';
import 'package:soundfit/core/services/firestore_service.dart';
import 'package:soundfit/data/repository/auth/auth_repository_impl.dart';
import 'package:soundfit/data/repository/song/song_repository_impl.dart';
import 'package:soundfit/data/source/auth/auth_firebase_service.dart';
import 'package:soundfit/data/source/songs/song_firebase_service.dart';
import 'package:soundfit/domain/repository/auth/auth.dart';
import 'package:soundfit/domain/repository/song/song.dart';
import 'package:soundfit/domain/usecases/auth/signin.dart';
import 'package:soundfit/domain/usecases/auth/signup.dart';
import 'package:soundfit/domain/usecases/song/get_news_songs.dart';

final sl = GetIt.instance; // Service Locator

Future<void> initializeDependencies() async {
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<SignupUseCase>(SignupUseCase());
  sl.registerSingleton<SigninUseCase>(SigninUseCase());

  // Song
  sl.registerSingleton<SongFirebaseService>(SongFirebaseServiceImpl());
  sl.registerSingleton<SongsRepository>(SongRepositoryImpl());
  sl.registerSingleton<GetNewsSongsUseCase>(GetNewsSongsUseCase());

  // Firestore
  sl.registerSingleton<FirestoreService>(FirestoreService());
}
