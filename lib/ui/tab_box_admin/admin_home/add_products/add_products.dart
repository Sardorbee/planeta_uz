import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:planeta_uz/provider/products_provider.dart';
import 'package:planeta_uz/ui/tab_box_admin/admin_home/add_products/widgets/add_button.dart';
import 'package:planeta_uz/ui/tab_box_admin/admin_home/add_products/widgets/select_cat.dart';
import 'package:planeta_uz/utils/colors.dart';
import 'package:planeta_uz/utils/global_textf.dart';
import 'package:planeta_uz/utils/constants.dart';
import 'package:provider/provider.dart';

class Addproducts extends StatefulWidget {
  const Addproducts({super.key});

  @override
  State<Addproducts> createState() => _AddproductsState();
}

class _AddproductsState extends State<Addproducts> {
  ImagePicker picker = ImagePicker();

  String? catID;
  String? catName;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<ProductsProvider>().uploadedImagesUrls.clear();

        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFF2F2F2),
          title: const Text(
            "Add Products",
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
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
                    controller:
                        context.read<ProductsProvider>().productsNamecontroller,
                    label: 'Name',
                  ),
                  SizedBox(height: 10.h),
                  GlobalTextField(
                    hintText: "Add Product count",
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.number,
                    controller: context
                        .read<ProductsProvider>()
                        .productsCountcontroller,
                    label: 'Count',
                  ),
                  SizedBox(height: 10.h),
                  GlobalTextField(
                    hintText: "Add Product description",
                    textAlign: TextAlign.start,
                    controller:
                        context.read<ProductsProvider>().productsDesccontroller,
                    label: 'Description',
                  ),
                  SizedBox(height: 10.h),
                  GlobalTextField(
                    keyboardType: TextInputType.number,
                    hintText: "Add Product Price",
                    textAlign: TextAlign.start,
                    controller: context
                        .read<ProductsProvider>()
                        .productsPricecontroller,
                    label: 'Price',
                  ),
                  SizedBox(height: 10.h),
                 /* GlobalTextField(
                    hintText: "Add Product Currency",
                    textAlign: TextAlign.start,
                    controller: context
                        .read<ProductsProvider>()
                        .productsCurrencycontroller,
                    label: 'Currency',
                  ),*/
                  SizedBox(height: 10.h),
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.redAccent),
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
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.redAccent),
                    ),
                    onPressed: () async {
                      showBottomSheetDialog();
                    },
                    child: context
                            .watch<ProductsProvider>()
                            .uploadedImagesUrls
                            .isEmpty
                        ? const Text(
                            "Select Image",
                            style: TextStyle(color: Colors.black),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )
                        : SizedBox(
                            height: 100,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                ...List.generate(
                                    context
                                        .watch<ProductsProvider>()
                                        .uploadedImagesUrls
                                        .length, (index) {
                                  String singleImage = context
                                      .watch<ProductsProvider>()
                                      .uploadedImagesUrls[index];
                                  return Container(
                                    padding: const EdgeInsets.all(5),
                                    margin: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Image.network(
                                      singleImage,
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.fill,
                                    ),
                                  );
                                })
                              ],
                            ),
                          ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: context
                  .watch<ProductsProvider>()
                  .uploadedImagesUrls
                  .isNotEmpty,
              child: SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    showBottomSheetDialog();
                  },
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.redAccent),
                  ),
                  child: const Text(
                    "Select Image",
                    style: TextStyle(color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 5.h),
              child: SizedBox(
                width: double.infinity,
                height: 52.h,
                child: AddProductButton(
                  catId: catID,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showBottomSheetDialog() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(24),
          height: 200,
          decoration: BoxDecoration(
            color: AppColors.bbbbbb,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  _getFromGallery();
                  Navigator.pop(context);
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

  Future<void> _getFromGallery() async {
    List<XFile> xFiles = await picker.pickMultiImage(
      maxHeight: 512,
      maxWidth: 512,
    );
    await Provider.of<ProductsProvider>(context, listen: false)
        .uploadProductImages(
      context: context,
      images: xFiles,
    );
  }
}
