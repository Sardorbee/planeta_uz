import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:planeta_uz/data/model/category_model.dart';
import 'package:planeta_uz/data/model/product_model.dart';
import 'package:planeta_uz/provider/category_provider.dart';
import 'package:planeta_uz/provider/products_provider.dart';
import 'package:planeta_uz/provider/profile_provider.dart';
import 'package:planeta_uz/ui/tab_box/home/widgets/products_count.dart';
import 'package:planeta_uz/ui/tab_box/home/widgets/small_button.dart';
import 'package:planeta_uz/ui/tab_box/home/widgets/text_field.dart';
import 'package:planeta_uz/ui/tab_box/profile/profile_screen.dart';
import 'package:planeta_uz/ui/tab_box/widgets/global_mason.dart';
import 'package:planeta_uz/ui/utils/colors.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategoryId = "all";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFF2F2F2),
        actions: [
          Image.asset(
            'assets/png/splash.png',
            height: 31.h,
            width: 38.w,
          ),
          SizedBox(width: 9.w),
          Center(
            child: Text(
              'The Gallactic Baazar',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.c_4392F9,
              ),
            ),
          ),
          SizedBox(width: 79.w),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen()));
            },
            icon: context.read<ProfileProvider>().currentUser!.photoURL == null
                ? Icon(
                    Icons.account_circle,
                    size: 40.h,
                    color: Colors.black,
                  )
                : CircleAvatar(
                    foregroundImage: NetworkImage(
                      context.read<ProfileProvider>().currentUser!.photoURL!,
                      scale: 2,
                    ),
                  ),
          ),
          SizedBox(width: 12.w),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            const MyTextField(),
            SizedBox(height: 17.h),
            Row(
              children: [
                ProductsCount(selectedId: selectedCategoryId),
                const Spacer(),
                SmallButton(text: 'Sort', iconData: Icons.sort),
                SizedBox(width: 12.w),
                SmallButton(
                    text: 'Filter', iconData: Icons.filter_alt_outlined),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.11,
              child: StreamBuilder<List<CategoryModel>>(
                stream: context.read<CategoryProvider>().getCategories(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<CategoryModel>> snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data!.isNotEmpty
                        ? SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedCategoryId = "all";
                                      });
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(6.0),
                                      child: Column(
                                        children: [
                                          CircleAvatar(),
                                          Center(
                                            child: Text(
                                              "All",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  ...List.generate(
                                    snapshot.data!.length,
                                    (index) {
                                      CategoryModel categoryModel =
                                          snapshot.data![index];
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedCategoryId =
                                                categoryModel.categoryId;
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Column(
                                            children: [
                                              CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    categoryModel.imageUrl),
                                              ),
                                              Center(
                                                child: Text(
                                                  categoryModel.categoryName,
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ]),
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
            ),
            Expanded(
              child: StreamBuilder<List<ProductModel>>(
                stream: selectedCategoryId == 'all'
                    ? context.read<ProductsProvider>().getProducts()
                    : selectedCategoryId != 'all'
                        ? context
                            .read<ProductsProvider>()
                            .getProductsByCategoryId(selectedCategoryId)
                        : context.read<ProductsProvider>().getProducts(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<ProductModel>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox();
                  } else if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else {
                    List<ProductModel>? products = snapshot.data;
                    if (products != null && products.isNotEmpty) {
                      return GlobalMason(products: products);
                    } else {
                      // Empty data
                      return Center(
                          child: Lottie.asset("assets/lottie/empty_box.json"));
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
