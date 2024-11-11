import 'package:dartz/dartz.dart';
import 'package:soundfit/core/usecase/usecase.dart';
import 'package:soundfit/data/models/auth/signin_user_req.dart';
import 'package:soundfit/domain/repository/auth/auth.dart';
import 'package:soundfit/service_locator.dart';

// kalau req berhasil maka akan mengembalikan nilai Either.right
// kalau gagal maka akan mengembalikan nilai Either.left
class SigninUseCase implements UseCase<Either, SignInUserReq> {
  
  @override
  Future<Either> call({SignInUserReq ? params}) async {
    return sl<AuthRepository>().signin(params!);
  }

  @override
  Future<Either> execute(SignInUserReq params) async {
    return sl<AuthRepository>().signin(params);
  }
}