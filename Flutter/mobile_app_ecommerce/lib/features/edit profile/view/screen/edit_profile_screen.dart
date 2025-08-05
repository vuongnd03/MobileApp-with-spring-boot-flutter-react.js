import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:mobile_app_ecommerce/features/edit%20profile/view/widget/profile_form.dart';
import 'package:mobile_app_ecommerce/features/edit%20profile/view/widget/profile_image.dart';
import 'package:mobile_app_ecommerce/utils/app_teststyle.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
        title: Text(
          'Chỉnh sửa hồ sơ',
          style: AppTestStyle.withColor(
            AppTestStyle.h3, 
            isDark ? Colors.white : Colors.black,
          ),
      ),
    ),
    body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 24),
          ProfileImage(),
          SizedBox(height: 32),
          ProfileForm(),
        ],
      ),
    ),
    );
  }
}