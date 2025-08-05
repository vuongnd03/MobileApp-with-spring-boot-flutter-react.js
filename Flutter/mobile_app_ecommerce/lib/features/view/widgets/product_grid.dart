import 'package:flutter/material.dart';
import 'package:mobile_app_ecommerce/features/products/product.dart';
import 'package:mobile_app_ecommerce/features/products/product_cart.dart';
import 'package:mobile_app_ecommerce/features/products/product_details_Screen.dart';

class ProductGrid extends StatelessWidget {
    final List<Product> products;
  const ProductGrid({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        ),
        itemCount: products.length,
        itemBuilder: (context, index){
          final product = products[index];
          return GestureDetector(
            onTap: ()=> Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailsScreen(
                  product: product,
                ),
                ),
                ),
            child: ProductCart(product: product),
          );
        },
    );
  }
}