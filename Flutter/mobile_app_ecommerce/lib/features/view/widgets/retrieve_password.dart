import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/utils.dart';
import 'package:mobile_app_ecommerce/controller/auth_controller.dart';
import 'package:mobile_app_ecommerce/features/view/widgets/custom_field.dart';
import 'package:mobile_app_ecommerce/features/view/widgets/sign_screen.dart';
import 'package:mobile_app_ecommerce/utils/app_teststyle.dart';

class RetrievePassword extends StatelessWidget {
  RetrievePassword({super.key});
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _otp = TextEditingController();
  final TextEditingController _newpassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // back button
              IconButton(
                onPressed: () => Get.back(),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),

              const SizedBox(height: 20),
              Text(
                'Tạo mật khẩu mới',
                style: AppTestStyle.withColor(
                  AppTestStyle.h1,
                  Theme.of(context).textTheme.bodyLarge!.color!,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Tạo mật khẩu mới để bắt đầu mua sắm',
                style: AppTestStyle.withColor(
                  AppTestStyle.bodyLarge,
                  isDark ? Colors.grey[400]! : Colors.grey[600]!,
                ),
              ),
              const SizedBox(height: 40),
              //full name TextFiel
              CustomField(
                label: 'email',
                prefixcon: Icons.person_outline,
                keyboardtype: TextInputType.name,
                controller: _emailcontroller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bạn chưa nhập họ và tên';
                  }
                  return null;
                },
              ),

              //number phone textfiel
              const SizedBox(height: 16),
              CustomField(
                label: 'Mã OTP',
                prefixcon: Icons.phone_android_outlined,
                keyboardtype: TextInputType.number,
                controller: _otp,
                maxLength: 6, // giới hạn số lượng ký tự
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bạn chưa nhập mã OTP';
                  }
                  if (!RegExp(r'^\d{6}$').hasMatch(value)) {
                    return 'OTP phải gồm đúng 6 chữ số';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),
              //email textfiel
              CustomField(
                label: 'Mật khẩu mới',
                prefixcon: Icons.email_outlined,
                keyboardtype: TextInputType.emailAddress,
                controller: _newpassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bạn chưa nhập mật khẩu mới';
                  }
                  if (value.length < 6) {
                    return 'Mật khẩu phải có ít nhất 6 ký tự';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              //password textfiel
              const SizedBox(height: 24),
              //signup button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _handleretrivepassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Lưu mật khẩu mới',
                    style: AppTestStyle.withColor(
                      AppTestStyle.buttonMedium,
                      Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              //sign in textbutotn
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Đănh nhập bằng tài khoản khác?',
                    style: AppTestStyle.withColor(
                      AppTestStyle.bodyMedium,
                      isDark ? Colors.grey[400]! : Colors.grey[600]!,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Get.off(() => SignScreen()),
                    child: Text(
                      'Đăng Nhập',
                      style: AppTestStyle.withColor(
                        AppTestStyle.buttonMedium,
                        Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleretrivepassword() async {
    final AuthController authController = Get.find<AuthController>();
    String email = _emailcontroller.text.trim();
    String otp = _otp.text.trim();
    String newPassword = _newpassword.text.trim();

    if (email.isEmpty || otp.isEmpty || newPassword.isEmpty) {
      Get.snackbar('Error', 'Vui lòng điền đầy đủ thông tin đăng ký');
      return;
    }

    await authController.resetPassword(
      email: email,
      otp: otp,
      newPassword: newPassword,
    );
    Get.off(() => SignScreen());
  }
}
