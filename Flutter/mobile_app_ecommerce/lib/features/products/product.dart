import 'package:mobile_app_ecommerce/features/products/product_image.dart';

class Product {
  final int id;
  final String name;
  final String category;
  final double price;
  final double? oldprice;
  final String imageUrl;
  bool isFavorite;
  final String description;
  final List<ProductImage> additionalImages;

  Product({
    required this.id,
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.name,
    required this.price,
    this.oldprice,
    this.isFavorite = false,
    this.additionalImages = const [],
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    var additionalImagesFromJson =
        json['productImageDto'] as List<dynamic>? ?? [];
    return Product(
      id: json['id'],
      name: json['namesp'],
      category: 'Mobile', // hoặc lấy từ json nếu có
      price: (json['price'] as num).toDouble(),
      description: json['desception'],
      imageUrl:
          'http://192.168.1.6:8282/images/${json['image_url']}', // bạn có thể điều chỉnh lại URL nếu backend lưu tên file
      oldprice: null, // nếu backend có giá cũ thì lấy ra
      additionalImages:
          additionalImagesFromJson
              .map((imageJson) => ProductImage.fromJson(imageJson))
              .toList(),
    );
  }
}
