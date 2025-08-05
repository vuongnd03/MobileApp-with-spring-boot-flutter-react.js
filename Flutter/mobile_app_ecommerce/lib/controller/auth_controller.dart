import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app_ecommerce/features/home/main_screen.dart';
import 'package:mobile_app_ecommerce/features/view/widgets/retrieve_password.dart';
import 'package:mobile_app_ecommerce/features/view/widgets/sign_screen.dart';

class AuthController extends GetxController {
  final _storage = GetStorage();

  final RxBool _isFirstTime = true.obs;
  final RxBool _isLoggedIn = false.obs;

  bool get isFirstTime => _isFirstTime.value;
  bool get isLoggedIn => _isLoggedIn.value;

  @override
  void onInit() {
    super.onInit();
    _loadInitialState();
  }

  void _loadInitialState() {
    _isFirstTime.value = _storage.read('isFirstTime') ?? true;
    _isLoggedIn.value = _storage.read('isLoggedIn') ?? false;
  }

  void setFirstTimeDone() {
    _isFirstTime.value = false;
    _storage.write('isFirstTime', false);
  }

  Future<void> register({
    required String name,
    required String numberphone,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    final url = Uri.parse('http://192.168.1.6:8282/api/user/registerUser');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'numberphone': numberphone,
          'email': email,
          'password': password,
          'confirm_password': confirmPassword,
        }),
      );

      if (response.statusCode == 200) {
        Get.snackbar('Thành công', 'Đăng ký thành công');
        Get.offAll(() => const MainScreen());
      } else {
        Get.snackbar('Lỗi', response.body);
      }
    } catch (e) {
      Get.snackbar('Lỗi', 'Không thể đăng ký: $e');
    }
  }

  //xử lý đăng nhập
  Future<void> login(String email, String password) async {
    final url = Uri.parse(
      'http://192.168.1.6:8282/api/user/login',
    ); // Android Emulator

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        // Đăng nhập thành công
        final data = jsonDecode(response.body);
        String token = data['token']; // Giả sử backend trả về token (Lấy token)
        int userId = data['id']; // Lấy userId từ backend

        _isLoggedIn.value = true;
        _storage.write('isLoggedIn', true);
        _storage.write('token', token); // Lưu token
        _storage.write('userId', userId); // Lưu userId

        Get.snackbar('Success', 'Login successful');
        Get.offAll(() => const MainScreen());
      } else {
        // Sai tài khoản mật khẩu
        Get.snackbar('Login Failed', response.body);
      }
    } catch (e) {
      Get.snackbar('Error', 'Could not login: $e');
    }
  }

  void logout() {
    _isLoggedIn.value = false;
    _storage.write('isLoggedIn', false);
    _storage.remove('token');
  }

  //hàm xử lý lấy otp
  Future<void> getotp(String email) async {
    final url = Uri.parse('http://192.168.1.6:8282/api/user/forgotpassword');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode == 200) {
        Get.snackbar('Thành công', 'Mã OTP đã được gửi tới email của bạn');
        Get.to(() => RetrievePassword());
      } else {
        Get.snackbar('Lỗi', response.body);
      }
    } catch (e) {
      Get.snackbar('Lỗi', 'Không thể gửi mã OTP: $e');
    }
  }

  //hàm xử lý tạo mk mới
  Future<void> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    final url = Uri.parse('http://192.168.1.6:8282/api/user/reset-password');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'otp': otp,
          'new_password': newPassword,
        }),
      );

      print('Status: ${response.statusCode}');
      print('Body: ${response.body}');

      if (response.statusCode == 200) {
        Get.snackbar('Thành công', response.body);
        Get.offAll(() => SignScreen());
      } else {
        Get.snackbar('Lỗi', 'Không đổi được mật khẩu: ${response.body}');
      }
    } catch (e) {
      Get.snackbar('Lỗi', 'Không thể đặt lại mật khẩu: $e');
    }
  }

  //hàm xử lý wishlist
  Future<void> addToWishlist(int productId) async {
    final userId = _storage.read('userId'); // Lấy userId từ storage
    if (userId == null) {
      Get.snackbar(
        'Error',
        'Bạn cần đăng nhập trước khi thêm sản phẩm yêu thích',
      );
      return;
    }

    final url = Uri.parse('http://192.168.1.6:8282/api/wishlist/add_wishlist');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'user_id': userId, 'product_id': productId}),
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Đã thêm vào danh sách yêu thích');
      } else {
        Get.snackbar('Error', 'Thêm sản phẩm thất bại: ${response.body}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Không thể thêm sản phẩm: $e');
    }
  }
}
