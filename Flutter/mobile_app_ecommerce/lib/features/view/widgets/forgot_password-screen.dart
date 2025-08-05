import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app_ecommerce/controller/auth_controller.dart';
import 'package:mobile_app_ecommerce/features/view/widgets/custom_field.dart';
import 'package:mobile_app_ecommerce/utils/app_teststyle.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});
  final TextEditingController _emailcontroller = TextEditingController();
  final AuthController _authController = Get.put(AuthController());

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
              //back buton
              IconButton(
                onPressed: () => Get.back(),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Reset Password',
                style: AppTestStyle.withColor(
                  AppTestStyle.h1,
                  Theme.of(context).textTheme.bodyLarge!.color!,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Nhập email của bạn để lấy lại mật khẩu',
                style: AppTestStyle.withColor(
                  AppTestStyle.bodyLarge,
                  isDark ? Colors.grey[400]! : Colors.grey[600]!,
                ),
              ),
              const SizedBox(height: 40),
              //email textfield
              CustomField(
                label: 'email',
                prefixcon: Icons.email_outlined,
                keyboardtype: TextInputType.emailAddress,
                controller: _emailcontroller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bạn chưa nhập email';
                  }
                  if (!GetUtils.isEmail(value)) {
                    return 'Hãy nhập email của bạn!';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              //send reset link button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final email = _emailcontroller.text.trim();
                    if (email.isEmpty || !GetUtils.isEmail(email)) {
                      Get.snackbar('Lỗi', 'Vui lòng nhập email hợp lệ');
                      return;
                    }
                    _authController.getotp(email);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Gửi Mã Otp',
                    style: AppTestStyle.withColor(
                      AppTestStyle.buttonMedium,
                      Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
