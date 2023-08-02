import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:planeta_uz/data/model/product_model.dart';
import 'package:planeta_uz/utils/shimmer_photo.dart';

class GlobalMason extends StatelessWidget {
  GlobalMason({super.key, required this.products});
  List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: MasonryGridView.count(
        itemCount: products.length,
        crossAxisCount: 2,
        mainAxisSpacing: 16.h,
        crossAxisSpacing: 16.w,
        itemBuilder: (context, index) {
          ProductModel x = products[index];
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
                    placeholder: (context, url) => const ShimmerPhoto(),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  x.productName,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 4.h),
                Text(
                  x.description,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 4.h),
                Text("${x.price} ${x.currency}"),
              ],
            ),
          );
        },
      ),
    );
  }
}
