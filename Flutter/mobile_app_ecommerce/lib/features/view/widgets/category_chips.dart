import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app_ecommerce/features/products/product_controller.dart';
import 'package:mobile_app_ecommerce/utils/app_teststyle.dart';

class CategoryChips extends StatefulWidget {
  const CategoryChips({super.key});

  @override
  State<CategoryChips> createState() => _CategoryChipsState();
}

class _CategoryChipsState extends State<CategoryChips> {
  int selectedIndex = 0;
  final categories = ['All', 'Laptop', 'Điện Thoại', 'Giày Dép'];
  final ProductController productController = Get.find<ProductController>();

  void _onCategorySelected(String category) {
    if (category == 'All') {
      productController.fetchProducts();
    } else {
      productController.fetchProductsByCategory(category);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: List.generate(
          categories.length,
          (index) => Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ChoiceChip(
              label: Text(
                categories[index],
                style: AppTestStyle.withColor(
                  selectedIndex == index
                      ? AppTestStyle.withWeight(
                          AppTestStyle.bodySmall,
                          FontWeight.w600,
                        )
                      : AppTestStyle.bodySmall,
                  selectedIndex == index
                      ? Colors.white
                      : isDark
                          ? Colors.grey[300]!
                          : Colors.grey[600]!,
                ),
              ),
              selected: selectedIndex == index,
              onSelected: (bool selected) {
                setState(() {
                  selectedIndex = selected ? index : selectedIndex;
                });
                _onCategorySelected(categories[index]);
              },
              selectedColor: Theme.of(context).primaryColor,
              backgroundColor: isDark ? Colors.grey[800] : Colors.grey[100],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              labelPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              side: BorderSide(
                color: selectedIndex == index
                    ? Colors.transparent
                    : isDark
                        ? Colors.grey[700]!
                        : Colors.grey[300]!,
                width: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
