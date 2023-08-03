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

  Future<void> addOrders({
    required BuildContext context,
    required OrderModel orderModel,
  }) async {
    UniversalData universalData =
        await orderService.addOrders(orderModel: orderModel);
    if (universalData.error.isEmpty) {
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

  Future<void> deleteOrders({
    required BuildContext context,
    required String orderId,
  }) async {
    showLoading(context: context);
    UniversalData universalData =
        await orderService.deleteOrder(orderId: orderId);
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

  Future<void> deleteDocumentByProductId(String productId) async {
    final CollectionReference ordersCollection =
        FirebaseFirestore.instance.collection('orders');

    QuerySnapshot querySnapshot =
        await ordersCollection.where('productId', isEqualTo: productId).get();

    if (querySnapshot.size > 0) {
      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        await documentSnapshot.reference.delete();
      }
      print('Document(s) with productId $productId deleted successfully.');
    } else {
      print('No document with productId $productId found.');
    }
  }

  Stream<List<OrderModel>> getOrders() =>
      FirebaseFirestore.instance.collection("orders").snapshots().map(
            (event1) => event1.docs
                .map((doc) => OrderModel.fromJson(doc.data()))
                .toList(),
          );

  Stream<List<OrderModel>> getOrdersByOrdered(
    String userId,
  ) {
    final databaseReference = FirebaseFirestore.instance.collection('orders');

    return databaseReference
        .where('orderStatus', isEqualTo: "Ordered")
        .snapshots()
        .map(
          (querySnapshot) => querySnapshot.docs
              .map((doc) => OrderModel.fromJson(doc.data()))
              .toList(),
        );
  }

  Future updateByOrderField(
      {required String collectionName,
      required String collectionDocId,
      required String docField,
      required updatedText}) async {
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(collectionDocId)
        .update({
      docField: updatedText,
    });
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

  Stream<List<OrderModel>> getOrdersUID(String uID) {
    final databaseReference = FirebaseFirestore.instance.collection('orders');

    return databaseReference
        .where('userId', isEqualTo: uID)
        .orderBy('createdAt')
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((doc) => OrderModel.fromJson(doc.data()))
            .toList());
  }

  showMessage(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(microseconds: 1000), content: Text(error)));
    notifyListeners();
  }


   Stream<List<OrderModel>> getOrdersByUIDWaiting(
    String userId,
  ) {
    final databaseReference = FirebaseFirestore.instance.collection('orders');

    return databaseReference
        .where('userId', isEqualTo: userId)
        .where('orderStatus', isEqualTo: "waiting")
        
        .snapshots()
        .map(
          (querySnapshot) => querySnapshot.docs
              .map((doc) => OrderModel.fromJson(doc.data()))
              .toList(),
        );
  }

 Stream<List<OrderModel>> getOrdersByUIShipping(
    String userId,
  ) {
    final databaseReference = FirebaseFirestore.instance.collection('orders');

    return databaseReference
        .where('userId', isEqualTo: userId)
        .where('orderStatus', isEqualTo: "Shipping")
        
        .snapshots()
        .map(
          (querySnapshot) => querySnapshot.docs
              .map((doc) => OrderModel.fromJson(doc.data()))
              .toList(),
        );
  }
 Stream<List<OrderModel>> getOrdersByUICanceled(
    String userId,
  ) {
    final databaseReference = FirebaseFirestore.instance.collection('orders');

    return databaseReference
        .where('userId', isEqualTo: userId)
        .where('orderStatus', isEqualTo: "Canceled")
        
        .snapshots()
        .map(
          (querySnapshot) => querySnapshot.docs
              .map((doc) => OrderModel.fromJson(doc.data()))
              .toList(),
        );
  }
  

}
