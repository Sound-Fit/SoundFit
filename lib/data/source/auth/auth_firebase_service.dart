import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:soundfit/data/models/auth/create_user_req.dart';
import 'package:soundfit/data/models/auth/signin_user_req.dart';

abstract class AuthFirebaseService {
  Future<Either> signup(CreateUserReq createUserReq);

  Future<Either> signin(SignInUserReq signInUserReq);

  // Future<Either<String, void>> signout();
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<Either> signup(CreateUserReq createUserReq) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: createUserReq.email, 
          password: createUserReq.password
      );
      
      return const Right("Signup Success");

    } on FirebaseAuthException catch (e) {
      String message = '';

      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      }

      return Left(message);
    }
  }

  @override
  Future<Either> signin(SignInUserReq signInUserReq) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: signInUserReq.email, 
          password: signInUserReq.password
      );
      
      return const Right("Signin Success");

    } on FirebaseAuthException catch (e) {
      String message = '';

      if (e.code == 'invalid-email') {
        message = 'Not user found for that email.';
      } else if (e.code == 'invalid-credential') {
        message = 'Wrong password provided for that user.';
      }

      return Left(message);
    }
  }

  // @override
  // Future<Either<String, String>> signout() async {
  //   try {
  //     await FirebaseAuth.instance.signOut();
  //     return const Right("Signout Success");
  //   } catch (e) {
  //     return Left("Failed to sign out. Please try again.");
  //   }
  // }
}
