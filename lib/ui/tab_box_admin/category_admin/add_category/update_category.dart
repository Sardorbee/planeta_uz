import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:planeta_uz/data/model/category_model.dart';
import 'package:planeta_uz/data/upload_service.dart';
import 'package:planeta_uz/provider/category_provider.dart';
import 'package:planeta_uz/provider/ui_utils/loading_dialog.dart';
import 'package:planeta_uz/ui/tab_box_admin/category_admin/add_category/upload_img.dart';
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
  ImagePicker picker = ImagePicker();


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
            icon: const Icon(
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
                    context.read<CategoryProvider>().categoryNamecontroller,
                label: 'Name',
              ),
              SizedBox(height: 10.h),
              GlobalTextField(
                hintText: "Add Category description",
                maxLines: 5,
                textAlign: TextAlign.start,
                controller:
                    context.read<CategoryProvider>().categoryDesccontroller,
                label: 'Description',
              ),

              SizedBox(
                height: 150,
                width: 150,
                child: context.watch<CategoryProvider>().categoryUrl.isEmpty
                    ? Image.network(widget.categoryModel.imageUrl)
                    : Image.network(
                        context.watch<CategoryProvider>().categoryUrl),
              ),
              ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.black),
                ),
                onPressed: () async {
                  showBottomSheetDialog(context);
                },
                child: const Text('Upload Image'),

              ),
              const SizedBox(width: 20),
              ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.black),
                ),
                onPressed: () {
                  context.read<CategoryProvider>().updateCategory(
                      context: context, category: widget.categoryModel);
                  Navigator.pop(context);

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

  void showBottomSheetDialog(BuildContext x) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: x,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(24),
          height: 200,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 255, 248, 248),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  _getFromCamera(context);
                },
                leading: const Icon(Icons.camera_alt),
                title: const Text("Select from Camera"),
              ),
              ListTile(
                onTap: () {
                  _getFromGallery(context);
                },
                leading: const Icon(Icons.photo),
                title: const Text("Select from Gallery"),
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> _getFromCamera(BuildContext context) async {
    XFile? xFile = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 512,
      maxWidth: 512,
    );

    if (xFile != null) {
      await context
          .read<CategoryProvider>()
          .uploadCategoryImage(context, xFile);
    }
    Navigator.pop(context);
  }

  Future<void> _getFromGallery(BuildContext context) async {
    XFile? xFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
    );
    if (xFile != null) {
      await context
          .read<CategoryProvider>()
          .uploadCategoryImage(context, xFile);
    }
    Navigator.pop(context);
  }

}
