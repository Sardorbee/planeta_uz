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

  int newCount = 1;

  addcount() {
    newCount++;
    notifyListeners();
  }
  minuscount() {
    if(newCount>=1){
      newCount--;
    notifyListeners();
    }
  }

  Future<void> addOrders({
    required BuildContext context,
    required OrderModel orderModel,
  }) async {
    showLoading(context: context);
    UniversalData universalData =
        await OrderService.addOrders(orderModel: orderModel);
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
        await OrderService.updateOrders(orderModel: orderModel);
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
        await OrderService.deleteProduct(orderId: orderId);
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

  Stream<List<OrderModel>> getOrdersByID(String userId) {
    final databaseReference = FirebaseFirestore.instance.collection('orders');

    return databaseReference.where('userId', isEqualTo: userId).snapshots().map(
        (querySnapshot) => querySnapshot.docs
            .map((doc) => OrderModel.fromJson(doc.data()))
            .toList());
  }

  showMessage(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
    notifyListeners();
  }
}
