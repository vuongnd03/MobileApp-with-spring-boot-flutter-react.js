import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app_ecommerce/features/products/product.dart';
import 'package:mobile_app_ecommerce/features/products/product_controller.dart';
import 'package:mobile_app_ecommerce/utils/app_teststyle.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  late final ProductController productController;

  @override
  void initState() {
    super.initState();
    productController = Get.find<ProductController>();
    productController.fetchWishlist(); // Gọi API một lần khi mở màn
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Danh sách yêu thích',
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
        ],
      ),
      body: Obx(() {
        final wishlist = productController.wishlistProducts;
        return CustomScrollView(
          slivers: [
            // summary section
            SliverToBoxAdapter(
              child: _buildSummarySection(context, wishlist.length),
            ),
            // wishlist items
            if (wishlist.isEmpty)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(child: Text('Your wishlist is empty')),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _buildWishlistItem(
                      context,
                      wishlist[index],
                    ),
                    childCount: wishlist.length,
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }

  Widget _buildSummarySection(BuildContext context, int wishlistCount) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[850] : Colors.grey[100],
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(16),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$wishlistCount Items',
                style: AppTestStyle.withColor(
                  AppTestStyle.h2,
                  Theme.of(context).textTheme.bodyLarge!.color!,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'In your wishlist',
                style: AppTestStyle.withColor(
                  AppTestStyle.bodyMedium,
                  isDark ? Colors.grey[400]! : Colors.grey[600]!,
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
            ),
            child: Text(
              'Add All to cart',
              style: AppTestStyle.withColor(
                AppTestStyle.buttonMedium,
                Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWishlistItem(BuildContext context, Product product) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.2)
                : Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Row(
        children: [
          // product image
          ClipRRect(
            borderRadius:
                const BorderRadius.horizontal(left: Radius.circular(12)),
            child: Image.network(
              product.imageUrl,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  const SizedBox(width: 120, height: 120, child: Icon(Icons.broken_image)),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTestStyle.withColor(
                      AppTestStyle.bodyLarge,
                      Theme.of(context).textTheme.bodyLarge!.color!,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.category,
                    style: AppTestStyle.withColor(
                      AppTestStyle.bodySmall,
                      isDark ? Colors.grey[400]! : Colors.grey[600]!,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        // Đảm bảo price là double trong model
                        '\$${product.price.toStringAsFixed(2)}',
                        style: AppTestStyle.withColor(
                          AppTestStyle.h3,
                          Theme.of(context).textTheme.bodyLarge!.color!,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              // TODO: add to cart
                            },
                            icon: Icon(
                              Icons.shopping_cart_outlined,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              // TODO: gọi API xoá khỏi wishlist nếu có
                            },
                            icon: Icon(
                              Icons.delete_outline,
                              color:
                                  isDark ? Colors.grey[400] : Colors.grey[600],
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
