import 'package:flutter/material.dart';
import 'package:planeta_uz/data/model/category_model.dart';
import 'package:planeta_uz/provider/category_provider.dart';
import 'package:planeta_uz/ui/utils/colors.dart';
import 'package:provider/provider.dart';

class CategoryProducts extends StatefulWidget {
  const CategoryProducts({super.key});

  @override
  State<CategoryProducts> createState() => _CategoryProductsState();
}

class _CategoryProductsState extends State<CategoryProducts> {
  String selectedCategoryId = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: StreamBuilder<List<CategoryModel>>(
        stream: context.read<CategoryProvider>().getCategories(),
        builder: (BuildContext context,
            AsyncSnapshot<List<CategoryModel>> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.isNotEmpty
                ? Container(
                    margin: const EdgeInsets.all(5),
                    height: 70,
                    width: MediaQuery.of(context).size.width,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(
                        snapshot.data!.length,
                        (index) {
                          CategoryModel categoryModel = snapshot.data![index];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedCategoryId = categoryModel.categoryId;
                              });
                              print(selectedCategoryId);
                            },
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(categoryModel.imageUrl),
                                ),
                                Center(
                                  child: Text(
                                    categoryModel.categoryName,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
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
    );
  }
}
