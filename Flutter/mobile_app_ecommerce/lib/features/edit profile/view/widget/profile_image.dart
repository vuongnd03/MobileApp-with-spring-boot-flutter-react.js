import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app_ecommerce/utils/app_teststyle.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
     final isDark = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: Stack(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).primaryColor,
                width: 2,
              ),
              image: DecorationImage(
                image: AssetImage('assets/images/avatar.jpg'),
                fit: BoxFit.cover,
                ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => _showImagePickerBottomSheet(context, isDark),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor,
                  boxShadow: [
                    BoxShadow(
                      color: isDark ? Colors.black.withOpacity(0.2) : Colors.grey.withOpacity(0.1),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ]
                ),
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 20,

                ),
              ),
            ),
            ),
        ],
      ),
    );
  }

  void _showImagePickerBottomSheet(BuildContext context,bool isDark) {
    

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius:const BorderRadius.vertical(
            top: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, -5),
              )
            ]
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[700] : Colors.grey[300],
                borderRadius: BorderRadius.circular(2), 
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Change Profile Picture',
              style: AppTestStyle.withColor(
                AppTestStyle.h3, 
                Theme.of(context).textTheme.bodyLarge!.color!,
              ),
            ),
            const SizedBox(height: 24),
            _buildOptionTile(
              context,
              'Take Photo',
              Icons.camera_alt_outlined,
              () => Get.back(),
              isDark,
            ),
            const SizedBox(height: 16),
            _buildOptionTile(
              context,
              'Choose from Gallery',
              Icons.photo_library_outlined,
              () => Get.back(),
              isDark,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
  Widget _buildOptionTile(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
    bool isDark,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: isDark ? 
                Colors.black.withOpacity(0.2) 
                : Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ]
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Theme.of(context).primaryColor,
              size: 24,
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: AppTestStyle.withColor(
                AppTestStyle.bodyMedium, 
                Theme.of(context).textTheme.bodyLarge!.color!,
              ),
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                color: isDark ? Colors.grey[400] : Colors.grey[600],

              ),

          ],
        ),
      ),
    );
  }
}