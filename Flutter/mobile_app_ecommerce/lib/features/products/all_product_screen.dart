import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app_ecommerce/features/products/product_controller.dart';
import 'package:mobile_app_ecommerce/features/view/widgets/filter_bottom_sheet.dart';
import 'package:mobile_app_ecommerce/features/view/widgets/product_grid.dart';
import 'package:mobile_app_ecommerce/utils/app_teststyle.dart';

class AllProductScreen extends StatelessWidget {
  const AllProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
        final productController = Get.find<ProductController>();

    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios,
          color: isDark ? Colors.white : Colors.black,
          ),
          ),
          title: Text(
            'Tất cả sản phẩm',
            style: AppTestStyle.withColor(
              AppTestStyle.h3,
              isDark ? Colors.white : Colors.black,
              ),
          ),
          actions: [
            //search icon
            IconButton(
              onPressed: (){},
              icon: Icon(
                Icons.search,
                color: isDark ? Colors.white : Colors.black,
              ),
              ),
              //filter icon
              IconButton(
              onPressed: () => FilterBottomSheet.show(context),
              icon: Icon(
                Icons.filter_list,
                color: isDark ? Colors.white : Colors.black,
              ),
              ),
          ],
      ),
      body: Obx(() {
        if (productController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return ProductGrid(products: productController.products);
      }),

    );

  }
}
