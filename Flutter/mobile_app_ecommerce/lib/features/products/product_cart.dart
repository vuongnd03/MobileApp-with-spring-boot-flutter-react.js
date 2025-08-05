import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:mobile_app_ecommerce/controller/auth_controller.dart';
import 'package:mobile_app_ecommerce/features/products/product.dart';
import 'package:mobile_app_ecommerce/utils/app_teststyle.dart';

class ProductCart extends StatefulWidget {
  final Product product;
  const ProductCart({super.key, required this.product});

  @override
  State<ProductCart> createState() => _ProductCartState();
}

class _ProductCartState extends State<ProductCart> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      constraints: BoxConstraints(
        maxWidth: screenWidth * 0.9,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black.withOpacity(0.3) : Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              // Product image
              AspectRatio(
                aspectRatio: 16 / 9,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: Image.network(
                    widget.product.imageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ),
              // Favorite button
              Positioned(
                right: 8,
                top: 8,
                child: IconButton(
                  icon: Icon(
                    widget.product.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: widget.product.isFavorite
                        ? Theme.of(context).primaryColor
                        : (isDark ? Colors.grey[400] : Colors.grey),
                  ),
                  onPressed: () async {
                    final authController = Get.find<AuthController>();

                    setState(() {
                      widget.product.isFavorite = !widget.product.isFavorite;
                    });

                    // Gọi API thêm vào wishlist
                    await authController.addToWishlist(widget.product.id);
                  },
                ),
              ),
              // Discount label
              if (widget.product.oldprice != null)
                Positioned(
                  left: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '${calculateDiscount(widget.product.price, widget.product.oldprice!)}% OFF',
                      style: AppTestStyle.withColor(
                        AppTestStyle.withWeight(AppTestStyle.bodySmall, FontWeight.bold),
                        Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          // Product details
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.name,
                  style: AppTestStyle.withColor(
                    AppTestStyle.withWeight(AppTestStyle.h3, FontWeight.bold),
                    Theme.of(context).textTheme.bodyLarge!.color!,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: screenWidth * 0.01),
                Text(
                  widget.product.category,
                  style: AppTestStyle.withColor(
                    AppTestStyle.bodyMedium,
                    isDark ? Colors.grey[400]! : Colors.grey[600]!,
                  ),
                ),
                SizedBox(height: screenWidth * 0.01),
                Row(
                  children: [
                    Text(
                      '\$${widget.product.price.toStringAsFixed(2)}',
                      style: AppTestStyle.withColor(
                        AppTestStyle.withWeight(AppTestStyle.bodyLarge, FontWeight.bold),
                        Theme.of(context).textTheme.bodyLarge!.color!,
                      ),
                    ),
                    if (widget.product.oldprice != null) ...[
                      SizedBox(width: screenWidth * 0.01),
                      Text(
                        '\$${widget.product.oldprice!.toStringAsFixed(2)}',
                        style: AppTestStyle.withColor(
                          AppTestStyle.bodySmall,
                          isDark ? Colors.grey[400]! : Colors.grey[600]!,
                        ).copyWith(
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Calculate discount
  int calculateDiscount(double currentPrice, double oldPrice) {
    return (((oldPrice - currentPrice) / oldPrice) * 100).round();
  }
}
