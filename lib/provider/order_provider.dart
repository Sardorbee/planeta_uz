import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:planeta_uz/data/firebase/order_service.dart';
import 'package:planeta_uz/data/model/order_model.dart';
import 'package:planeta_uz/data/model/universal.dart';
import 'package:planeta_uz/provider/ui_utils/loading_dialog.dart';

class OrderProvider with ChangeNotifier {
  OrderProvider(
    this.orderService,
  );

  final OrderService orderService;

  List<OrderModel> userOrders = [];

  Future<void> addOrder({
    required BuildContext context,
    required OrderModel orderModel,
  }) async {
    List<OrderModel> exists = userOrders
        .where((element) => element.productId == orderModel.productId)
        .toList();

    OrderModel? oldOrderModel;
    if (exists.isNotEmpty) {
      oldOrderModel = exists.first;
      oldOrderModel = oldOrderModel.copWith(
          count: orderModel.count + oldOrderModel.count,
          totalPrice:
              (orderModel.count + oldOrderModel.count) * orderModel.totalPrice);
    }

    showLoading(context: context);
    UniversalData universalData = exists.isNotEmpty
        ? await orderService.updateOrders(orderModel: oldOrderModel!)
        : await orderService.addOrders(orderModel: orderModel);

    if (context.mounted) {
      hideLoading(dialogContext: context);
    }
    if (universalData.error.isEmpty) {
      if (context.mounted) {
        showMessage(context, universalData.data as String);
      }
    } else {
      if (context.mounted) {
        showMessage(context, universalData.error);
      }
    }
  }

  Future<void> updateOrders({
    required BuildContext context,
    required OrderModel orderModel,
  }) async {
    showLoading(context: context);
    UniversalData universalData =
        await orderService.updateOrders(orderModel: orderModel);
    if (context.mounted) {
      hideLoading(dialogContext: context);
    }
    if (universalData.error.isEmpty) {
      if (context.mounted) {
        showMessage(context, universalData.data as String);
      }
    } else {
      if (context.mounted) {
        showMessage(context, universalData.error);
      }
    }
  }

  Future<void> deleteProducts({
    required BuildContext context,
    required String orderId,
  }) async {
    showLoading(context: context);
    UniversalData universalData =
        await orderService.deleteProduct(orderId: orderId);
    if (context.mounted) {
      hideLoading(dialogContext: context);
    }
    if (universalData.error.isEmpty) {
      if (context.mounted) {
        showMessage(context, universalData.data as String);
      }
    } else {
      if (context.mounted) {
        showMessage(context, universalData.error);
      }
    }
  }

  Stream<List<OrderModel>> getOrders() =>
      FirebaseFirestore.instance.collection("orders").snapshots().map(
            (event1) => event1.docs
                .map((doc) => OrderModel.fromJson(doc.data()))
                .toList(),
          );

  Stream<List<OrderModel>> getOrdersByUID(String userId) {
    final databaseReference = FirebaseFirestore.instance.collection('orders');

    return databaseReference.where('userId', isEqualTo: userId).snapshots().map(
        (querySnapshot) => querySnapshot.docs
            .map((doc) => OrderModel.fromJson(doc.data()))
            .toList());
  }

  Stream<List<OrderModel>> getOrdersByOrderID(String orderId) {
    final databaseReference = FirebaseFirestore.instance.collection('orders');

    return databaseReference
        .where('orderId', isEqualTo: orderId)
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((doc) => OrderModel.fromJson(doc.data()))
            .toList());
  }

  showMessage(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
    notifyListeners();
  }
}
