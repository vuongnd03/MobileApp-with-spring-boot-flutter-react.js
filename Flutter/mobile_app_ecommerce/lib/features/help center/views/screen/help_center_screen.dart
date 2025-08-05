import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:mobile_app_ecommerce/features/help%20center/views/widget/contact_support_section.dart';
import 'package:mobile_app_ecommerce/features/help%20center/views/widget/help_categories_section.dart';
import 'package:mobile_app_ecommerce/features/help%20center/views/widget/popular_questions_section.dart';
import 'package:mobile_app_ecommerce/utils/app_teststyle.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(), 
          icon: Icon(
            Icons.arrow_back_ios,
            color: isDark ? Colors.white : Colors.black,
          ),
          ),
        title: Text(
          'Trung tâm trợ giúp',
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
            _buildSearchBar(context, isDark),
            const SizedBox(height: 24),
            const PopularQuestionsSection(),
            const SizedBox(height: 24),
            const HelpCategoriesSection(),
            const SizedBox(height: 24),
            const ContactSupportSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context,bool isDark){

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: isDark ? 
              Colors.black.withOpacity(0.2) 
              : Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Tìm kiếm câu hỏi hoặc chủ đề',
          hintStyle: AppTestStyle.withColor(
            AppTestStyle.bodyMedium,
            isDark ? Colors.grey[400]! : Colors.grey[600]!,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: isDark ? Colors.grey[400] : Colors.grey[600],
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Theme.of(context).cardColor,
        ),
      ),
    );

  }
}