import 'package:eden_user_app/features/order/presentation/widgets/stepper.dart';
import 'package:eden_user_app/features/order/states/order_cubit.dart';
import 'package:flutter/material.dart' hide Step;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TimelineInfo extends StatelessWidget {
  const TimelineInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderCubit = context.watch<OrderCubit>();
    return SizedBox(
      child: EdenStepper(
          defaultSteps: orderCubit.defaultSteps,
          steps: orderCubit.timelines
              .map((e) => Step(
                  title: e.title ?? "",
                  time: DateFormat('hh:mm a').format(e.time ?? DateTime.now()),
                  subtitle: e.description ?? ""))
              .toList()),
    );
  }
}
