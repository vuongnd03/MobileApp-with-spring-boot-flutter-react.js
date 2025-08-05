import 'package:flutter/material.dart';
import 'package:mobile_app_ecommerce/utils/app_teststyle.dart';
class CheckoutBottomBar extends StatelessWidget {

  final double totalAmount;
  final VoidCallback onPlaceOrder;

  const CheckoutBottomBar({
      super.key,
     required this.totalAmount, 
     required this.onPlaceOrder});

  @override
  Widget build(BuildContext context) {
     final isDark = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black.withOpacity(0.2)
                : Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          )
        ]
      ), 
      child: ElevatedButton(
        onPressed: onPlaceOrder, 
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          'Đặt hàng (\$${totalAmount.toStringAsFixed(2)})',
          style: AppTestStyle.withColor(
            AppTestStyle.buttonMedium, 
            Colors.white,
            ),
        ),
        ),
      )
      );
  }
}