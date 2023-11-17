import 'package:eden_user_app/core/size_config/extensions.dart';
import 'package:eden_user_app/features/order/presentation/widgets/build_orders.dart';
import 'package:eden_user_app/features/order/presentation/widgets/build_track_order_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 80),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    "Order Details",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: 18.text),
                  ),
                  const Spacer(),
                ],
              ),
              20.vSpacer,
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.vSpacer,
            const BuildTrackOrderCard(),
            20.vSpacer,
            RichText(
              text: TextSpan(
                text: "Order ID: ",
                style: Theme.of(context).textTheme.titleSmall,
                children: [
                  TextSpan(
                    text: "BX123456",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            10.sV,
            RichText(
              text: TextSpan(
                text: "Date: ",
                style: Theme.of(context).textTheme.titleSmall,
                children: [
                  TextSpan(
                    text: DateFormat('E, MMM d, y').format(DateTime.now()),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            20.vSpacer,
            BuildOrders(),
            30.vSpacer,
          ],
        ),
      ),
    );
  }
}
