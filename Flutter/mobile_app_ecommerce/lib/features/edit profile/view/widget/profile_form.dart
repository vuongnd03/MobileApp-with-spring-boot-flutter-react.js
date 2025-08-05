import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app_ecommerce/features/view/widgets/custom_field.dart';
import 'package:mobile_app_ecommerce/utils/app_teststyle.dart';

class ProfileForm extends StatelessWidget {
  const ProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: isDark ? 
                    Colors.black.withOpacity(0.2)
                    : Colors.white.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),

                ),
              ]
            ),
            child: const CustomField(
              label: 'Full Name', 
              prefixcon: Icons.person_outlined,
              initialValue: 'Alex Johnson',
              ),
          ),
            const SizedBox(
              height: 16,
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: isDark ?
                      Colors.black.withOpacity(0.2)
                      : Colors.grey.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                  )
                ]
              ),
              child:const CustomField(
                label: 'Email', 
                prefixcon: Icons.email_outlined,
                initialValue: 'AlexJondson@gmail.com',
                keyboardtype: TextInputType.emailAddress,
                ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: isDark ? 
                      Colors.black.withOpacity(0.2)
                      : Colors.white.withOpacity(0.1),
                    blurRadius: 8,
                    offset: Offset(0, 2),

                  ),
                ]
              ),
              child: const CustomField(
                label: 'Phone Number', 
                prefixcon: Icons.phone_outlined,
                initialValue: '1239393939',
                keyboardtype: TextInputType.phone,
                ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (){
                  Get.back();
                }, 
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    
                  ),
                ),
                child: Text(
                  'Luu thay doi',
                  style: AppTestStyle.withColor(
                    AppTestStyle.buttonMedium, 
                   Colors.white,
                    ),
                ),
                ),
            ),
        ],
      ),
    );
  }
}