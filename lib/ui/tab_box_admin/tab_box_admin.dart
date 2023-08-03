import 'package:flutter/material.dart';
import 'package:planeta_uz/ui/tab_box/profile/profile_screen.dart';
import 'package:planeta_uz/ui/tab_box_admin/category_admin/category_admin.dart';
import 'package:planeta_uz/ui/tab_box_admin/cart_admin/cart_admin.dart';
import 'package:planeta_uz/ui/tab_box_admin/admin_home/admin_home.dart';

class TabBoxAdmin extends StatefulWidget {
  const TabBoxAdmin({super.key});

  @override
  State<TabBoxAdmin> createState() => _TabBoxAdminState();
}

class _TabBoxAdminState extends State<TabBoxAdmin> {
  List<Widget> screens = [];

  int currentIndex = 0;

  @override
  void initState() {
    screens = [
      const ProductScreenAdmin(),
      const CategoryScreenAdmin(),
      const CartAdmin(),
      const ProfileScreen(),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFFEB3030),
        unselectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: "Category"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: "Profile"),
        ],
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
