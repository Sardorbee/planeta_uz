import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:planeta_uz/data/model/order_model.dart';
import 'package:planeta_uz/provider/auth_provider/login_pro.dart';
import 'package:planeta_uz/provider/order_provider.dart';
import 'package:provider/provider.dart';

class CartAdmin extends StatelessWidget {
  const CartAdmin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<OrderModel>>(
        stream: context
            .read<OrderProvider>()
            .getOrdersByOrdered(context.read<LoginProvider>().user!.uid),
        builder: (context, snapshot) {
          return CustomScrollView(
            slivers: [
              const SliverAppBar(
                backgroundColor: Color(0xFFF2F2F2),
                title: Text(
                  'Cart Screen',
                  style: TextStyle(color: Colors.black),
                ),
                pinned: true,
              ),
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
                      return GestureDetector(
                        child: Container(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        x.productName,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(height: 5.h),
                                      Text(
                                        "Status: ${x.orderStatus}",
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                      SizedBox(height: 5.h),
                                      Text(
                                        "Order Amount: ${x.count}",
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                      SizedBox(height: 5.h),
                                      Text(
                                        "Order Price: ${x.totalPrice} ${x.orderCurrency}",
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                      SizedBox(height: 20.h),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    Colors.grey.shade400)),
                                        onPressed: () {
                                          context
                                              .read<OrderProvider>()
                                              .updateByOrderField(
                                                  collectionName: 'orders',
                                                  collectionDocId: x.orderId,
                                                  docField: "orderStatus",
                                                  updatedText: "Canceled");
                                        },
                                        child: const Text(
                                          "Cancel",
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          context
                                              .read<OrderProvider>()
                                              .updateByOrderField(
                                                  collectionName: 'orders',
                                                  collectionDocId: x.orderId,
                                                  docField: "orderStatus",
                                                  updatedText: "Delivering");
                                        },
                                        child: const Text(
                                          "Deliver",
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
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
