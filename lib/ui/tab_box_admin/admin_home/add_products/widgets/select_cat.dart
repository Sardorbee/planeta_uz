import 'package:flutter/material.dart';
import 'package:planeta_uz/data/model/category_model.dart';
import 'package:planeta_uz/provider/category_provider.dart';
import 'package:planeta_uz/utils/constants.dart';
import 'package:provider/provider.dart';

class CategorySelectionWidget extends StatelessWidget {
  final Function(String,String) onCategorySelected;

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
            padding: const EdgeInsets.all(10),
            itemCount: categories.length,
            itemBuilder: (BuildContext context, int index) {
              CategoryModel x = categories[index];
              return ListTile(
                onTap: () {
                  onCategorySelected(x.categoryId,x.categoryName);
                  Navigator.pop(context);
                },
                leading: CircleAvatar(
                  backgroundImage:
                  NetworkImage(x.imageUrl),
                ),
                title: Text(
                  x.categoryName.capitalize(),
                  style: const TextStyle(fontSize: 30),
                  overflow: TextOverflow.ellipsis,
                ),
              );
            },
          );
        }
      },
    );
  }
}
