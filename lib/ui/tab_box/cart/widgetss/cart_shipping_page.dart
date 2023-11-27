import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:planeta_uz/data/model/order_model.dart';
import 'package:planeta_uz/provider/auth_provider/login_pro.dart';
import 'package:planeta_uz/provider/order_provider.dart';
import 'package:planeta_uz/ui/tab_box/cart/widgetss/cart_detail.dart';
import 'package:planeta_uz/ui/tab_box/cart/widgetss/check.dart';
import 'package:provider/provider.dart';

class CartShippingPage extends StatelessWidget {
  const CartShippingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<OrderModel>>(
        stream: context
            .read<OrderProvider>()
            .getOrdersByUIShipping(context.read<LoginProvider>().user!.uid),
        builder: (context, snapshot) {
          return CustomScrollView(
            slivers: [
              if (snapshot.connectionState == ConnectionState.waiting)
                const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (snapshot.hasError)
                SliverFillRemaining(
                  child: Center(
                    child: Text('Error: ${snapshot.error}'),
                  ),
                )
              else if (snapshot.data!.isNotEmpty)
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      OrderModel x = snapshot.data![index];
                      context
                          .read<OrderProvider>()
                          .updateByOrderField(
                          collectionName: 'orders',
                          collectionDocId: x.orderId,
                          docField: "orderStatus",
                          updatedText: "Deleted");
                      return GestureDetector(
                        onTap: () {
                          if (x.orderStatus == "waiting") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CartDetails(order: x),
                                ));
                          }
                        },
                        child: GestureDetector(
                          onLongPress: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Checkscreen(order: x),
                                ));
                          },
                          child: Container(
                            color: x.orderStatus == "Delivering"
                                ? Colors.green
                                : x.orderStatus == "Canceled"
                                    ? Colors.grey.shade400
                                    : Colors.white,
                            margin: const EdgeInsets.all(8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 170.h,
                                  width: 150.w,
                                  child: CachedNetworkImage(imageUrl: x.orderImg),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      x.productName,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(height: 5.h),
                                    Text(
                                      x.orderStatus,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(height: 5.h),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: snapshot.data!.length,
                  ),
                )
              else if (snapshot.data!.isEmpty)
                SliverFillRemaining(
                  child: LottieBuilder.asset("assets/lottie/empty_box.json"),
                ),
            ],
          );
        },
      ),
    );
  }
}
