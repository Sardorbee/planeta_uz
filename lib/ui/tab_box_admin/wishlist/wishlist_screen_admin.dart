import 'package:flutter/material.dart';
import 'package:planeta_uz/data/model/product_model.dart';
import 'package:planeta_uz/provider/auth_provider/login_pro.dart';
import 'package:planeta_uz/provider/products_provider.dart';
import 'package:planeta_uz/ui/tab_box_admin/admin/add_products/add_products.dart';
import 'package:planeta_uz/ui/tab_box_admin/admin/add_products/update_products.dart';
import 'package:planeta_uz/ui/tab_box_admin/product_detail/product_detail_screen.dart';
import 'package:provider/provider.dart';

class ProductScreenAdmin extends StatelessWidget {
  const ProductScreenAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    LoginProvider x = context.read<LoginProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Product Page'),
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
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetailScreen(productModel: productModel)));
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
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Yes'),
                                  ),
                                ],
                              ),
                            );
                          },
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(productModel.productImages[0]),
                          ),
                          title: Text(productModel.productName),
                          subtitle: Text(productModel.description),
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
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Addproducts()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
