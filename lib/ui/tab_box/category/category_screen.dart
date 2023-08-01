import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:planeta_uz/data/model/category_model.dart';
import 'package:planeta_uz/provider/category_provider.dart';
import 'package:planeta_uz/ui/tab_box/category/widget/products_by_category.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category Screen'),
      ),
      body: StreamBuilder<List<CategoryModel>>(
        stream: context.read<CategoryProvider>().getCategories(),
        builder: (BuildContext context,
            AsyncSnapshot<List<CategoryModel>> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.isNotEmpty
                ? ListView(
                    children: List.generate(
                      snapshot.data!.length,
                      (index) {
                        CategoryModel categoryModel = snapshot.data![index];
                        return ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductsByCAt(
                                      category: categoryModel),
                                ));
                          },
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(categoryModel.imageUrl),
                          ),
                          title: Text(categoryModel.categoryName),
                          subtitle: Text(categoryModel.description),
                        );
                      },
                    ),
                  )
                :  Center(child: Lottie.asset("assets/lottie/empty_box.json"));
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
