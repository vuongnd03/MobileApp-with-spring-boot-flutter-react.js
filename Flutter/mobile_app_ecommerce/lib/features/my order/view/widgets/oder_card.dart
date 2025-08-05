import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:mobile_app_ecommerce/features/my%20order/model/order.dart';
import 'package:mobile_app_ecommerce/utils/app_teststyle.dart';

class OderCard extends StatelessWidget {
  final Order order;
  final VoidCallback onViewDetail;

  const OderCard({
    super.key, 
    required this.order, 
    required this.onViewDetail,
    });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black.withOpacity(0.2)
            : Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2)
          )
        ]
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(image: AssetImage(order.imageUrl),
                    fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Đặt hàng # ${order.OrderNumber}',
                        style: AppTestStyle.withColor(
                          AppTestStyle.h3, 
                          Theme.of(context).textTheme.bodyLarge!.color!,
                          ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${order.itemCount} items . \$${order.totalAmount.toStringAsFixed(2)}',
                        style: AppTestStyle.withColor(
                          AppTestStyle.bodyMedium, 
                          isDark ? Colors.grey[400]! : Colors.grey[600]!,
                          ),
                      ),
                      const SizedBox(height: 8),

                      _buildStatusChip(
                        context,
                        order.statusString,
                      ),
                    ],
                  ),
                  ),
              ],
            ),
            ),
            Divider(height: 1,color: Colors.grey.shade200),
            InkWell(
              onTap: onViewDetail,
              child: Padding(padding: EdgeInsets.symmetric(vertical: 12),
              child: Text(
                'Xem chi tiết',
                style: AppTestStyle.withColor(
                  AppTestStyle.buttonMedium, 
                  Theme.of(context).primaryColor,
          ),
              ),
              ),
            )
        ],
      ),
    );
  }
  Widget _buildStatusChip(BuildContext context, String type){
    Color getStatusColor(){
      switch(type){
        case 'Đang xử lý':
        return Colors.blue;
        case 'Đã hoàn thành':
        return Colors.green;
        case 'Đã hủy':
        return Colors.red;
        default:
        return Colors.grey;
      }
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
      decoration: BoxDecoration(
        color: getStatusColor().withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        type.capitalize!,
        style: AppTestStyle.withColor(
          AppTestStyle.bodySmall, 
          getStatusColor(),
          ),
      ),
    );
  }
}