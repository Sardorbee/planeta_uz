import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:planeta_uz/data/model/product_model.dart';
import 'package:planeta_uz/ui/tab_box_admin/admin_home/product_detail/product_detail_screen.dart';
import 'package:planeta_uz/utils/shimmer_photo.dart';

class GlobalMason extends StatefulWidget {
  const GlobalMason({super.key, required this.products});

  final List<ProductModel> products;

  @override
  State<GlobalMason> createState() => _GlobalMasonState();
}

class _GlobalMasonState extends State<GlobalMason> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: MasonryGridView.count(
        itemCount: widget.products.length,
        crossAxisCount: 2,
        mainAxisSpacing: 16.h,
        crossAxisSpacing: 16.w,
        itemBuilder: (context, index) {
          ProductModel x = widget.products[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(
                    productModel: x,
                  ),
                ),
              );
            },
            child: Container(
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
                    child: Hero(
                      tag: x.productImages[0],
                      child: CachedNetworkImage(
                        imageUrl: x.productImages[0],
                        placeholder: (context, url) => const ShimmerPhoto(),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        x.productName,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      IconButton(
                        onPressed: () {},
                        splashRadius: 2,
                        icon: const Icon(
                          Icons.shopping_cart_outlined,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    x.description,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 4.h),
                  Text("${x.price} ${x.currency}"),
                  RatingStars(
                    value: x.count.toDouble(),
                    // onValueChanged: (v) {
                    //   //
                    //   // setState(() {
                    //   //   // value = v;
                    //   // });
                    // },

                    starCount: 5,
                    starSize: 20,
                    valueLabelVisibility: false,
                    maxValue: 50,
                    starSpacing: 1.5,

                    animationDuration: const Duration(milliseconds: 1000),

                    starOffColor: const Color(0xffe7e8ea),
                    starColor: Colors.yellow,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
