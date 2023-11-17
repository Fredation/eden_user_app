import 'package:eden_user_app/core/data_utils/colors.dart';
import 'package:eden_user_app/core/data_utils/img_strings.dart';
import 'package:eden_user_app/core/size_config/config.dart';
import 'package:eden_user_app/core/size_config/extensions.dart';
import 'package:eden_user_app/features/order/presentation/track_order_page.dart';
import 'package:eden_user_app/features/order/states/order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BuildTrackOrderCard extends StatelessWidget {
  const BuildTrackOrderCard({super.key});

  @override
  Widget build(BuildContext context) {
    final orderCubit = context.watch<OrderCubit>();
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            shoppingCart,
            height: 40,
          ),
          12.vSpacer,
          Text(
            orderCubit.timelines.isEmpty
                ? 'We await your order 🙂'
                : (orderCubit.timelines.last.title ?? ""),
            style:
                Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 16),
          ),
          10.vSpacer,
          Text(
            orderCubit.timelines.isEmpty
                ? 'Be assured that your order will be delivered on time.'
                : (orderCubit.timelines.last.description ?? ""),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          14.vSpacer,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildStep(
                  color: orderCubit.timelines.isNotEmpty
                      ? EdenColors.primaryGreen
                      : EdenColors.lightTextColor),
              buildStep(
                  color: orderCubit.timelines.length > 1
                      ? EdenColors.primaryGreen
                      : EdenColors.lightTextColor),
              buildStep(
                  color: orderCubit.timelines.length > 2
                      ? EdenColors.primaryGreen
                      : EdenColors.lightTextColor),
              buildStep(
                  color: orderCubit.timelines.length > 3
                      ? EdenColors.primaryGreen
                      : EdenColors.lightTextColor),
              buildStep(
                  color: orderCubit.timelines.length > 4
                      ? EdenColors.primaryGreen
                      : EdenColors.lightTextColor),
              buildStep(
                  color: orderCubit.timelines.length > 5
                      ? EdenColors.primaryGreen
                      : EdenColors.lightTextColor),
            ],
          ),
          20.vSpacer,
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                context.pushNamed(TrackOrderPage.routeName);
              },
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: EdenColors.primaryGreen,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Track Order",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: EdenColors.background),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: EdenColors.background,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container buildStep({required Color color}) {
    return Container(
      height: 3,
      width: SizeConfig.screenWidth! / 8.5,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
