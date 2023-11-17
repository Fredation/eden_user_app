import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:eden_user_app/core/data_utils/colors.dart';
import 'package:eden_user_app/core/data_utils/img_strings.dart';
import 'package:eden_user_app/core/size_config/config.dart';
import 'package:eden_user_app/features/onboarding/presentation/login_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Default app splash screen
class SplashScreen extends StatefulWidget {
  /// Default constructor for [SplashScreen]
  const SplashScreen({super.key});
  static const String routeName = 'splash-screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? timer;

  @override
  void initState() {
    timer = Timer(
      const Duration(seconds: 5),
      () {
        context.go("/${LoginPage.routeName}");
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        color: EdenColors.primaryGreen,
        child: Stack(
          children: [
            Align(
              alignment: const Alignment(0.0, -.5),
              child: ZoomIn(
                delay: const Duration(milliseconds: 1500),
                child: Image.asset(
                  edenLogo,
                  width: SizeConfig.screenWidth! / 2,
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0.0, -.18),
              child: FadeIn(
                delay: const Duration(seconds: 1),
                child: Image.asset(
                  welcomePng,
                  width: SizeConfig.screenWidth! / 2.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
