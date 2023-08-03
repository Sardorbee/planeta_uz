import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:planeta_uz/data/model/product_model.dart';
import 'package:planeta_uz/provider/products_provider.dart';
import 'package:planeta_uz/provider/ui_utils/loading_dialog.dart';
import 'package:planeta_uz/ui/tab_box_admin/category_admin/add_category/upload_img.dart';
import 'package:planeta_uz/ui/tab_box_admin/admin_home/add_products/widgets/select_cat.dart';
import 'package:planeta_uz/ui/utils/global_textf.dart';
import 'package:planeta_uz/utils/constants.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Updateproducts extends StatefulWidget {
  Updateproducts({super.key, required this.productModel});

  ProductModel productModel;

  @override
  State<Updateproducts> createState() => _UpdateproductsState();
}

class _UpdateproductsState extends State<Updateproducts> {
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
    showLoading(context: context);
    String? downloadUrl = await uploadImageToFirebase(_imageFile);
    setState(() {
      _imageUrl = downloadUrl;
    });
    hideLoading(dialogContext: context);
  }

  textInit() {
    context.read<ProductsProvider>().ProductsNamecontroller.text =
        widget.productModel.productName;
    context.read<ProductsProvider>().ProductsDesccontroller.text =
        widget.productModel.description;
    context.read<ProductsProvider>().ProductsCountcontroller.text =
        widget.productModel.count.toString();
    context.read<ProductsProvider>().ProductsCurrencycontroller.text =
        widget.productModel.currency;
    context.read<ProductsProvider>().ProductsPricecontroller.text =
        widget.productModel.price.toString();
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
        context.read<ProductsProvider>().tozalash();

        return true;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF2F2F2),
        appBar: AppBar(
          title: const Text(
            'Admin Product Page',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              context.read<ProductsProvider>().tozalash();
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          backgroundColor: const Color(0xFFF2F2F2),
          elevation: 0,
        ),
        body: ListView(
          padding: EdgeInsets.all(10.h),
          children: [
            SizedBox(height: 10.h),
            GlobalTextField(
              hintText: "Add Product name",
              textAlign: TextAlign.start,
              controller:
                  context.read<ProductsProvider>().ProductsNamecontroller,
              label: 'Name',
            ),
            SizedBox(height: 10.h),
            GlobalTextField(
              hintText: "Add Product count",
              textAlign: TextAlign.start,
              keyboardType: TextInputType.number,
              controller:
                  context.read<ProductsProvider>().ProductsCountcontroller,
              label: 'Count',
            ),
            SizedBox(height: 10.h),
            GlobalTextField(
              hintText: "Add Product description",
              textAlign: TextAlign.start,
              controller:
                  context.read<ProductsProvider>().ProductsDesccontroller,
              label: 'Description',
            ),
            SizedBox(height: 10.h),
            GlobalTextField(
              keyboardType: TextInputType.number,
              hintText: "Add Product Price",
              textAlign: TextAlign.start,
              controller:
                  context.read<ProductsProvider>().ProductsPricecontroller,
              label: 'Price',
            ),
            SizedBox(height: 10.h),
            GlobalTextField(
              hintText: "Add Product Currency",
              textAlign: TextAlign.start,
              controller:
                  context.read<ProductsProvider>().ProductsCurrencycontroller,
              label: 'Currency',
            ),
            SizedBox(height: 10.h),
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.black),
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return CategorySelectionWidget(
                      onCategorySelected: (p0, name) {
                        setState(() {
                          catID = p0;
                          catName = name;
                        });
                      },
                    );
                  },
                );
              },
              child: catName != null
                  ? Text(catName!.capitalize())
                  : const Text(
                      "Choose Category",
                    ),
            ),
            const SizedBox(width: 20),
            _imageFile != null
                ? Image.file(
                    File(
                      _imageFile!.path,
                    ),
                    height: 70,
                  )
                : Image.network(
                    widget.productModel.productImages[0],
                    height: 70,
                  ),
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
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.black),
              ),
              onPressed: () {
                if (context
                        .read<ProductsProvider>()
                        .ProductsNamecontroller
                        .text
                        .isNotEmpty &&
                    context
                        .read<ProductsProvider>()
                        .ProductsDesccontroller
                        .text
                        .isNotEmpty &&
                    context
                        .read<ProductsProvider>()
                        .ProductsCountcontroller
                        .text
                        .isNotEmpty &&
                    context
                        .read<ProductsProvider>()
                        .ProductsCurrencycontroller
                        .text
                        .isNotEmpty &&
                    context
                        .read<ProductsProvider>()
                        .ProductsPricecontroller
                        .text
                        .isNotEmpty) {
                  context.read<ProductsProvider>().updateProducts(
                        context: context,
                        productModel: ProductModel(
                            count: int.parse(context
                                .read<ProductsProvider>()
                                .ProductsCountcontroller
                                .text),
                            price: int.parse(context
                                .read<ProductsProvider>()
                                .ProductsPricecontroller
                                .text),
                            productImages: [
                              _imageUrl ?? widget.productModel.productImages[0]
                            ],
                            categoryId: catID ?? widget.productModel.categoryId,
                            productId: widget.productModel.productId,
                            productName: context
                                .read<ProductsProvider>()
                                .ProductsNamecontroller
                                .text,
                            description: context
                                .read<ProductsProvider>()
                                .ProductsDesccontroller
                                .text,
                            createdAt: widget.productModel.createdAt,
                            currency: context
                                .read<ProductsProvider>()
                                .ProductsCurrencycontroller
                                .text),
                      );
                  Navigator.pop(context);
                }
              },
              child: const Text(
                "Update Product",
              ),
            )
          ],
        ),
      ),
    );
  }
}
