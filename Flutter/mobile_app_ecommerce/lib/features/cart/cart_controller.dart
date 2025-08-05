import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app_ecommerce/features/cart/cart_item.dart';

class CartController extends GetxController {
  final _storage = GetStorage();

  final String baseUrl = 'http://192.168.1.6:8282/api/cart';
  RxList<CartItem> cartItems = <CartItem>[].obs;

  Future<void> addToCart(int userId, int productId, int quantity) async {
    final response = await http.post(
      Uri.parse('$baseUrl/addcart'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'userId': userId,
        'productId': productId,
        'quantity': quantity,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Thêm sản phẩm vào giỏ hàng thất bại');
    }
  }

  Future<void> loadCart(int userId) async {
    try {
      final items = await getCart(userId);
      cartItems.assignAll(items);
    } catch (e) {
      print('Lỗi khi load giỏ hàng: $e');
    }
  }

  Future<List<CartItem>> getCart(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/getcart/$userId'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((item) => CartItem.fromJson(item)).toList();
    } else {
      throw Exception('Lấy giỏ hàng thất bại');
    }
  }

  //xoá sản phẩm khỏi giỏ hàng
  Future<void> deleteCartItem(int productId) async {
    final userId = _storage.read('userId');
    if (userId == null) {
      Get.snackbar('Lỗi', 'Bạn cần đăng nhập trước khi xóa sản phẩm');
      return;
    }
    final url = Uri.parse(
      'http://192.168.1.6:8282/api/cart/delete/$userId/$productId',
    );
    try {
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        Get.snackbar('Thành công', 'Đã xóa sản phẩm khỏi giỏ hàng');
        await loadCart(userId);
      } else {
        Get.snackbar('Lỗi', 'Xóa sản phẩm thất bại: ${response.body}');
      }
    } catch (e) {
      Get.snackbar('Lỗi', 'Không thể xóa sản phẩm: $e');
    }
  }
}
