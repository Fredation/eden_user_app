import 'dart:io';

import 'package:eden_user_app/core/data_utils/colors.dart';
import 'package:eden_user_app/core/data_utils/img_strings.dart';
import 'package:eden_user_app/core/size_config/config.dart';
import 'package:eden_user_app/core/size_config/extensions.dart';
import 'package:eden_user_app/features/order/presentation/timeline_info.dart';
import 'package:eden_user_app/features/order/states/order_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrackOrderPage extends StatelessWidget {
  TrackOrderPage({super.key});
  static const String routeName = 'track-order-page';

  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final orderCubit = context.watch<OrderCubit>();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value:
          const SystemUiOverlayStyle(statusBarColor: EdenColors.primaryGreen),
      child: Scaffold(
        extendBody: true,
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 200.relHeight,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                decoration: const BoxDecoration(
                  color: EdenColors.primaryGreen,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (Platform.isIOS) 50.vSpacer else 35.vSpacer,
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const SizedBox(
                        height: 40,
                        child: Icon(
                          Icons.arrow_back_rounded,
                          color: EdenColors.whiteColor,
                        ),
                      ),
                    ),
                    20.vSpacer,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user?.displayName?.split(" ").last ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                      fontSize: 20.text,
                                      color: EdenColors.whiteColor),
                            ),
                            14.sV,
                            Text(
                              "Delivery Time",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontSize: 12.text,
                                    color: EdenColors.whiteColor,
                                  ),
                            ),
                          ],
                        ),
                        Image.asset(bikeRiderIcon, height: 70.relHeight),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 220.relHeight,
              left: 0,
              right: 0,
              height: SizeConfig.screenHeight - 220.relHeight,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (orderCubit.defaultSteps.isNotEmpty)
                      const TimelineInfo(),
                    30.vSpacer,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
