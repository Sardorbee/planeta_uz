
import 'package:flutter/material.dart';
import 'package:planeta_uz/data/model/category_model.dart';
import 'package:planeta_uz/provider/category_provider.dart';
import 'package:provider/provider.dart';

class CategorySelectionWidget extends StatelessWidget {
  final Function(String) onCategorySelected;

  const CategorySelectionWidget({Key? key, required this.onCategorySelected})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CategoryModel>>(
      stream: context.read<CategoryProvider>().getCategories(),
      builder:
          (BuildContext context, AsyncSnapshot<List<CategoryModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        } else {
          List<CategoryModel> categories = snapshot.data!;
          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (BuildContext context, int index) {
              CategoryModel x = categories[index];
              return GestureDetector(
                onTap: () => onCategorySelected(x
                    .categoryId), // Call the callback with the selected category ID
                child: Row(
                  children: [
                    SizedBox(
                      height: 50,
                      width: 100,
                      child: Text(x.categoryName),
                    ),
                  ],
                ),
              );
            },
          );
          ;
        }
      },
    );
  }
}
