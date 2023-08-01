import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:planeta_uz/data/model/category_model.dart';
import 'package:planeta_uz/provider/auth_provider/login_pro.dart';
import 'package:planeta_uz/provider/category_provider.dart';
import 'package:planeta_uz/provider/profile_provider.dart';
import 'package:planeta_uz/ui/tab_box/profile/profile_screen.dart';
import 'package:planeta_uz/ui/tab_box_admin/admin/add_category/add_category.dart';
import 'package:planeta_uz/ui/tab_box_admin/admin/add_category/update_category.dart';
import 'package:provider/provider.dart';

class HomeScreenAdmin extends StatelessWidget {
  const HomeScreenAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    LoginProvider x = context.read<LoginProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Category Page'),
        actions: [
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
                  )
                : CircleAvatar(
                    foregroundImage: NetworkImage(
                      context.read<ProfileProvider>().currentUser!.photoURL!,
                      scale: 2,
                    ),
                  ),
          ),
          SizedBox(
            width: 12.w,
          ),
        ],
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
                                      context
                                          .read<CategoryProvider>()
                                          .deleteCategory(
                                            context: context,
                                            categoryId:
                                                categoryModel.categoryId,
                                          );
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
                          title: Text(categoryModel.categoryName),
                          subtitle: Text(categoryModel.description),
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
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CategoryADD()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}