import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile_app_ecommerce/controller/auth_controller.dart';
import 'package:mobile_app_ecommerce/controller/navigation_controller.dart';
import 'package:mobile_app_ecommerce/controller/theme_controller.dart';
import 'package:mobile_app_ecommerce/features/cart/cart_controller.dart';
import 'package:mobile_app_ecommerce/features/products/product_controller.dart';
import 'package:mobile_app_ecommerce/features/view/widgets/splash_screen.dart';
import 'package:mobile_app_ecommerce/utils/app_themes.dart';

void main() async{
  await GetStorage.init();
  
  final storage = GetStorage();
  await storage.erase();
  Get.put(ThemeController());
  Get.put(AuthController());
  Get.put(NavigationController());
  Get.put(ProductController());
  Get.put(CartController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fashion Store',
      theme: AppThemes.light,
      darkTheme: AppThemes.dark,
      themeMode: themeController.theme,
      defaultTransition: Transition.fade,
      home:  SplashScreen(),
    );
  }
}
