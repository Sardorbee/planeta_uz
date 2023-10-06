import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:planeta_uz/data/model/product_model.dart';
import 'package:planeta_uz/provider/products_provider.dart';
import 'package:planeta_uz/ui/tab_box_admin/admin_home/add_products/widgets/select_cat.dart';
import 'package:planeta_uz/utils/colors.dart';
import 'package:planeta_uz/utils/global_textf.dart';
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
  String? catID;
  String? catName;

  textInit() {
    context.read<ProductsProvider>().productsNamecontroller.text =
        widget.productModel.productName;
    context.read<ProductsProvider>().productsDesccontroller.text =
        widget.productModel.description;
    context.read<ProductsProvider>().productsCountcontroller.text =
        widget.productModel.count.toString();
    context.read<ProductsProvider>().productsCurrencycontroller.text =
        widget.productModel.currency;
    context.read<ProductsProvider>().productsPricecontroller.text =
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
        context.read<ProductsProvider>().uploadedImagesUrls.clear();

        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFF2F2F2),
          title: const Text(
            "Update Products",
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            onPressed: () {
              context.read<ProductsProvider>().tozalash();
              context.read<ProductsProvider>().uploadedImagesUrls.clear();

              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(10.h),
          child: ListView(
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
                controller:
                    context.read<ProductsProvider>().productsCountcontroller,
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
                controller:
                    context.read<ProductsProvider>().productsPricecontroller,
                label: 'Price',
              ),
              SizedBox(height: 10.h),
              GlobalTextField(
                hintText: "Add Product Currency",
                textAlign: TextAlign.start,
                controller:
                    context.read<ProductsProvider>().productsCurrencycontroller,
                label: 'Currency',
              ),
              SizedBox(height: 10.h),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(AppColors.mainButtonColor),
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
                  backgroundColor: MaterialStatePropertyAll(Colors.redAccent),
                ),
                onPressed: () async {
                  showBottomSheetDialog();
                },
                child:
                    context.watch<ProductsProvider>().uploadedImagesUrls.isEmpty
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
                                  List<dynamic> x = context
                                      .watch<ProductsProvider>()
                                      .uploadedImagesUrls;
                                  String singleImage = x[index];

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
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.redAccent),
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
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(AppColors.mainButtonColor),
                ),
                onPressed: () {
                  if (context
                          .read<ProductsProvider>()
                          .productsNamecontroller
                          .text
                          .isNotEmpty &&
                      context
                          .read<ProductsProvider>()
                          .productsDesccontroller
                          .text
                          .isNotEmpty &&
                      context
                          .read<ProductsProvider>()
                          .productsCountcontroller
                          .text
                          .isNotEmpty &&
                      context
                          .read<ProductsProvider>()
                          .productsCurrencycontroller
                          .text
                          .isNotEmpty &&
                      context
                          .read<ProductsProvider>()
                          .productsPricecontroller
                          .text
                          .isNotEmpty) {
                    context.read<ProductsProvider>().updateProducts(
                          context: context,
                          productModel: ProductModel(
                              isCarted: 0,
                              count: int.parse(context
                                  .read<ProductsProvider>()
                                  .productsCountcontroller
                                  .text),
                              price: int.parse(context
                                  .read<ProductsProvider>()
                                  .productsPricecontroller
                                  .text),
                              productImages: context
                                  .read<ProductsProvider>()
                                  .uploadedImagesUrls,
                              categoryId:
                                  catID ?? widget.productModel.categoryId,
                              productId: widget.productModel.productId,
                              productName: context
                                  .read<ProductsProvider>()
                                  .productsNamecontroller
                                  .text,
                              description: context
                                  .read<ProductsProvider>()
                                  .productsDesccontroller
                                  .text,
                              createdAt: widget.productModel.createdAt,
                              currency: context
                                  .read<ProductsProvider>()
                                  .productsCurrencycontroller
                                  .text),
                        );
                    context.read<ProductsProvider>().uploadedImagesUrls.clear();

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

  ImagePicker picker = ImagePicker();

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
