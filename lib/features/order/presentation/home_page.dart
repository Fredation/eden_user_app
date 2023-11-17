import 'package:eden_user_app/core/data_utils/colors.dart';
import 'package:eden_user_app/core/size_config/extensions.dart';
import 'package:eden_user_app/core/reusables/my_appbar.dart';
import 'package:eden_user_app/features/order/presentation/order_details.dart';
import 'package:eden_user_app/features/order/states/order_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String routeName = 'home-page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    final orderCubit = context.read<OrderCubit>();
    orderCubit.initAplyRealtime();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EdenAppBar(
        title: "Order Details",
      ),
      body: NestedScrollView(
        physics: const NeverScrollableScrollPhysics(
            parent: NeverScrollableScrollPhysics()),
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Container(
                    height: 84,
                    width: 84,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white.withOpacity(.24),
                        width: 3,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40.5),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        height: 81,
                        width: 81,
                        imageUrl: user?.photoURL ??
                            "https://awa-apps.fra1.cdn.digitaloceanspaces.com/EAD%2Fdefault_product.png",
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
                  ),
                  const SizedBox(height: 20),
                  Text(
                    user?.displayName ?? "",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: 20.text),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user?.email ?? "",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 12.text,
                          color: EdenColors.primaryGreen,
                        ),
                  ),
                  40.vSpacer,
                ],
              ),
            )
          ];
        },
        body: const OrderDetails(),
      ),
    );
  }
}
