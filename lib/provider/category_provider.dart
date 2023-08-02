import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:planeta_uz/data/firebase/category_service.dart';
import 'package:planeta_uz/data/model/category_model.dart';
import 'package:planeta_uz/data/model/product_model.dart';
import 'package:planeta_uz/data/model/universal.dart';
import 'package:planeta_uz/data/upload_service.dart';
import 'package:planeta_uz/provider/ui_utils/loading_dialog.dart';

class CategoryProvider with ChangeNotifier {
  CategoryProvider({required this.categoryService});

  final CategoryService categoryService;

  TextEditingController categoryNamecontroller = TextEditingController();
  TextEditingController categoryDesccontroller = TextEditingController();
  String categoryUrl = '';
  ImagePicker picker = ImagePicker();

  tozalash() {
    categoryDesccontroller.clear();
    categoryNamecontroller.clear();
  }

  Future<void> addCategory({
    required BuildContext context,
    
  }) async {
    if (categoryNamecontroller.text.isNotEmpty &&
        categoryDesccontroller.text.isNotEmpty &&
        categoryUrl.isNotEmpty) {
      showLoading(context: context);
      UniversalData universalData = await categoryService.addCategory(
        categoryModel: CategoryModel(
          categoryId: '',
          categoryName: categoryNamecontroller.text,
          description: categoryDesccontroller.text,
          imageUrl: categoryUrl,
          createdAt: DateTime.now().toString(),
        ),
      );
      if (context.mounted) {
        hideLoading(dialogContext: context);
        tozalash();
      }
      if (universalData.error.isEmpty) {
        if (context.mounted) {
          showMessage(context, universalData.data as String);
        }
      } else {
        if (context.mounted) {
          showMessage(context, universalData.error);
        }
      }
    }
  }

  Future<void> uploadCategoryImage(
    BuildContext context,
    XFile xFile,
  ) async {
    showLoading(context: context);
    UniversalData data = await ImageHandler.imageUploader(xFile);
    if (context.mounted) {
      hideLoading(dialogContext: context);
    }
    if (data.error.isEmpty) {
      categoryUrl = data.data as String;
      notifyListeners();
    } else {
      if (context.mounted) {
        showMessage(context, data.error);
      }
    }
  }

  Future<void> updateCategory({
    required BuildContext context,
    required CategoryModel category,
  }) async {
    if (categoryUrl.isEmpty) categoryUrl = category.imageUrl;
    if (categoryNamecontroller.text.isNotEmpty &&
        categoryDesccontroller.text.isNotEmpty &&
        categoryUrl.isNotEmpty) {
      showLoading(context: context);

      UniversalData universalData = await categoryService.updateCategory(
          categoryModel: CategoryModel(
              categoryId: category.categoryId,
              categoryName: categoryNamecontroller.text,
              description: categoryDesccontroller.text,
              imageUrl: categoryUrl,
              createdAt: category.createdAt));

      if (context.mounted) {
        hideLoading(dialogContext: context);
        categoryUrl = '';
        tozalash();
      }
      if (universalData.error.isEmpty) {
        if (context.mounted) {
          showMessage(context, universalData.data as String);
        }
      } else {
        if (context.mounted) {
          showMessage(context, universalData.error);
        }
      }
    }
  }

  Future<void> deleteCategory({
    required BuildContext context,
    required String categoryId,
  }) async {
    showLoading(context: context);
    UniversalData universalData =
        await categoryService.deleteCategory(categoryId: categoryId);
    if (context.mounted) {
      hideLoading(dialogContext: context);
      tozalash();
    }
    if (universalData.error.isEmpty) {
      if (context.mounted) {
        showMessage(context, universalData.data as String);
      }
    } else {
      if (context.mounted) {
        showMessage(context, universalData.error);
      }
    }
  }

  Stream<List<CategoryModel>> getCategories() =>
      FirebaseFirestore.instance.collection("categories").snapshots().map(
            (event1) => event1.docs
                .map((doc) => CategoryModel.fromJson(doc.data()))
                .toList(),
          );

  Stream<List<ProductModel>> getAllProducts() =>
      FirebaseFirestore.instance.collection("products").snapshots().map(
            (event1) => event1.docs
                .map((doc) => ProductModel.fromJson(doc.data()))
                .toList(),
          );

  showMessage(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
    notifyListeners();
  }
}
