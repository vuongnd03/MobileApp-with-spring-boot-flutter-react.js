import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app_ecommerce/features/checkout/widget/address_card.dart';
import 'package:mobile_app_ecommerce/features/checkout/widget/checkout_bottom_bar.dart';
import 'package:mobile_app_ecommerce/features/checkout/widget/order_summary_card.dart';
import 'package:mobile_app_ecommerce/features/checkout/widget/payment_method_card.dart';
import 'package:mobile_app_ecommerce/features/order%20confirm/screen/order_confirmation_screen.dart';
import 'package:mobile_app_ecommerce/utils/app_teststyle.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        title: Text(
          'Thanh toán',
          style: AppTestStyle.withColor(
            AppTestStyle.h3,
            isDark ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(context, 'Địa chỉ giao hàng'),
            const SizedBox(height: 16),
            const AddressCard(),
            const SizedBox(height: 24),
            _buildSectionTitle(context, 'Phương thức thanh toán'),
            const SizedBox(height: 16),
            const PaymentMethodCard(),
            const SizedBox(height: 24),
            _buildSectionTitle(context, 'Tóm tắt đơn hàng'),
            const SizedBox(height: 16),
            const OrderSummaryCard(),
          ],
        ),
      ),
      bottomNavigationBar: CheckoutBottomBar(
        totalAmount: 97.49,
        onPlaceOrder: () {
          //generate a radom order number(in real app,this would come from backend)
          final orderNumber =
              'ORD${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';

          Get.to(
            () => OrderConfirmationScreen(
              orderNumber: orderNumber,
              totalAmount: 97.49,
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: AppTestStyle.withColor(
        AppTestStyle.h3,
        Theme.of(context).textTheme.bodyLarge!.color!,
      ),
    );
  }
}
