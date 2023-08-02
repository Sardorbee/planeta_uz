import 'package:flutter/material.dart';
import 'package:planeta_uz/data/model/product_model.dart';
// ignore: must_be_immutable
class ProductDetailScreen extends StatelessWidget {
  ProductDetailScreen({super.key,required this.productModel});
  ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.network(productModel.productImages[0],height: 200,width: 200,)),
            Text('Name: ${productModel.productName}',style: const TextStyle(fontSize: 20),),
            Text('Description: ${productModel.description}',style: const TextStyle(fontSize: 20),),
            Text('Price: ${productModel.price} ${productModel.currency}',style: const TextStyle(fontSize: 20),),
            Text('Count: ${productModel.count}',style: const TextStyle(fontSize: 20),),
            Text('Created at: ${productModel.createdAt}',style: const TextStyle(fontSize: 20),),
          ],
        ),
      ),
    );
  }
}