import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_app_ecommerce/features/home/main_screen.dart';
import 'package:mobile_app_ecommerce/features/my%20order/view/screen/my_oder_screen.dart';
import 'package:mobile_app_ecommerce/utils/app_teststyle.dart';

class OrderConfirmationScreen extends StatelessWidget {
  final String orderNumber;
  final double totalAmount;
  const OrderConfirmationScreen({
    super.key, 
    required this.orderNumber, 
    required this.totalAmount,
    });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/animations/order_success.json',
                width: 200,
                height: 200,
                repeat: false,
              ),
              const SizedBox(height: 32),
              Text(
                'Đơn hàng của bạn đã được xác nhận!',
                textAlign: TextAlign.center,
                style: AppTestStyle.withColor(
                    AppTestStyle.h2, 
                    isDark ? Colors.white : Colors.black,
            ),
              ),
              const SizedBox(height: 16),
              Text(
                'Mã đơn của bạn $orderNumber đã được đặt hàng thành công.',
                textAlign: TextAlign.center,
                style: AppTestStyle.withColor(
                    AppTestStyle.bodyLarge, 
                    isDark ? Colors.grey[400]! : Colors.grey[600]!,
            ),
              ),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: (){
                  Get.to(()=> MyOderScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 48,vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Theo dõi đơn hàng',
                  style: AppTestStyle.withColor(
                    AppTestStyle.buttonMedium, 
                    Colors.white,
            ),
                ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: (){
                    Get.offAll(() => const MainScreen());
                  }, 
                  child: Text(
                    'Tiếp tục mua sắm',
                    style: AppTestStyle.withColor(
                      AppTestStyle.bodyLarge, 
                      Theme.of(context).primaryColor,
                    ),
                  ),
                  ),
            ],
          ),
          ),
        ),
    );
  }
}