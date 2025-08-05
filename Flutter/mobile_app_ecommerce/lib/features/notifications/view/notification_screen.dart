import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/utils.dart';
import 'package:mobile_app_ecommerce/features/notifications/models/notifications_type.dart';
import 'package:mobile_app_ecommerce/features/notifications/reponsitores/notification_repository.dart';
import 'package:mobile_app_ecommerce/features/notifications/ultis/notification_utils.dart';
import 'package:mobile_app_ecommerce/utils/app_teststyle.dart';

class NotificationScreen extends StatelessWidget {
  final NotificationRepository _repository =NotificationRepository();
  NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final notifications = _repository.getNotification();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(), 
          icon: Icon(
            Icons.arrow_back_ios,
            color: isDark ? Colors.white : Colors.black,
          )
          ),
        title: Text(
          'Thông báo',
          style: AppTestStyle.withColor(
            AppTestStyle.h3,
            isDark ? Colors.white : Colors.black,
            ),
        ),
        actions: [
          TextButton(
            onPressed: (){}, 
            child: Text(
              'Đánh dấu tất cả đã đọc',
              style: AppTestStyle.withColor(
                AppTestStyle.bodyMedium, 
                Theme.of(context).primaryColor,
                ),
            ),
            ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context, index) => _buildNotificationCard(
          context,
          notifications[index],
      ),
      ),
    );
  }
  Widget _buildNotificationCard(BuildContext context,NotificationItem notification){
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: notification.isRead?
        Theme.of(context).cardColor 
        : Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark? Colors.black.withOpacity(0.2):Colors.grey.withOpacity(0.1),

          ),
        ]
      ),
      child: ListTile(
        contentPadding:const EdgeInsets.all(16),
        leading: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: NotificationUtils.getIconBackgroundColor(context, notification.type),
            shape: BoxShape.circle,
          ),
          child: Icon(
            NotificationUtils.getNotificationIcon(notification.type),
            color: NotificationUtils.getIconColor(context, notification.type),
          ),
        ),
        title: Text(
          notification.title,
          style: AppTestStyle.withColor(
            AppTestStyle.bodyLarge, 
            Theme.of(context).textTheme.bodyLarge!.color!,
            ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              notification.message,
              style: AppTestStyle.withColor(
                AppTestStyle.bodySmall, 
                isDark ? Colors.grey[400]! : Colors.grey[600]!,
                
            ),
            )
          ],
        ),
      ),
    );
  }
}