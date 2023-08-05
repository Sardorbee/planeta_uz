import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:planeta_uz/data/model/product_model.dart';
import 'package:planeta_uz/provider/products_provider.dart';
import 'package:planeta_uz/ui/utils/colors.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ProductsCount extends StatelessWidget {
  ProductsCount({super.key, required this.selectedId});
  String selectedId;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: StreamBuilder(
        stream: selectedId == 'all'
            ? context.read<ProductsProvider>().getProducts()
            : selectedId != 'all'
                ? context
                    .read<ProductsProvider>()
                    .getProductsByCategoryId(selectedId)
                : context.read<ProductsProvider>().getProducts(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            List<ProductModel>? products = snapshot.data;
            if (products != null && products.isNotEmpty) {
              return Text(
                "${snapshot.data.length} Products",
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              );
            } else {
              // Empty data
              return Center(
                  child: Text(
                "0 Products",
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ));
            }
          }
        },
      ),
    );
  }
}
