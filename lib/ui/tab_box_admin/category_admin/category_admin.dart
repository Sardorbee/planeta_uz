import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:planeta_uz/data/model/category_model.dart';
import 'package:planeta_uz/provider/category_provider.dart';
import 'package:planeta_uz/provider/profile_provider.dart';
import 'package:planeta_uz/provider/ui_utils/loading_dialog.dart';
import 'package:planeta_uz/ui/tab_box/profile/profile_screen.dart';
import 'package:planeta_uz/ui/tab_box_admin/category_admin/add_category/add_category.dart';
import 'package:planeta_uz/ui/tab_box_admin/category_admin/add_category/update_category.dart';
import 'package:planeta_uz/utils/constants.dart';
import 'package:provider/provider.dart';

class CategoryScreenAdmin extends StatelessWidget {
  const CategoryScreenAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        title: const Text(
          'Admin Category Page',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: const Color(0xFFF2F2F2),
        elevation: 0,
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
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 16.w,vertical: 10.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          child: ListTile(
                            onLongPress: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Delete'),
                                  content: const Text(
                                      'Are you sure to delete this category?'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('No')),
                                    TextButton(
                                      onPressed: () {

                                        Navigator.pop(context);

                                        showLoading(context: context);

                                        context
                                            .read<CategoryProvider>()
                                            .deleteCategory(
                                              context: context,
                                              categoryId:
                                                  categoryModel.categoryId,
                                            );
                                        hideLoading(dialogContext: context);
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
                                  NetworkImage(categoryModel.imageUrl),
                            ),
                            title: Text(categoryModel.categoryName.capitalize()),
                            subtitle: Text(categoryModel.description.capitalize()),
                            trailing: IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpdateCategory(
                                        categoryModel: categoryModel),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.edit),
                            ),
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
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CategoryADD()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
