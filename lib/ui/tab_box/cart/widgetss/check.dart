import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planeta_uz/data/model/order_model.dart';

class Checkscreen extends StatelessWidget {
  const Checkscreen({super.key, required this.order, });
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("Это чек вашего продукта цена его   ${order.totalPrice}so'm "),
        ),
      ),
    );
  }
}
