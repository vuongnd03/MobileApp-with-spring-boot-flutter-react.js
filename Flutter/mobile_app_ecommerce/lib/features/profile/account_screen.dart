import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app_ecommerce/controller/auth_controller.dart';
import 'package:mobile_app_ecommerce/features/edit%20profile/view/screen/edit_profile_screen.dart';
import 'package:mobile_app_ecommerce/features/help%20center/views/screen/help_center_screen.dart';
import 'package:mobile_app_ecommerce/features/my%20order/view/screen/my_oder_screen.dart';
import 'package:mobile_app_ecommerce/features/shippingadress/widget/shipping_address_screen.dart';
import 'package:mobile_app_ecommerce/features/view/widgets/setting_screen.dart';
import 'package:mobile_app_ecommerce/features/view/widgets/sign_screen.dart';
import 'package:mobile_app_ecommerce/utils/app_teststyle.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final screenSize =  MediaQuery.of(context).size;
    final isDark =Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tài khoản',
          style: AppTestStyle.withColor(
            AppTestStyle.h3, 
            isDark ? Colors.white : Colors.black,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () => Get.to(()=>SettingScreen()),
              icon: Icon(
                Icons.settings_outlined,
                color: isDark  ? Colors.white : Colors.black,
              ))
          ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileSection(context),
            const SizedBox(height: 16),
            _buildMenuSection(context),
          ],
        ),
      ),
    );
  }
  Widget _buildProfileSection(BuildContext context){
    final isDark =Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[850] : Colors.grey[100],
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24),),
      ),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/avatar.jpg'),
            ),
            const SizedBox(height: 16),
            Text(
              'Duc Vuong',
              style: AppTestStyle.withColor(
                AppTestStyle.h2,
                Theme.of(context).textTheme.bodyLarge!.color!,
                ),
            ),
            const SizedBox(height: 4),
             Text(
              'vuongnguyen251203@gmail.com',
              style: AppTestStyle.withColor(
                AppTestStyle.h2,
                isDark ? Colors.grey[400]! : Colors.grey[600]!,
                ),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () => Get.to(() => EditProfileScreen()),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12
                ),
                side: BorderSide(
                  color: isDark ? Colors.white70 : Colors.black12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                )
              ),
              child: Text(
                'Chỉnh sửa Profile',
                style: AppTestStyle.withColor(
                    AppTestStyle.buttonMedium,
                    Theme.of(context).textTheme.bodyLarge!.color!,
                ),
              ),
              ),
          ],
        ),
    );
  }
  Widget _buildMenuSection(BuildContext context){
    final isDark =Theme.of(context).brightness == Brightness.dark;
   final menuItems = [
      {'icon': Icons.shopping_bag_outlined, 'title': 'Giỏ Hàng'},
      {'icon': Icons.location_on_outlined, 'title': 'Địa chỉ giao hàng'},
      {'icon': Icons.help_outline, 'title': 'trung tâm trợ giúp'},
      {'icon': Icons.logout_outlined, 'title': 'Thoát'},
  ];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child:  Column(
        children: menuItems.map((items){
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: isDark ? Colors.black.withOpacity(0.2)
                  :Colors.grey.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            ),
            child: ListTile(
              leading: Icon(
                items['icon'] as IconData,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(
                items['title'] as String,
                style: AppTestStyle.withColor(
                  AppTestStyle.bodyMedium,
                  Theme.of(context).textTheme.bodyLarge!.color!,
                  ),
              ),
              trailing: Icon(
                Icons.chevron_right,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
              onTap: (){
                if(items['title'] == 'Thoát'){
                  _showLogoutDialog(context);
                }else if(items['title'] == 'Giỏ Hàng'){
                  Get.to(()=>MyOderScreen());
                }else if(items['title'] == 'Địa chỉ giao hàng'){
                  Get.to(()=>ShippingAddressScreen());
                }else if(items['title'] == 'Trung tâm trợ giúp'){
                  Get.to(()=>HelpCenterScreen());
                }
              },
            ),
          );
        }).toList(),
      ),
    );
  }
  void _showLogoutDialog(BuildContext context){
      final isDark =Theme.of(context).brightness == Brightness.dark;
      Get.dialog(
        AlertDialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 24,vertical: 20),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.logout_outlined,
                  color: Theme.of(context).primaryColor,
                  size: 32,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Bạn có chắc chắn muốn đăng xuất?',
                 style: AppTestStyle.withColor(
                    AppTestStyle.bodyMedium,
                    isDark ? Colors.grey[400]! : Colors.grey[600]!,
                  ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        side: BorderSide(
                          color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )
                      ),
                      child: Text(
                        'Thoát',
                        style: AppTestStyle.withColor(
                            AppTestStyle.buttonMedium,
                            Theme.of(context).textTheme.bodyLarge!.color!,
                        ),
                      ),
                      ), 
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                    child: ElevatedButton(
                      onPressed: (){
                        final AuthController authController = Get.find<AuthController>();
                        authController.logout();
                        Get.offAll(()=>SignScreen());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        elevation: 0,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )
                      ),
                      child: Text(
                        'Đăng xuất',
                        style: AppTestStyle.withColor(
                            AppTestStyle.buttonMedium,
                            Colors.white,
                        ),
                      ),
                      ), 
                    ),
                ],
              )
            ],
          ),
        )
      );
  }
}