import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:planeta_uz/data/model/product_model.dart';
import 'package:planeta_uz/ui/utils/colors.dart';
import 'package:planeta_uz/utils/constants.dart';

// ignore: must_be_immutable
class ProductDetailScreen extends StatelessWidget {
  ProductDetailScreen({
    super.key,
    required this.productModel,
  });

  ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c_F9F9F9,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          productModel.productName.capitalize(),
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: AppColors.c_F9F9F9,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.black,
          ),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: 16.h),
          CarouselSlider(
            items: [
              ...List.generate(
                productModel.productImages.length,
                (index) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: productModel.productImages[index],
                      height: 213.h,
                      width: double.infinity,
                    ),
                  ),
                ),
              )
            ],
            options:
                CarouselOptions(aspectRatio: 1, enableInfiniteScroll: false),
          ),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productModel.productName.capitalize(),
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  '${productModel.price} ${productModel.currency}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Product Details',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  productModel.description,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black,
                  ),
                ),
                SizedBox(height: 14.h),
                // InkWell(
                //   onTap: () {
                    
                    
                //   },
                //   child: Stack(
                //     children: [
                //       Container(
                //         margin: EdgeInsets.all(8.h),
                //         padding: EdgeInsets.only(
                //             top: 8.h, bottom: 8.h, right: 8.w, left: 40.w),
                //         decoration: const BoxDecoration(
                //           borderRadius: BorderRadius.only(
                //             topLeft: Radius.circular(20),
                //             bottomLeft: Radius.circular(20),
                //             topRight: Radius.circular(4),
                //             bottomRight: Radius.circular(4),
                //           ),
                //           color: Colors.blueAccent,
                //         ),
                //         child: Text(
                //           'Add to cart',
                //           style: TextStyle(
                //             fontWeight: FontWeight.w500,
                //             fontSize: 16.sp,
                //             color: AppColors.white,
                //           ),
                //         ),
                //       ),
                //       Positioned(
                //         top: 6.h,
                //         left: 0,
                //         child: Container(
                //           padding: EdgeInsets.all(8.h),
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(100),
                //             color: Colors.blue,
                //           ),
                //           child: Icon(
                //             Icons.shopping_cart_outlined,
                //             color: AppColors.white,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
