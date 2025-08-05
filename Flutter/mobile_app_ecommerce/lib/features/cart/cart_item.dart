// lib/features/cart/model/cart_item.dart

class CartItem {
  final int productId;
  final String name;
  final double price;
  final int quantity;
  final String imageUrl;
  final double totalPrice;

  CartItem({
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageUrl, 
    required this.totalPrice,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json['productId'],
      name: json['namesp'],
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'],
      imageUrl: json['image_url'],
      totalPrice: (json['totalprice'] as num).toDouble(),
    );
  }
}
