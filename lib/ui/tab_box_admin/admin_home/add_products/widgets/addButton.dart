import 'package:flutter/material.dart';
import 'package:planeta_uz/data/model/product_model.dart';
import 'package:planeta_uz/provider/products_provider.dart';
import 'package:provider/provider.dart';

class AddProductButton extends StatelessWidget {
  const AddProductButton({
    super.key,
    required String? imageUrl,
    required String? catId,
  })  : _imageUrl = imageUrl,
        _catID = catId;

  final String? _imageUrl;
  final String? _catID;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Colors.black),
      ),
      onPressed: () {
        if (context
                .read<ProductsProvider>()
                .ProductsNamecontroller
                .text
                .isNotEmpty &&
            context
                .read<ProductsProvider>()
                .ProductsDesccontroller
                .text
                .isNotEmpty &&
            context
                .read<ProductsProvider>()
                .ProductsCountcontroller
                .text
                .isNotEmpty &&
            context
                .read<ProductsProvider>()
                .ProductsCurrencycontroller
                .text
                .isNotEmpty &&
            context
                .read<ProductsProvider>()
                .ProductsPricecontroller
                .text
                .isNotEmpty &&
            _imageUrl != null) {
          context.read<ProductsProvider>().addProducts(
                context: context,
                productModel: ProductModel(
                    count: int.parse(context
                        .read<ProductsProvider>()
                        .ProductsCountcontroller
                        .text),
                    price: int.parse(context
                        .read<ProductsProvider>()
                        .ProductsPricecontroller
                        .text),
                    productImages: [_imageUrl],
                    categoryId: _catID!,
                    productId: '',
                    productName: context
                        .read<ProductsProvider>()
                        .ProductsNamecontroller
                        .text,
                    description: context
                        .read<ProductsProvider>()
                        .ProductsDesccontroller
                        .text,
                    createdAt: DateTime.now().toString(),
                    currency: context
                        .read<ProductsProvider>()
                        .ProductsCurrencycontroller
                        .text),
              );
          Navigator.pop(context);
        }
      },
      child: const Text(
        "Add Product",
      ),
    );
  }
}
