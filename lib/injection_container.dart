import 'package:eden_user_app/core/storage/storage.dart';
import 'package:eden_user_app/features/onboarding/data/datasources/onboarding_ds.dart';
import 'package:eden_user_app/features/onboarding/data/repository/onboarding_repo_impl.dart';
import 'package:eden_user_app/features/onboarding/domain/repository/onboarding_repo.dart';
import 'package:eden_user_app/features/onboarding/domain/usecases/email_signin.dart';
import 'package:eden_user_app/features/onboarding/domain/usecases/github_signin.dart';
import 'package:eden_user_app/features/onboarding/domain/usecases/google_signin.dart';
import 'package:eden_user_app/features/onboarding/states/onboarding_cubit.dart';
import 'package:eden_user_app/features/order/states/order_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<Storage>(() => StorageImpl());

  //cubits
  sl.registerFactory(
    () => OnboardingCubit(
      emailSignInUsecase: sl(),
      googleSignInUsecase: sl(),
      githubSignInUsecase: sl(),
    ),
  );
  sl.registerFactory(
    () => OrderCubit(),
  );

  //usecases
  sl.registerLazySingleton(() => EmailSignInUsecase(sl()));
  sl.registerLazySingleton(() => GoogleSignInUsecase(sl()));
  sl.registerLazySingleton(() => GithubSignInUsecase(sl()));

  //repositories
  sl.registerLazySingleton<OnboardingRepo>(
    () => OnboardingRepoImpl(sl()),
  );

  //datasources
  sl.registerLazySingleton<OnboardingDS>(
    () => OnboardingDSImpl(storage: sl()),
  );
  await initStorage(sl());
}

Future initStorage(Storage storage) async {
  await storage.initStorage();
}
