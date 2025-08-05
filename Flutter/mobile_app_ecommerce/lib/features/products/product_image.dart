class ProductImage {
  final String imageUrl;

  ProductImage({required this.imageUrl});

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      imageUrl: 'http://192.168.1.6:8282/images/${json['image_url']}',
    );
  }
}
