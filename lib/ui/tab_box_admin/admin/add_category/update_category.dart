import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:planeta_uz/data/model/category_model.dart';
import 'package:planeta_uz/provider/category_provider.dart';
import 'package:planeta_uz/provider/ui_utils/loading_dialog.dart';
import 'package:planeta_uz/ui/tab_box_admin/admin/add_category/upload_img.dart';
import 'package:planeta_uz/ui/utils/global_textf.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class UpdateCategory extends StatefulWidget {
  UpdateCategory({super.key, required this.categoryModel});
  CategoryModel categoryModel;

  @override
  State<UpdateCategory> createState() => _UpdateCategoryState();
}

class _UpdateCategoryState extends State<UpdateCategory> {
  XFile? _imageFile;
  String? _imageUrl;

  Future<void> _pickImage() async {
    XFile? pickedFile = await pickImage();
    setState(() {
      _imageFile = pickedFile;
    });
  }

  Future<void> _uploadImage() async {
    showLoading(context: context);
    String? downloadUrl = await uploadImageToFirebase(_imageFile);
    setState(() {
      _imageUrl = downloadUrl;
    });
    hideLoading(dialogContext: context);
  }

  textInit() {
    context.read<CategoryProvider>().categoryNamecontroller.text =
        widget.categoryModel.categoryName;
    context.read<CategoryProvider>().categoryDesccontroller.text =
        widget.categoryModel.description;
  }

  @override
  void initState() {
    textInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<CategoryProvider>().tozalash();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Category Update"),
          leading: IconButton(
            onPressed: () {
              context.read<CategoryProvider>().tozalash();
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(10.h),
          child: ListView(
            children: [
              SizedBox(height: 10.h),
              GlobalTextField(
                  hintText: "Add Category name",
                  textAlign: TextAlign.start,
                  controller:
                      context.read<CategoryProvider>().categoryNamecontroller),
              SizedBox(
                height: 10.h,
              ),
              GlobalTextField(
                  hintText: "Add Category description",
                  maxLines: 5,
                  textAlign: TextAlign.start,
                  controller:
                      context.read<CategoryProvider>().categoryDesccontroller),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.black),
                    ),
                    onPressed: () async {
                      await _pickImage();

                      await _uploadImage();
                    },
                    child: const Text('Upload Image'),
                  ),
                  const SizedBox(width: 20),
                  if (_imageFile != null)
                    Image.file(
                      File(
                        _imageFile!.path,
                      ),
                      height: 70,
                    ),
                ],
              ),
              ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.black),
                ),
                onPressed: () {
                  if (context
                          .read<CategoryProvider>()
                          .categoryNamecontroller
                          .text
                          .isNotEmpty &&
                      context
                          .read<CategoryProvider>()
                          .categoryDesccontroller
                          .text
                          .isNotEmpty) {
                    context.read<CategoryProvider>().updateCategory(
                          context: context,
                          categoryModel: CategoryModel(
                            categoryId: widget.categoryModel.categoryId,
                            categoryName: context
                                .read<CategoryProvider>()
                                .categoryNamecontroller
                                .text,
                            description: context
                                .read<CategoryProvider>()
                                .categoryDesccontroller
                                .text,
                            imageUrl:
                                _imageUrl ?? widget.categoryModel.imageUrl,
                            createdAt: DateTime.now().toString(),
                          ),
                        );
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  "Update Category",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
