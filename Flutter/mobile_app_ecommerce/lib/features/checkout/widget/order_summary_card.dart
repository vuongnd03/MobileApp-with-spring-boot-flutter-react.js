import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app_ecommerce/features/cart/cart_controller.dart';
import 'package:mobile_app_ecommerce/utils/app_teststyle.dart';

class OrderSummaryCard extends StatelessWidget {
  const OrderSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cartController = Get.find<CartController>();
    final currency = NumberFormat.currency(locale: "en_US", symbol: "\$");

    return Obx(() {
      double subTotal = cartController.cartItems.fold(
        0.0,
        (sum, item) => sum + item.totalPrice,
      );

      double shippingFee = 5.00; // phí cố định
      double tax = subTotal * 0.05; // giả lập thuế 5%
      double total = subTotal + shippingFee + tax;

      return Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color:
                  isDark
                      ? Colors.black.withOpacity(0.2)
                      : Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            _buildSummaryRow(context, 'Tạm tính', currency.format(subTotal)),
            const SizedBox(height: 8),
            _buildSummaryRow(
              context,
              'Phí vận chuyển',
              currency.format(shippingFee),
            ),
            const SizedBox(height: 8),
            _buildSummaryRow(context, 'Thuế (5%)', currency.format(tax)),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Divider(),
            ),
            _buildSummaryRow(
              context,
              'Tổng cộng',
              currency.format(total),
              isTotal: true,
            ),
          ],
        ),
      );
    });
  }

  Widget _buildSummaryRow(
    BuildContext context,
    String label,
    String value, {
    bool isTotal = false,
  }) {
    final textStyle = isTotal ? AppTestStyle.h3 : AppTestStyle.bodyLarge;
    final color =
        isTotal
            ? Theme.of(context).primaryColor
            : Theme.of(context).textTheme.bodyLarge!.color!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTestStyle.withColor(textStyle, color)),
        Text(value, style: AppTestStyle.withColor(textStyle, color)),
      ],
    );
  }
}
