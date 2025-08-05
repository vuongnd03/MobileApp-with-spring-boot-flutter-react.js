import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app_ecommerce/features/products/product_controller.dart';
import 'package:mobile_app_ecommerce/features/view/widgets/category_chips.dart';
import 'package:mobile_app_ecommerce/features/view/widgets/filter_bottom_sheet.dart';
import 'package:mobile_app_ecommerce/features/view/widgets/product_grid.dart';
import 'package:mobile_app_ecommerce/utils/app_teststyle.dart';

class ShoppingScreen extends StatelessWidget {
  const ShoppingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final ProductController productController = Get.put(ProductController());

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Mua sắm',
          style: AppTestStyle.withColor(
            AppTestStyle.h3,
            isDark ? Colors.white : Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          IconButton(
            onPressed: () => FilterBottomSheet.show(context),
            icon: Icon(
              Icons.filter_list,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 16),
            child: CategoryChips(),
          ),
          Expanded(
            child: Obx(() {
              if (productController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return ProductGrid(products: productController.products);
            }),
          ),
        ],
      ),
    );
  }
}
