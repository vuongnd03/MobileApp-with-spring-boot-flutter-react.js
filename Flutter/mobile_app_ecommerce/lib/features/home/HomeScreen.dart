import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mobile_app_ecommerce/controller/theme_controller.dart';
import 'package:mobile_app_ecommerce/features/cart/cart_screen.dart';
import 'package:mobile_app_ecommerce/features/notifications/view/notification_screen.dart';
import 'package:mobile_app_ecommerce/features/products/all_product_screen.dart';
import 'package:mobile_app_ecommerce/features/products/product_controller.dart';
import 'package:mobile_app_ecommerce/features/view/widgets/category_chips.dart';
import 'package:mobile_app_ecommerce/features/view/widgets/custom_search_bar.dart';
import 'package:mobile_app_ecommerce/features/view/widgets/product_grid.dart';
import 'package:mobile_app_ecommerce/features/view/widgets/sale_banner.dart';


class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = Get.find<ProductController>();
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            //header section
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/images/avatar.jpg'),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi Duc Vuong',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          ),
                      ),
                      Text(
                        'Good Morning',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          ),
                      ),
                    ],
                  ),
                  Spacer(),
                  // notification icon
                  IconButton(
                    onPressed: () => Get.to(()=> NotificationScreen()),
                    icon: Icon(Icons.notifications_outlined),
                    ),
                    //gio hang
                  IconButton(
                    onPressed: () => Get.to(() => const CartScreen()),
                    icon: Icon(Icons.shopping_bag_outlined),
                    ),
                    //Theme button
                    GetBuilder<ThemeController>(
                      builder:(controller)=> IconButton(
                        onPressed: () => controller.toggleTheme(),
                        icon: Icon(
                          controller.isDarkMode 
                          ? Icons.light_mode 
                          : Icons.dark_mode,
                        ),

                        ), 
                    ),
                ],
              ),
              ),
              //Search bar
              CustomSearchBar(),
              //category chips
              const CategoryChips(),

              //sale banner 
              const SaleBanner(),
              //popular product
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Sản phẩm phổ biến',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.to(() =>AllProductScreen()),
                      child: Text(
                        'See All',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    )
                  ],
                ), 
                ),
                //product grid
                 Expanded(
              child: Obx(() {
                if (productController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ProductGrid(products: productController.products);
              }),
            ),
          ],
        )),
    );
  }
}