import 'package:get_it/get_it.dart';
import 'package:soundfit/data/repository/auth/auth_repository_impl.dart';
import 'package:soundfit/data/source/auth/auth_firebase_service.dart';
import 'package:soundfit/domain/repository/auth/auth.dart';
import 'package:soundfit/domain/usecases/auth/signin.dart';
import 'package:soundfit/domain/usecases/auth/signup.dart';

final sl = GetIt.instance; // Service Locator

Future<void> initializeDependencies() async {
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<SignupUseCase>(SignupUseCase());
  sl.registerSingleton<SigninUseCase>(SigninUseCase());
}
