import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:planeta_uz/data/model/product_model.dart';
import 'package:planeta_uz/provider/products_provider.dart';
import 'package:planeta_uz/utils/shimmer_photo.dart';

import 'package:provider/provider.dart';

class ProductsSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Center(
      child: Text('Search is not implemented yet.'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder<List<ProductModel>>(
      stream: context.read<ProductsProvider>().getProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error loading data.'),
          );
        } else {
          final List<ProductModel> productList = snapshot.data!;
          final List<ProductModel> suggestionList = query.isEmpty
              ? productList
              : productList
                  .where((product) => product.productName
                      .toLowerCase()
                      .startsWith(query.toLowerCase()))
                  .toList();

          return MasonryGridView.count(
                          itemCount: suggestionList.length,
                          crossAxisCount: 2,
                          mainAxisSpacing: 16.h,
                          crossAxisSpacing: 16.w,
                          itemBuilder: (context, index) {
                            ProductModel x = suggestionList[index];
                            return Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  15,
                                ),
                                color: Colors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      imageUrl: x.productImages[0],
                                      placeholder: (context, url) =>
                                          const ShimmerPhoto(),
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(x.productName),
                                  SizedBox(height: 4.h),
                                  Text(x.description),
                                  SizedBox(height: 4.h),
                                  Text("${x.price} ${x.currency}"),
                                ],
                              ),
                            );
                          },
                        );
        }
      },
    );
  }
}
