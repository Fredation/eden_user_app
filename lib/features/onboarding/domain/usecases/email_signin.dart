import 'package:dartz/dartz.dart';
import 'package:eden_user_app/core/error/failure.dart';
import 'package:eden_user_app/core/usecases/usecase.dart';
import 'package:eden_user_app/features/onboarding/domain/repository/onboarding_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmailSignInUsecase extends UseCase<User?, EmailSignInParams> {
  final OnboardingRepo repository;

  EmailSignInUsecase(this.repository);

  @override
  Future<Either<Failure, User?>> call(EmailSignInParams params) {
    return repository.signInWithEmail({
      "email": params.email,
      "password": params.password,
    });
  }
}

class EmailSignInParams {
  final String email;
  final String password;

  EmailSignInParams({
    required this.email,
    required this.password,
  });
}
