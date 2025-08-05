import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/utils.dart';
import 'package:mobile_app_ecommerce/controller/auth_controller.dart';
import 'package:mobile_app_ecommerce/features/view/widgets/custom_field.dart';
import 'package:mobile_app_ecommerce/features/view/widgets/sign_screen.dart';
import 'package:mobile_app_ecommerce/utils/app_teststyle.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _numberphone = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _confirmPasswordcontroller = TextEditingController();


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
                  'Tạo tài khoản',
                  style: AppTestStyle.withColor(
                    AppTestStyle.h1,
                    Theme.of(context).textTheme.bodyLarge!.color!,
                    ),
                ),
                 const SizedBox(height: 8),
                 Text(
                  'Đăng ký để bắt đầu mua sắm',
                  style: AppTestStyle.withColor(
                    AppTestStyle.bodyLarge,
                    isDark ? Colors.grey[400]! : Colors.grey[600]!,
                    ),
                ),
                const SizedBox(height: 40),
                //full name TextFiel
                  CustomField(
                  label: 'Họ và Tên',
                  prefixcon: Icons.person_outline,
                  keyboardtype: TextInputType.name,
                  controller: _namecontroller,
                  validator: (value){
                    if(value == null || value.isEmpty){
                        return 'Bạn chưa nhập họ và tên';
                    }
                    return null;
                  },
                ),

                //number phone textfiel
                const SizedBox(height: 16),
                 CustomField(
                  label: 'Số điện thoại',
                  prefixcon: Icons.phone_android_outlined,
                  keyboardtype: TextInputType.number,
                  controller: _numberphone,
                  validator: (value){
                    if(value == null || value.isEmpty){
                        return 'Bạn chưa nhập số điện thoại';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 16),
                //email textfiel
                CustomField(
                  label: 'Email',
                  prefixcon: Icons.email_outlined,
                  keyboardtype: TextInputType.emailAddress,
                  controller: _emailcontroller,
                  validator: (value){
                    if(value == null || value.isEmpty){
                        return 'Bạn chưa nhập email';
                    }if(GetUtils.isEmail(value)){
                      return 'Hãy nhập email của bạn!';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                //password textfiel
              CustomField(
                  label: 'Mật khẩu',
                  prefixcon: Icons.lock_outline,
                  keyboardtype: TextInputType.visiblePassword,
                  isPassword: true,
                  controller: _passwordcontroller,
                  validator: (value){
                    if(value == null || value.isEmpty){
                        return 'Bạn chưa nhập mật khẩu';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                //confirm password
                CustomField(
                  label: 'Nhập lại mật khẩu',
                  prefixcon: Icons.lock_outline,
                  keyboardtype: TextInputType.visiblePassword,
                  isPassword: true,
                  controller: _confirmPasswordcontroller,
                  validator: (value){
                    if(value == null || value.isEmpty){
                        return 'Bạn chưa nhập lại mật khẩu';
                    }if(value != _passwordcontroller.text){
                      return 'Mật khẩu không khớp';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24,),
                //signup button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _handlesignup,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Đăng Ký',
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
                      'Bạn đã có tài khoản?',
                      style: AppTestStyle.withColor(
                        AppTestStyle.bodyMedium,
                        isDark ? Colors.grey[400]! : Colors.grey[600]!,
                        ),
                    ),
                    TextButton(
                      onPressed: () => Get.off(() => SignScreen(),),
                      child: Text(
                        'Đăng Nhập',
                        style:  AppTestStyle.withColor(
                        AppTestStyle.buttonMedium,
                        Theme.of(context).primaryColor,
                        ),
                      ),
                      )
                  ],
                )
            ],
          ),
        ),
        
        ),
    );
  }
  Future<void> _handlesignup() async {
    final AuthController authController = Get.find<AuthController>();
    String name = _namecontroller.text.trim();
    String phone = _numberphone.text.trim();
    String email = _emailcontroller.text.trim();
    String password = _passwordcontroller.text.trim();
    String confirmPassword = _confirmPasswordcontroller.text.trim();

    if(name.isEmpty || phone.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty){
      Get.snackbar('Error', 'Vui lòng điền đầy đủ thông tin đăng ký');
      return;
    }
    
    if(password != confirmPassword){
      Get.snackbar('Error', 'Mật khẩu không khớp');
      return;
    }
    await authController.register(name: name, numberphone: phone, email: email, password: password, confirmPassword: confirmPassword);
    Get.off(() => SignScreen());
  }
}