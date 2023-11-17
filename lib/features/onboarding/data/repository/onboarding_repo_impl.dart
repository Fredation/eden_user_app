import 'package:dartz/dartz.dart';
import 'package:eden_user_app/core/error/failure.dart';
import 'package:eden_user_app/features/onboarding/data/datasources/onboarding_ds.dart';
import 'package:eden_user_app/features/onboarding/domain/repository/onboarding_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OnboardingRepoImpl implements OnboardingRepo {
  final OnboardingDS datasource;
  OnboardingRepoImpl(this.datasource);

  @override
  Future<Either<Failure, User?>> signInWithEmail(
      Map<String, dynamic> data) async {
    try {
      final res = await datasource.signInWithEmail(data);
      return Right(res);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User?>> signInWithGithub() async {
    try {
      final res = await datasource.signInWithGithub();
      return Right(res);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User?>> signInWithGoogle() async {
    try {
      final res = await datasource.signInWithGoogle();
      return Right(res);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
