import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:planeta_uz/data/model/order_model.dart';
import 'package:planeta_uz/provider/order_provider.dart';
import 'package:planeta_uz/ui/utils/colors.dart';
import 'package:provider/provider.dart';

class CartDetails extends StatelessWidget {
  CartDetails({super.key, required this.order});

  OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<OrderModel>>(
        stream: context.read<OrderProvider>().getOrdersByOrderID(order.orderId),
        builder: (context, snapshot) {
          return CustomScrollView(
            slivers: [
              const SliverAppBar(
                backgroundColor: Color(0xFFF2F2F2),
                title: Text(
                  'Cart Details Screen',
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
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      OrderModel x = snapshot.data![index];

                      return Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 170.h,
                                  width: 150.w,
                                  child:
                                      CachedNetworkImage(imageUrl: x.orderImg),
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
                                    Row(
                                      children: [
                                        TextButton(
                                          onPressed: () async {
                                            if (x.count > 1) {
                                              await FirebaseFirestore.instance
                                                  .collection("orders")
                                                  .doc(x.orderId)
                                                  .update({
                                                "count": x.count - 1,
                                                'totalPrice':
                                                    x.totalPrice - x.orderPrice,
                                              });
                                            }
                                          },
                                          child: const Icon(
                                            Icons.remove,
                                          ),
                                        ),
                                        Text(
                                          x.count.toString(),
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            await FirebaseFirestore.instance
                                                .collection("orders")
                                                .doc(x.orderId)
                                                .update({
                                              "count": x.count + 1,
                                              'totalPrice':
                                                  (x.count + 1) * x.orderPrice,
                                            });
                                          },
                                          child: const Icon(
                                            Icons.add,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(8),
                            height: 1,
                            width: double.infinity,
                            color: const Color(0xffCACACA),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Order Details",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Order Price',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "${x.orderPrice.toString()} ",
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          x.orderCurrency,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Product Amount',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      x.count.toString(),
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Delivery Fee',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      'Free',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.mainButtonColor),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.all(8),
                                  height: 1,
                                  width: double.infinity,
                                  color: const Color(0xffCACACA),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Order Total",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "${x.totalPrice.toString()} ",
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          x.orderCurrency,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.h),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                AppColors.mainButtonColor)),
                                    onPressed: () async {
                                      context
                                          .read<OrderProvider>()
                                          .updateByOrderField(
                                              collectionName: 'orders',
                                              collectionDocId: x.orderId,
                                              docField: "orderStatus",
                                              updatedText: "Ordered");
                                      context
                                          .read<OrderProvider>()
                                          .updateByOrderField(
                                              collectionName: 'products',
                                              collectionDocId: x.productId,
                                              docField: "isCarted",
                                              updatedText: 0);

                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "Order",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                    childCount: snapshot.data!.length,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
