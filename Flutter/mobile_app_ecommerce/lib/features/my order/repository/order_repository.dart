import 'package:mobile_app_ecommerce/features/my%20order/model/order.dart';

class OrderRepository {
  List<Order> getOrder(){
    return [
      Order(
        OrderNumber: '123432', 
        itemCount: 2, 
        totalAmount: 2938.3, 
        status: OrderStatus.active, 
        imageUrl: 'assets/images/shoe.jpg', 
        orderDate: DateTime.now().subtract(const Duration(hours: 2)),
        ),
        Order(
        OrderNumber: '322422', 
        itemCount: 1, 
        totalAmount: 432.3, 
        status: OrderStatus.active, 
        imageUrl: 'assets/images/laptop.jpg', 
        orderDate: DateTime.now().subtract(const Duration(hours: 1)),
        ),
        Order(
        OrderNumber: '64353', 
        itemCount: 2, 
        totalAmount: 32.3, 
        status: OrderStatus.complete, 
        imageUrl: 'assets/images/shoe2.jpg', 
        orderDate: DateTime.now().subtract(const Duration(hours: 3)),
        ),
        Order(
        OrderNumber: '25242', 
        itemCount: 5, 
        totalAmount: 4932.3, 
        status: OrderStatus.cancelled, 
        imageUrl: 'assets/images/shoes2.jpg', 
        orderDate: DateTime.now().subtract(const Duration(hours: 7)),
        ),
    ];
  }

  List<Order> getOrdersByStatus(OrderStatus status){
    return getOrder().where((order) => order.status == status).toList();
  }
}