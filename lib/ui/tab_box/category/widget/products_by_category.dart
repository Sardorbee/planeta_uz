import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:planeta_uz/data/model/category_model.dart';
import 'package:planeta_uz/data/model/product_model.dart';
import 'package:planeta_uz/provider/category_provider.dart';
import 'package:planeta_uz/provider/products_provider.dart';
import 'package:planeta_uz/ui/tab_box/widgets/global_mason.dart';
import 'package:provider/provider.dart';

class ProductsByCAt extends StatelessWidget {
  ProductsByCAt({super.key, required this.category});
  CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.categoryName),
      ),
      body: StreamBuilder<List<ProductModel>>(
        stream: context
            .read<ProductsProvider>()
            .getProductsByCategoryId(category.categoryId),
        builder:
            (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.isNotEmpty
                ? GlobalMason(products: snapshot.data!)
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
