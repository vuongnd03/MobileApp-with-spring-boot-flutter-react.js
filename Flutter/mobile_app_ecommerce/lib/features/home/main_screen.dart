import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app_ecommerce/controller/navigation_controller.dart';
import 'package:mobile_app_ecommerce/controller/theme_controller.dart';
import 'package:mobile_app_ecommerce/features/home/HomeScreen.dart';
import 'package:mobile_app_ecommerce/features/products/shopping_screen.dart';
import 'package:mobile_app_ecommerce/features/products/wishlist_screen.dart';
import 'package:mobile_app_ecommerce/features/profile/account_screen.dart';
import 'package:mobile_app_ecommerce/features/view/widgets/custom_bottom_navbar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
        final NavigationController navigationController = Get.put(NavigationController());
    return GetBuilder<ThemeController>(builder: (ThemeController) => Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: AnimatedSwitcher(
        duration:const Duration(milliseconds: 200),
          child: Obx(
            ()=> IndexedStack(
              key: ValueKey(navigationController.currentIndex.value),
              index: navigationController.currentIndex.value,
              children: const[
                Homescreen(),
                ShoppingScreen(),
                WishlistScreen(),
                AccountScreen(),
              ],
            )
          ),
        ),
        bottomNavigationBar:const CustomBottomNavbar(),
    ));
  }
}