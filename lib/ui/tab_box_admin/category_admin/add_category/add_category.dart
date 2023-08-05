import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:planeta_uz/provider/category_provider.dart';
import 'package:planeta_uz/ui/utils/global_textf.dart';
import 'package:provider/provider.dart';

class CategoryADD extends StatefulWidget {
  const CategoryADD({super.key});

  @override
  State<CategoryADD> createState() => _CategoryADDState();
}

class _CategoryADDState extends State<CategoryADD> {
  ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F2F2),
        title: const Text(
          "Category Add",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.h),
        child: ListView(
          children: [
            SizedBox(height: 10.h),
            const Text('Name'),
            SizedBox(height: 10.h),
            GlobalTextField(
              label: "Category Name",
              hintText: "Add Category name",
              textAlign: TextAlign.start,
              controller:
                  context.read<CategoryProvider>().categoryNamecontroller,
            ),
            SizedBox(height: 10.h),
            SizedBox(height: 10.h),
            GlobalTextField(
              label: "Description",
              hintText: "Add Category description",
              maxLines: 5,
              textAlign: TextAlign.start,
              controller:
                  context.read<CategoryProvider>().categoryDesccontroller,
            ),
            SizedBox(height: 10.h),
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.redAccent),
              ),
              onPressed: () async {
                showBottomSheetDialog(context);
              },
              child: context.watch<CategoryProvider>().categoryUrl.isNotEmpty
                  ? Image.network(context.watch<CategoryProvider>().categoryUrl)
                  : const Text('Upload image'),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Color(0xFFF83758)),
              ),
              onPressed: () {
                context.read<CategoryProvider>().addCategory(
                      context: context,
                    );
                Navigator.pop(context);
              },
              child: const Text(
                "Add Category",
              ),
            ),
            SizedBox(height: 5.h),
          ],
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
              ),
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

    if(context.mounted){
      if (xFile != null) {
      await context
          .read<CategoryProvider>()
          .uploadCategoryImage(context, xFile);
            }
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    
    }
  }

  Future<void> _getFromGallery(BuildContext context) async {
    XFile? xFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
    );
    if(context.mounted){
      if (xFile != null) {
      await context
          .read<CategoryProvider>()
          .uploadCategoryImage(context, xFile);
            }
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    
    }
  }
}
