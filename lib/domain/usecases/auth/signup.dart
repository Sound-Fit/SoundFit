import 'package:dartz/dartz.dart';
import 'package:soundfit/core/usecase/usecase.dart';
import 'package:soundfit/data/models/auth/create_user_req.dart';
import 'package:soundfit/domain/repository/auth/auth.dart';
import 'package:soundfit/service_locator.dart';

// kalau req berhasil maka akan mengembalikan nilai Either.right
// kalau gagal maka akan mengembalikan nilai Either.left
class SignupUseCase implements UseCase<Either, CreateUserReq> {
  
  @override
  Future<Either> call({CreateUserReq ? params}) async {
    return sl<AuthRepository>().signup(params!);
  }

  @override
  Future<Either> execute(CreateUserReq params) async {
    return sl<AuthRepository>().signup(params);
  }
}