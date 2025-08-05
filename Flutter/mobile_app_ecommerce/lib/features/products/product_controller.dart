import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:mobile_app_ecommerce/features/Server/product_server.dart';
import 'package:mobile_app_ecommerce/features/products/product.dart';

class ProductController extends GetxController {
  var products = <Product>[].obs;
  var isLoading = false.obs;
  var wishlistProducts = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      final data = await ProductService.fetchProducts();
      products.assignAll(data);
    } catch (e) {
      print("Lỗi khi fetch sản phẩm: $e");
    } finally {
      isLoading(false);
    }
  }

  void fetchProductsByCategory(String category) async {
    try {
      isLoading(true);
      final url = Uri.parse(
        'http://192.168.1.6:8282/api/product/getproductBycatalog/$category',
      );
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        products.value =
            jsonData.map((item) {
              return Product(
                id: item['id'],
                name: item['namesp'],
                category: item['loaisp'] ?? '',
                price: (item['price'] as num).toDouble(),
                imageUrl: 'http://192.168.1.6:8282/images/${item['image_url']}',
                description: item['description'] ?? '',
                additionalImages: [],
              );
            }).toList();
      } else {
        Get.snackbar('Lỗi', 'Không thể lấy sản phẩm theo danh mục');
      }
    } catch (e) {
      Get.snackbar('Lỗi', 'Lỗi kết nối: $e');
    } finally {
      isLoading(false);
    }
  }

  final _storage = GetStorage();
  Future<void> fetchWishlist() async {
    final userId = _storage.read('userId');
    if (userId == null) {
      Get.snackbar('Lỗi', 'Bạn chưa đăng nhập!');
      return;
    }

    final url = Uri.parse(
      'http://192.168.1.6:8282/api/wishlist/get_wishlist/$userId',
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        wishlistProducts.value =
            jsonData.map((item) {
              return Product(
                id: item['product_id'],
                name: item['namesp'],
                category: 'Mobile', // Nếu backend không trả category
                price: (item['price'] as num).toDouble(),
                imageUrl: 'http://192.168.1.6:8282/images/${item['image_url']}',
                description: '', // Nếu cần có thể bổ sung
                additionalImages: [],
              );
            }).toList();
      } else {
        Get.snackbar('Lỗi', 'Không thể lấy danh sách wishlist');
      }
    } catch (e) {
      Get.snackbar('Lỗi', 'Lỗi kết nối: $e');
    }
  }

  //tìm kiếm sản phẩm
  void searchProducts(String keyword) async {
    if (keyword.isEmpty) {
      fetchProducts(); // nếu trống thì load tất cả sản phẩm
      return;
    }
    try {
      isLoading(true);
      final url = Uri.parse(
        'http://192.168.1.6:8282/api/product/SearchproductbyName/$keyword',
      );
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        products.value =
            jsonData.map((item) => Product.fromJson(item)).toList();
      } else {
        Get.snackbar('Lỗi', 'Không thể tìm kiếm sản phẩm');
      }
    } catch (e) {
      Get.snackbar('Lỗi', 'Lỗi kết nối: $e');
    } finally {
      isLoading(false);
    }
  }
  //xóa sản phẩm yêu thích

  Future<void> deleteWishlist(int productId) async {
    final userId = _storage.read('userId');
    if (userId == null) {
      Get.snackbar('Lỗi', 'Bạn cần đăng nhập trước khi xóa sản phẩm');
      return;
    }
    final url = Uri.parse(
      'http://192.168.1.6:8282/api/wishlist/delete/$userId/$productId',
    );
    try {
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        Get.snackbar('Thành công', 'Đã xóa sản phẩm khỏi sản phẩm yêu thích');
      } else {
        Get.snackbar('Lỗi', 'Xóa sản phẩm thất bại: ${response.body}');
      }
    } catch (e) {
      Get.snackbar('Lỗi', 'Không thể xóa sản phẩm: $e');
    }
  }
}
