import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:planeta_uz/data/model/product_model.dart';
import 'package:planeta_uz/provider/products_provider.dart';
import 'package:planeta_uz/ui/tab_box_admin/admin_home/add_products/add_products.dart';
import 'package:planeta_uz/ui/tab_box_admin/admin_home/add_products/update_products.dart';
import 'package:planeta_uz/ui/tab_box_admin/admin_home/product_detail/product_detail_screen.dart';
import 'package:planeta_uz/utils/colors.dart';
import 'package:provider/provider.dart';

class ProductScreenAdmin extends StatefulWidget {
  const ProductScreenAdmin({super.key});

  @override
  State<ProductScreenAdmin> createState() => _ProductScreenAdminState();
}

class _ProductScreenAdminState extends State<ProductScreenAdmin> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F2F2),
        title: const Text(
          'Admin Product Page',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: StreamBuilder<List<ProductModel>>(
        stream: context.read<ProductsProvider>().getProducts(),
        builder:
            (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
          if (snapshot.hasData) {
        
            return snapshot.data!.isNotEmpty
                ? ListView(
                    children: List.generate(
                      snapshot.data!.length,
                      (index) {
                        ProductModel productModel = snapshot.data![index];
                        return ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductDetailScreen(
                                          productModel: productModel,
                                        )));
                          },
                          onLongPress: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Delete'),
                                content: const Text(
                                    'Are you sure to delete this product?'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('No')),
                                  TextButton(
                                    onPressed: () {
                                      context
                                          .read<ProductsProvider>()
                                          .deleteProducts(
                                            context: context,
                                            productsId: productModel.productId,
                                          );
                                    },
                                    child: const Text('Yes'),
                                  ),
                                ],
                              ),
                            );
                          },
                          leading: CircleAvatar(
                            backgroundImage: CachedNetworkImageProvider(
                              productModel.productImages[0],
                            ),
                          ),
                          title: Text(productModel.productName),
                          subtitle: Text(
                            productModel.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Updateproducts(
                                    productModel: productModel,
                                  ),
                                ),
                              );
                              context
                                  .read<ProductsProvider>()
                                  .uploadedImagesUrls
                                  .addAll(productModel.productImages);
                            },
                            icon: const Icon(Icons.edit),
                          ),
                        );
                      },
                    ),
                  )
                : const Center(child: Text("Empty!"));
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.mainButtonColor,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Addproducts()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
