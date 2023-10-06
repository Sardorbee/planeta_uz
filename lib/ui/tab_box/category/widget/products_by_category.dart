import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:planeta_uz/data/model/category_model.dart';
import 'package:planeta_uz/data/model/product_model.dart';
import 'package:planeta_uz/provider/products_provider.dart';
import 'package:planeta_uz/ui/tab_box/widgets/global_mason.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ProductsByCAt extends StatelessWidget {
  ProductsByCAt({super.key, required this.category});
  CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F2F2),
        title: Text(
          category.categoryName,
          style: const TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: StreamBuilder<List<ProductModel>>(
        stream: context
            .read<ProductsProvider>()
            .getProductsByCategoryId(category.categoryId),
        builder:
            (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.isNotEmpty
                ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GlobalMason(products: snapshot.data!),
                )
                : Center(child: Lottie.asset("assets/lottie/empty_box.json"));
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
