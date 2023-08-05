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
        backgroundColor: MaterialStatePropertyAll(Color(0xFFF83758)),
      ),
      onPressed: () {
        // print(_imageUrl);
        if (context
                .read<ProductsProvider>()
                .productsNamecontroller
                .text
                .isNotEmpty &&
            context
                .read<ProductsProvider>()
                .productsDesccontroller
                .text
                .isNotEmpty &&
            context
                .read<ProductsProvider>()
                .productsCountcontroller
                .text
                .isNotEmpty &&
            context
                .read<ProductsProvider>()
                .productsCurrencycontroller
                .text
                .isNotEmpty &&
            context
                .read<ProductsProvider>()
                .productsPricecontroller
                .text
                .isNotEmpty &&
            _imageUrl != null) {
          context.read<ProductsProvider>().addProducts(
                context: context,
                productModel: ProductModel(
                    count: int.parse(context
                        .read<ProductsProvider>()
                        .productsCountcontroller
                        .text),
                    price: int.parse(context
                        .read<ProductsProvider>()
                        .productsPricecontroller
                        .text),
                        isCarted: 0,
                    productImages: [_imageUrl],
                    categoryId: _catID!,
                    productId: '',
                    productName: context
                        .read<ProductsProvider>()
                        .productsNamecontroller
                        .text,
                    description: context
                        .read<ProductsProvider>()
                        .productsDesccontroller
                        .text,
                    createdAt: DateTime.now().toString(),
                    currency: context
                        .read<ProductsProvider>()
                        .productsCurrencycontroller
                        .text),
              );
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Product added'),
            ),
          );
          Navigator.pop(context);
        }else{
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Maydonlar to\'ldirilmadi'),
            ),
          );
        }
      },
      child: const Text(
        "Add Product",
      ),
    );
  }
}
