import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:planeta_uz/chat/chat_page.dart';
import 'package:planeta_uz/chat/chat_provider.dart';
import 'package:planeta_uz/chat/chat_service.dart';
import 'package:planeta_uz/data/firebase/category_service.dart';
import 'package:planeta_uz/data/firebase/order_service.dart';
import 'package:planeta_uz/data/firebase/products_service.dart';
import 'package:planeta_uz/data/firebase/profile_service.dart';
import 'package:planeta_uz/provider/auth_provider/login_pro.dart';
import 'package:planeta_uz/provider/category_provider.dart';
import 'package:planeta_uz/provider/order_provider.dart';
import 'package:planeta_uz/provider/products_provider.dart';
import 'package:planeta_uz/provider/profile_provider.dart';
import 'package:planeta_uz/ui/auth/splash/splash.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginProvider(),
          lazy: true,
        ),
        ChangeNotifierProvider(
          create: (context) => CategoryProvider(categoryService: CategoryService()),
          lazy: true,
        ),
        ChangeNotifierProvider(
          create: (context) => ProductsProvider(ProductService()),
          lazy: true,
        ),
        ChangeNotifierProvider(
          create: (context) => OrderProvider(OrderService()),
          lazy: true,
        ),
        ChangeNotifierProvider(
          create: (context) =>
              ProfileProvider(profileService: ProfileService()),
          lazy: true,
        ),
        ChangeNotifierProvider(
          create: (context) =>
              ChatProvider(ChatService()),
          lazy: true,
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashPage(),
        );
      },
    );
  }
}
