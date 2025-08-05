import 'package:flutter/material.dart';
import 'package:mobile_app_ecommerce/utils/app_teststyle.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  const CategoryCard({
    super.key, 
    required this.title, 
    required this.icon,
    });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black.withOpacity(0.2) : Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: (){},
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: AppTestStyle.withColor(
                AppTestStyle.bodyMedium,
                Theme.of(context).textTheme.bodyLarge!.color!,
                 ),
            ),
          ],
        ),
      ),
    );
  }
}