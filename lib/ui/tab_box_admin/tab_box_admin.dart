import 'package:flutter/material.dart';
import 'package:planeta_uz/ui/tab_box_admin/category/home_page_admin.dart';
import 'package:planeta_uz/ui/tab_box_admin/search/search_screen_admin.dart';
import 'package:planeta_uz/ui/tab_box_admin/settings/settings_screen_admin.dart';
import 'package:planeta_uz/ui/tab_box_admin/wishlist/wishlist_screen_admin.dart';

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
      const SearchScreenAdmin(),
      const SettingsScreenAdmin(),
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
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
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
