import 'package:cached_network_image/cached_network_image.dart';
import 'package:eden_user_app/core/data_utils/colors.dart';
import 'package:eden_user_app/core/data_utils/constants.dart';
import 'package:eden_user_app/core/size_config/extensions.dart';
import 'package:eden_user_app/features/order/presentation/widgets/build_order_price.dart';
import 'package:eden_user_app/features/order/states/order_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class BuildOrders extends StatelessWidget {
  BuildOrders({Key? key}) : super(key: key);
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final products = context.watch<OrderCubit>().products;
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Container(
          decoration: BoxDecoration(
            color: EdenColors.whiteColor,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: EdenColors.lightTextColor,
            ),
          ),
          child: ListView.separated(
              primary: false,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: products.length,
              separatorBuilder: (context, index) => const Divider(
                    height: 0,
                    color: EdenColors.cardGrey,
                  ),
              itemBuilder: (context, index) {
                final product = products[index];
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          height: 40,
                          width: 40,
                          imageUrl: product.image,
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.green.shade300,
                            highlightColor: Colors.green.shade100,
                            enabled: true,
                            child: Container(
                              color: EdenColors.primaryGreen,
                            ),
                          ),
                          errorWidget: (context, url, error) {
                            return const Icon(Icons.error);
                          },
                        ),
                      ),
                      10.hSpacer,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${product.name} x ${product.quantity.toString()}",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 7),
                            Text(
                              formatMoney(amount: product.amount),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    fontSize: 16.text,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
        20.vSpacer,
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildOrderPrice(context),
          ],
        )
      ],
    );
  }
}
