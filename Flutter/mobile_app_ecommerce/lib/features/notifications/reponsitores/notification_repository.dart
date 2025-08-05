import 'package:mobile_app_ecommerce/features/notifications/models/notifications_type.dart';

class NotificationRepository {
  List<NotificationItem> getNotification(){
    return[
      NotificationItem(
          title: 'Đơn hàng đã được xác nhận', 
          message: 'Đơn hàng #123456 của bạn đã được xác nhận và đang được xử lý', 
          time: '2 phút trước', 
          type: NotificationsType.order,
          isRead: true,
        ),
        NotificationItem(
          title: 'Ưu đãi đặc biệt', 
          message: 'Giảm giá 20% cho tất cả các mẫu giày vào cuối tuần này!', 
          time: '1 giờ trước', 
          type: NotificationsType.promo,
          isRead: true,
        ),
        NotificationItem(
          title: 'Đơn hàng đang được giao', 
          message: 'Đơn hàng #123433 của bạn đang được giao', 
          time: '3 giờ trước', 
          type: NotificationsType.delivery,
          isRead: true,
        ),
        NotificationItem(
          title: 'Thanh toán thành công', 
          message: 'Thanh toán cho đơn hàng #43232 đã thành công', 
          time: '2 phút trước', 
          type: NotificationsType.payment,
          isRead: true,
        ),

    ];
  }
}