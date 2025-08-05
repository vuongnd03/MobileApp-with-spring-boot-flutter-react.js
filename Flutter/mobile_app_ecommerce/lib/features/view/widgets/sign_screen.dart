import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app_ecommerce/controller/auth_controller.dart';
import 'package:mobile_app_ecommerce/features/view/widgets/custom_field.dart';
import 'package:mobile_app_ecommerce/features/view/widgets/forgot_password-screen.dart';
import 'package:mobile_app_ecommerce/features/view/widgets/signup_screen.dart';
import 'package:mobile_app_ecommerce/utils/app_teststyle.dart';

class SignScreen extends StatelessWidget {
  SignScreen({super.key});
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40,),
              Text(
                'Welcome Back',
                style: AppTestStyle.withColor(
                  AppTestStyle.h1,
                  Theme.of(context).textTheme.bodyLarge!.color!,
                ),
                ),
                const SizedBox(height: 8,),
                Text(
                  'Đăng nhập để tiếp tục mua sắm',
                   style:AppTestStyle.withColor(
                      AppTestStyle.bodyLarge,
                      isDark? Colors.grey[400]! : Colors.grey[600]!,
                      ),
                      ),
                const SizedBox(height: 40,),
                //emial textfield
                CustomField(
                  label: 'email',
                  prefixcon: Icons.email_outlined,
                  keyboardtype: TextInputType.emailAddress,
                  controller: _emailcontroller,
                  validator: (value){
                    if(value == null || value.isEmpty){
                        return 'Bạn chưa nhập email';
                    }
                    if(! GetUtils.isEmail(value)){
                        return 'Hãy nhập email của bạn!';
                    }
                    return null;
                    
                  },
                ),
                  const SizedBox(height: 16,),
                  //password textfield
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
                const SizedBox(height: 8),
                //forgot password textbutton
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Get.to(()=> ForgotPasswordScreen(),),
                    child: Text(
                      'Quên mật khẩu?',
                      style: AppTestStyle.withColor(
                  AppTestStyle.buttonMedium,
                  Theme.of(context).primaryColor,
                  ),
                ),
              ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _handlerSignIn,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    )
                  ),
                  child: Text(
                    'Đăng Nhập',
                    style: AppTestStyle.withColor(
                      AppTestStyle.buttonMedium,
                      Colors.white,
                      ),
                    ),
                  ),
              ),
              const SizedBox(height: 24),
                      //sign up textbutton   
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Bạn chưa có tài khoản?",
                    style: AppTestStyle.withColor(
                      AppTestStyle.bodyMedium,
                      isDark ? Colors.grey[400]! : Colors.grey[600]!,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Get.to(()=>SignUpScreen(),),
                    child: Text(
                      'Đăng Ký',
                      style: AppTestStyle.withColor(
                        AppTestStyle.buttonMedium,
                        Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                ],
              )
            ],
          ),
        )
        ),
    );
  }
  //Sign in button onpressed
  Future<void> _handlerSignIn() async {
    final AuthController authController = Get.find<AuthController>();

    String email = _emailcontroller.text.trim();
    String password = _passwordcontroller.text.trim();

    if(email.isEmpty || password.isEmpty){
    Get.snackbar('Error', 'Vui lòng điền đầy đủ thông tin đăng nhập');
    return;
  }
  await authController.login(email, password);
  }
}