
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:mobile_app_ecommerce/controller/theme_controller.dart';
import 'package:mobile_app_ecommerce/features/privacy%20policy/screen/privacy_policy_screen.dart';
import 'package:mobile_app_ecommerce/features/term%20of%20service/views/screen/terms_of_service_screen.dart';
import 'package:mobile_app_ecommerce/utils/app_teststyle.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
      final isDark =Theme.of(context).brightness == Brightness.dark; 
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: ()=>Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: isDark ? Colors.white : Colors.black,
        ),
        ),
        title: Text(
          'Settings',
          style: AppTestStyle.withColor(
            AppTestStyle.h3,
            isDark ? Colors.white : Colors.black,
            ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buldSection(
              context,
              'Appearance',
              [
                _buildThemeToggle(context),
              ],
            ),
            _buldSection(context,
            'Thong bao',
            [
              _buildSwitchTile(
                context,
                'Push Notification',
                'Receive push notification about orders and promotions',
                true,
              ),
              _buildSwitchTile(
                context,
                'Email Notification',
                'Receive Email update about your orders',
                false,
              ),
            ],
            ),
            _buldSection(context,
            'Privacy',
            [
              _buildNavigationTile(
                context,
                'Privacy police',
                'View our privacy policy',
                Icons.privacy_tip_outlined,
                onTap: () => Get.to(() => PrivacyPolicyScreen()), 
              ),
                  _buildNavigationTile(
                context,
                'Terms of Service',
                'Read our terms of service',
                Icons.description_outlined,
                onTap: () => Get.to(() => TermsOfServiceScreen()), 
              ),
            ],
            ),
            _buldSection(context,
            'About', 
            [
              _buildNavigationTile(
                context, 
                'App Version', 
                '1.0.0', 
                Icons.info_outline
                ),
            ],
            ),
          ],
        ),
      ),
    );
  }
      Widget _buldSection(BuildContext context,String title, List<Widget> children){
        final isDark =Theme.of(context).brightness == Brightness.dark; 
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(24, 24, 24, 8),
              child: Text(
                title,
                style: AppTestStyle.withColor(
                   AppTestStyle.h3,
                   isDark ? Colors.grey[400]! : Colors.grey[600]!,
                   ),
              ),
              ),
              ...children
          ],
        );
    }


    Widget _buildThemeToggle(BuildContext context){
      final isDark =Theme.of(context).brightness == Brightness.dark;

      return GetBuilder<ThemeController>(
        builder: (controller)=>Container(
          margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: isDark ? Colors.black.withOpacity(0.2) : Colors.grey.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              )
            ]
          ),
          child: ListTile(
            leading: Icon(
              controller.isDarkMode ? Icons.dark_mode : Icons.light_mode,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(
              'Dark Mode',
              style: AppTestStyle.withColor(
                   AppTestStyle.bodyMedium,
                   Theme.of(context).textTheme.bodyLarge!.color!,
                ),

            ),
            trailing: Switch.adaptive(
              value: controller.isDarkMode,
              onChanged: (value) => controller.toggleTheme(),
              activeColor: Theme.of(context).primaryColor,
              ),
          ),
        ),
        ); 
    }
    Widget _buildSwitchTile(
      BuildContext context,
      String title,
      String subtitle,
      bool initialValue,
    ){

      final isDark =Theme.of(context).brightness == Brightness.dark;
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        decoration: BoxDecoration(  
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.black.withOpacity(0.2) : Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            )
          ]
        ),
        child: ListTile(
          title: Text(
            title,
            style: AppTestStyle.withColor(
                   AppTestStyle.bodyMedium,
                   Theme.of(context).textTheme.bodyLarge!.color!,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: AppTestStyle.withColor(
                   AppTestStyle.bodySmall,
                    isDark ? Colors.grey[400]! : Colors.grey[600]!,
            ),
          ),
          trailing: Switch.adaptive(
            value: initialValue,
            onChanged: (value){},
            activeColor: Theme.of(context).primaryColor,
            ),
        ),

      );
    }
    Widget _buildNavigationTile(
      BuildContext context,
      String title,
      String subtitle,
      IconData icon,
      {
         VoidCallback? onTap,
        }
    ){
      final isDark =Theme.of(context).brightness == Brightness.dark;

      return GestureDetector(
        onTap: onTap,
        child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.black.withOpacity(0.2) : Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            )
          ]
        ),
        child: ListTile(
          leading: Icon(
            icon,
            color: Theme.of(context).primaryColor,
          ),
          title: Text(
            title,
            style: AppTestStyle.withColor(
              AppTestStyle.bodyMedium,
              Theme.of(context).textTheme.bodyLarge!.color!
              ),
          ),
          subtitle: Text(
            subtitle,
            style: AppTestStyle.withColor(
                   AppTestStyle.h3,
                   isDark ? Colors.grey[400]! : Colors.grey[600]!,
                   ),
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: isDark ? Colors.grey[400] : Colors.grey[600],
          ),
        ),
      ),
      );
    }
}