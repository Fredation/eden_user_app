import 'package:dartz/dartz.dart';
import 'package:eden_user_app/core/error/failure.dart';
import 'package:eden_user_app/core/usecases/usecase.dart';
import 'package:eden_user_app/features/onboarding/domain/repository/onboarding_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GoogleSignInUsecase extends UseCase<User?, NoParams> {
  final OnboardingRepo repository;

  GoogleSignInUsecase(this.repository);

  @override
  Future<Either<Failure, User?>> call(NoParams params) {
    return repository.signInWithGoogle();
  }
}
