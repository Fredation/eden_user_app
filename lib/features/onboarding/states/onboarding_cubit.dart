import 'package:eden_user_app/core/error/failure.dart';
import 'package:eden_user_app/core/usecases/usecase.dart';
import 'package:eden_user_app/features/onboarding/domain/usecases/email_signin.dart';
import 'package:eden_user_app/features/onboarding/domain/usecases/github_signin.dart';
import 'package:eden_user_app/features/onboarding/domain/usecases/google_signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_cubit.freezed.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final EmailSignInUsecase emailSignInUsecase;
  final GoogleSignInUsecase googleSignInUsecase;
  final GithubSignInUsecase githubSignInUsecase;
  OnboardingCubit({
    required this.emailSignInUsecase,
    required this.googleSignInUsecase,
    required this.githubSignInUsecase,
  }) : super(const OnboardingState());

  User? user = FirebaseAuth.instance.currentUser;

  Future<void> signInWithEmail(
      {required String email, required String password}) async {
    emit(state.copyWith(isLoading: true, error: null));
    final result = await emailSignInUsecase(
        EmailSignInParams(email: email, password: password));
    result.fold(
      (l) => emit(state.copyWith(error: l, isLoading: false)),
      (r) {
        emit(state.copyWith(data: r, isLoading: false));
      },
    );
  }

  Future<void> signInWithGoogle() async {
    emit(state.copyWith(isLoading: true, error: null));
    final result = await googleSignInUsecase(NoParams());
    result.fold(
      (l) => emit(state.copyWith(error: l, isLoading: false)),
      (r) {
        emit(state.copyWith(data: r, isLoading: false));
      },
    );
  }

  Future<void> signInWithGithub() async {
    emit(state.copyWith(isLoading: true, error: null));
    final result = await githubSignInUsecase(NoParams());
    result.fold(
      (l) => emit(state.copyWith(error: l, isLoading: false)),
      (r) {
        emit(state.copyWith(data: r, isLoading: false));
      },
    );
  }
}

@freezed
class OnboardingState with _$OnboardingState {
  const factory OnboardingState({
    @Default(false) isLoading,
    Failure? error,
    dynamic data,
  }) = _OnboardingState;
}
