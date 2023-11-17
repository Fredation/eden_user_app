import 'package:eden_user_app/core/data_utils/constants.dart';
import 'package:eden_user_app/core/size_config/extensions.dart';
import 'package:eden_user_app/features/order/states/order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Container buildOrderPrice(BuildContext context) {
  final orderCubit = context.read<OrderCubit>();
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(28),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Subtotal',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
            ),
            10.hSpacer,
            Text(
              formatMoney(amount: orderCubit.getProductTotal()),
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: 18),
            )
          ],
        ),
        10.sV,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Delivery Fee',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.black.withOpacity(.5)),
            ),
            10.hSpacer,
            Text(
              formatMoney(amount: 1200),
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.black.withOpacity(.5)),
            ),
          ],
        ),
        12.sV,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'VAT(7.5%)',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.black.withOpacity(.5)),
            ),
            10.hSpacer,
            Text(
              formatMoney(amount: orderCubit.getVatCharge()),
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.black.withOpacity(.5)),
            ),
          ],
        ),
        20.sV,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total Paid',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
            ),
            10.hSpacer,
            Text(
              formatMoney(
                  amount: orderCubit.getProductTotal() +
                      orderCubit.getVatCharge() +
                      1200),
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: 18),
            )
          ],
        ),
      ],
    ),
  );
}
