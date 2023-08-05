import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:planeta_uz/provider/products_provider.dart';
import 'package:planeta_uz/ui/tab_box_admin/category_admin/add_category/upload_img.dart';
import 'package:planeta_uz/ui/tab_box_admin/admin_home/add_products/widgets/add_button.dart';
import 'package:planeta_uz/ui/tab_box_admin/admin_home/add_products/widgets/select_cat.dart';
import 'package:planeta_uz/utils/global_textf.dart';
import 'package:planeta_uz/utils/constants.dart';
import 'package:provider/provider.dart';

class Addproducts extends StatefulWidget {
  const Addproducts({super.key});

  @override
  State<Addproducts> createState() => _AddproductsState();
}

class _AddproductsState extends State<Addproducts> {
  XFile? _imageFile;
  String? _imageUrl;
  String? catID;
  String? catName;

  Future<void> _pickImage() async {
    XFile? pickedFile = await pickImage();
    setState(() {
      _imageFile = pickedFile;
    });
  }

  Future<void> _uploadImage() async {
    String? downloadUrl = await uploadImageToFirebase(_imageFile);
    setState(() {
      _imageUrl = downloadUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xFFF2F2F2),

        title: const Text("Add Products",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(10.h),
              children: [
                SizedBox(height: 10.h),
                GlobalTextField(
                    hintText: "Add Product name",
                    textAlign: TextAlign.start,
                    controller: context
                        .read<ProductsProvider>()
                        .productsNamecontroller, label: 'Name',),
                SizedBox(height: 10.h),
                GlobalTextField(
                    hintText: "Add Product count",
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.number,
                    controller: context
                        .read<ProductsProvider>()
                        .productsCountcontroller, label: 'Count',),
                SizedBox(height: 10.h),
                GlobalTextField(
                    hintText: "Add Product description",
                    textAlign: TextAlign.start,
                    controller: context
                        .read<ProductsProvider>()
                        .productsDesccontroller, label: 'Description',),
                SizedBox(height: 10.h),
                GlobalTextField(
                    keyboardType: TextInputType.number,
                    hintText: "Add Product Price",
                    textAlign: TextAlign.start,
                    controller: context
                        .read<ProductsProvider>()
                        .productsPricecontroller, label: 'Price',),
                SizedBox(height: 10.h),
                GlobalTextField(
                    hintText: "Add Product Currency",
                    textAlign: TextAlign.start,
                    controller: context
                        .read<ProductsProvider>()
                        .productsCurrencycontroller, label: 'Currency',),
                SizedBox(height: 10.h),
                ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.redAccent),
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return CategorySelectionWidget(
                          onCategorySelected: (p0,name) {
                            setState(() {
                              catID = p0;
                              catName = name;
                            });
                          },
                        );
                      },
                    );
                  },
                  child: catName!=null ? Text(catName!.capitalize()) :const Text(
                    "Choose Category",
                  ),
                ),
                ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.redAccent),
                  ),
                  onPressed: () async {
                    await _pickImage();

                    await _uploadImage();
                  },
                  child: _imageFile != null
                      ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.file(
                            File(
                              _imageFile!.path,
                            ),
                            height: 70,
                          ),
                      )
                      : const Text('Upload Image'),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.w,right: 10.w,bottom: 5.h),
            child: SizedBox(
              width: double.infinity,
              height: 52.h,
              child: AddProductButton(
                imageUrl: _imageUrl,
                catId: catID,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
