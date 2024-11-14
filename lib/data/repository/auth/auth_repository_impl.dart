import 'package:dartz/dartz.dart';
import 'package:soundfit/data/models/auth/create_user_req.dart';
import 'package:soundfit/data/models/auth/signin_user_req.dart';
import 'package:soundfit/data/source/auth/auth_firebase_service.dart';
import 'package:soundfit/domain/repository/auth/auth.dart';
import 'package:soundfit/service_locator.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> signup(CreateUserReq createUserReq) async {
    return await sl<AuthFirebaseService>().signup(createUserReq);
  }

  @override
  Future<Either> signin(SignInUserReq signInUserReq) async {
    return await sl<AuthFirebaseService>().signin(signInUserReq);
  }

  // @override
  // Future<Either<String, void>> signout() async {
  //   try {
  //     await sl<AuthFirebaseService>().signout();
  //     return Right(null); // Sign-out successful
  //   } catch (error) {
  //     return Left("Failed to sign out. Please try again."); // Error message
  //   }
  // }
}
