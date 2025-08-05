import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/utils.dart';
import 'package:mobile_app_ecommerce/features/my%20order/model/order.dart';
import 'package:mobile_app_ecommerce/features/my%20order/repository/order_repository.dart';
import 'package:mobile_app_ecommerce/features/my%20order/view/widgets/oder_card.dart';
import 'package:mobile_app_ecommerce/utils/app_teststyle.dart';

class MyOderScreen extends StatelessWidget {
  final OrderRepository _repository = OrderRepository();
  MyOderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return DefaultTabController(length: 3, child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: ()=>Get.back(), 
          icon: Icon(
            Icons.arrow_back_ios,
            color: isDark ? Colors.white : Colors.black,
          ),
          ),
        title: Text(
          'Đơn hàng của tôi',
          style: AppTestStyle.withColor(
            AppTestStyle.h3, 
            isDark ? Colors.white : Colors.black,
            ),
        ),
        bottom: TabBar(
          labelColor: Theme.of(context).primaryColor,
          unselectedLabelColor: isDark ? Colors.grey[400] : Colors.grey[600],
          indicatorColor: Theme.of(context).primaryColor,
          tabs: const[
            Tab(text: 'Đang xử lý'),
            Tab(text: 'Đã hoàn thành'),
            Tab(text: 'Đã hủy'),
          ],
          ),
      ),
      body: TabBarView(
        children: [
          _buildOrderList(context, OrderStatus.active), 
          _buildOrderList(context, OrderStatus.complete), 
          _buildOrderList(context, OrderStatus.cancelled), 
      ],
      ),
    ),
    );
  }
  Widget _buildOrderList(BuildContext context, OrderStatus status){
    final order = _repository.getOrdersByStatus(status);

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: order.length,
      itemBuilder: (context, index) => OderCard(
        order: order[index],
        onViewDetail: (){},
      ),
      );
  }
}