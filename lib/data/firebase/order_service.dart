import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:planeta_uz/data/model/order_model.dart';
import 'package:planeta_uz/data/model/universal.dart';


class OrderService {
   Future<UniversalData> addOrders(
      {required OrderModel orderModel}) async {
    try {
      DocumentReference newOrder = await FirebaseFirestore.instance
          .collection("orders")
          .add(orderModel.toJson());

      await FirebaseFirestore.instance
          .collection("orders")
          .doc(newOrder.id)
          .update({
        "orderId": newOrder.id,
      });

      return UniversalData(data: "Order added!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

   Future<UniversalData> updateOrders(
      {required OrderModel orderModel}) async {
    try {
      await FirebaseFirestore.instance
          .collection("orders")
          .doc(orderModel.orderId)
          .update(orderModel.toJson());

      return UniversalData(data: "Order updated!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

   Future<UniversalData> deleteOrder(
      {required String orderId}) async {
    try {
      await FirebaseFirestore.instance
          .collection("orders")
          .doc(orderId)
          .delete();

      return UniversalData(data: "Order deleted!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }
}
