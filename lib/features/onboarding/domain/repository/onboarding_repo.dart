import 'package:dartz/dartz.dart';
import 'package:eden_user_app/core/error/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class OnboardingRepo {
  Future<Either<Failure, User?>> signInWithEmail(Map<String, dynamic> data);
  Future<Either<Failure, User?>> signInWithGoogle();
  Future<Either<Failure, User?>> signInWithGithub();
}
