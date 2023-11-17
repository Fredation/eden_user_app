// ignore_for_file: use_build_context_synchronously

import 'package:eden_user_app/core/data_utils/colors.dart';
import 'package:eden_user_app/core/data_utils/img_strings.dart';
import 'package:eden_user_app/core/size_config/extensions.dart';
import 'package:eden_user_app/core/reusables/app_util.dart';
import 'package:eden_user_app/core/reusables/loading_view.dart';
import 'package:eden_user_app/features/onboarding/states/onboarding_cubit.dart';
import 'package:eden_user_app/features/order/presentation/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const String routeName = 'login-page';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final onboardingCubit = context.watch<OnboardingCubit>();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: LoaderView(
        loading: onboardingCubit.state.isLoading,
        child: Scaffold(
          extendBody: true,
          backgroundColor: EdenColors.background,
          body: SingleChildScrollView(
            // padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Container(
                  color: EdenColors.primaryGreen,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      20.vSpacer,
                      Image.asset(
                        edenLogo,
                        height: 180.relHeight,
                        width: double.maxFinite,
                      ),
                      Text(
                        "Welcome back",
                        style:
                            Theme.of(context).textTheme.headlineLarge!.copyWith(
                                  color: Colors.white,
                                ),
                      ),
                      10.vSpacer,
                      Text(
                        "You have been missed!",
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: Colors.white,
                                ),
                      ),
                      20.vSpacer,
                    ],
                  ),
                ),
                90.vSpacer,
                Column(
                  children: [
                    signInCard(
                      icon: googleIcon,
                      text: "Google",
                      onTap: () async {
                        await onboardingCubit.signInWithGoogle();
                        if (onboardingCubit.state.error == null) {
                          AppUtil.showSnackBar(context,
                              text: "Login Successful");
                          context.pushNamed(HomePage.routeName);
                        } else {
                          AppUtil.showSnackBar(context,
                              text: onboardingCubit.state.error?.message ??
                                  "An error occured");
                        }
                      },
                    ),
                    24.vSpacer,
                    Row(
                      children: [
                        const Expanded(
                            child: Divider(
                          color: EdenColors.lightTextColor,
                        )),
                        10.hSpacer,
                        Text(
                          "Or",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        10.hSpacer,
                        const Expanded(
                            child: Divider(
                          color: EdenColors.lightTextColor,
                        )),
                      ],
                    ),
                    24.vSpacer,
                    signInCard(
                      icon: githubIcon,
                      text: "Github",
                      onTap: () async {
                        await onboardingCubit.signInWithGithub();
                        if (onboardingCubit.state.error == null) {
                          AppUtil.showSnackBar(context,
                              text: "Login Successful");
                          context.pushNamed(HomePage.routeName);
                        } else {
                          AppUtil.showSnackBar(context,
                              text: onboardingCubit.state.error?.message ??
                                  "An error occured");
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector signInCard(
      {required Function()? onTap,
      required String icon,
      required String text}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        color: EdenColors.cardGrey,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: EdenColors.whiteColor,
                border: Border.all(
                  color: EdenColors.cardGrey,
                ),
              ),
              child: Image.asset(
                icon,
                height: 50.relHeight,
              ),
            ),
            20.hSpacer,
            Text(
              "Sign in with $text",
              style: Theme.of(context).textTheme.bodyLarge,
            )
          ],
        ),
      ),
    );
  }
}
