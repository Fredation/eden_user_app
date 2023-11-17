import 'package:eden_user_app/features/onboarding/states/onboarding_cubit.dart';
import 'package:eden_user_app/features/order/states/order_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
export 'package:flutter_bloc/src/bloc_provider.dart';

getProviders(GetIt instance) {
  return [
    BlocProvider<OnboardingCubit>(
      create: (context) => instance<OnboardingCubit>(),
    ),
    BlocProvider<OrderCubit>(
      create: (context) => instance<OrderCubit>(),
    ),
  ];
}
