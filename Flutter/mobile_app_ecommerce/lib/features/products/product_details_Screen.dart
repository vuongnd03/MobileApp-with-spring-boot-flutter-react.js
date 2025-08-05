import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile_app_ecommerce/features/cart/cart_controller.dart';
import 'package:mobile_app_ecommerce/features/products/product.dart';
import 'package:mobile_app_ecommerce/utils/app_teststyle.dart';
import 'package:share_plus/share_plus.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final CartController cartController = Get.find<CartController>();
    final _storage = GetStorage();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: ()=> Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : Colors.black,
          ),
          ),
        title: Text(
          'Chi tiết sản phẩm',
          style: AppTestStyle.withColor(
            AppTestStyle.h3,
            isDark ? Colors.white : Colors.black,
            ),
        ),
        actions: [
          // share button
          IconButton(onPressed: () => _shareproduct(
            context,
            product.name,
            product.description,
          ),
           icon: Icon(
              Icons.share,
              color:  isDark ? Colors.white : Colors.black,
              ),
              ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                //image
                AspectRatio(
                  aspectRatio: 16/9,
                  child: Image.network(
                    product.imageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    ),
                  ),
                  //favorite button
                  Positioned(child: IconButton(
                    onPressed: (){},
                    icon: Icon(
                      product.isFavorite ?
                      Icons.favorite : Icons.favorite_border,
                      color: product.isFavorite 
                      ?Theme.of(context).primaryColor 
                      :(isDark ? Colors.white : Colors.black),
                    ),
                    ),
                    ),
              ],
            ),
            //product detail
            Padding(padding: EdgeInsets.all(screenWidth * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        product.name,
                        style: AppTestStyle.withColor(
                              AppTestStyle.h2,
                              Theme.of(context).textTheme.headlineMedium!.color!,

                              ),
                              
                      ),
                      ),
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: AppTestStyle.withColor(
                              AppTestStyle.h2,
                              Theme.of(context).textTheme.headlineMedium!.color!,

                              ),
                              
                      ),
                  ],
                ),
                Text(
                    product.category,
                    style: AppTestStyle.withColor(
                          AppTestStyle.bodyMedium,
                            isDark ? Colors.grey[400]! : Colors.grey[600]!,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02,),
                      //size selector
                      SizedBox(height: screenHeight * 0.02),
                       Text(
                    'Miêu tả',
                    style: AppTestStyle.withColor(
                          AppTestStyle.labelMedium,
                          Theme.of(context).textTheme.bodyLarge!.color!,
                        ),
                      ),
                       SizedBox(height: screenHeight * 0.01),
                    Text(
                    product.description,
                    style: AppTestStyle.withColor(
                          AppTestStyle.bodySmall,
                          isDark ? Colors.grey[400]! : Colors.grey[600]!,
                        ),
                      ),
                      if (product.additionalImages.isNotEmpty)
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: product.additionalImages.length,
                          itemBuilder: (context, index) {
                            final image = product.additionalImages[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  image.imageUrl,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                     
              ],
            ),
            )
          ],
        ),
      ),
      //buttons
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () async {
                    try {
                      final userId = _storage.read('userId');
                      if (userId == null) {
                        Get.snackbar('Lỗi', 'Bạn cần đăng nhập trước');
                        return;
                      }
                      final productId = product.id; // Truyền từ sản phẩm hiện tại
                      final quantity = 1;
                      await cartController.addToCart(userId, productId, quantity);
                      Get.snackbar(
                        'Thành công',
                        'Đã thêm vào giỏ hàng',
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                      );
                    } catch (e) {
                      Get.snackbar(
                        'Lỗi',
                        'Không thể thêm vào giỏ hàng: $e',
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.02,
                    ),
                    side: BorderSide(
                      color: isDark ? Colors.white70 : Colors.black12,
                    ),
                  ),
                  child: Text(
                    'Thêm vào giỏ hàng',
                    style: AppTestStyle.withColor(
                      AppTestStyle.buttonMedium,
                      Theme.of(context).textTheme.bodyLarge!.color!,
                    ),
                  ),
                ),
                  ),
                  SizedBox(width: screenWidth * 0.4),
                  Expanded(
                child: ElevatedButton(
                  onPressed: (){},
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.02,
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  child: Text(
                    'Mua ngay',
                    style: AppTestStyle.withColor(
                      AppTestStyle.buttonMedium,
                      Colors.white
                      ),
                    ),
                  ),
                  ),
            ],
          ),
          ),
        ),
    );
  }

  //share product
  Future<void> _shareproduct(
    BuildContext context,
    String productName,
    String description,
  )async{
    //get the render box for share position origin (required for ipad)
    final box = context.findRenderObject() as RenderBox ?;

   // const String shopLink = 'https// yourshop.com/product/cotton-tshirt';
    final String shareMessage = '$description\n\nShop now at "shopLink';

    try{
      final ShareResult result = await Share.share(
        shareMessage,
        subject: productName,
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );
      if(result.status == ShareResultStatus.success){
        debugPrint('Thank you for sharing!');

      }
    }catch(e){
        debugPrint('Error sharing! : $e');

    }
  }
}