
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:mobile_app_ecommerce/utils/app_teststyle.dart';

class FilterBottomSheet {
  static void show(BuildContext context){
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12)
        )
      ),
      builder: (context) => StatefulBuilder(
        builder: (context,setState) => Container(
          padding:const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Lọc Sản Phẩm',
                     style: AppTestStyle.withColor(
                      AppTestStyle.h3,
                      Theme.of(context).textTheme.bodyLarge!.color!,
                      ),
                  ),

                  IconButton(onPressed: (){},
                  icon: Icon(
                    Icons.close,
                    color: isDark ? Colors.white : Colors.black,

                  ))
                ],
              ),
              const SizedBox(height: 24),
              Text(
                'Phạm Vi Giá',
              style: AppTestStyle.withColor(
                      AppTestStyle.bodyLarge,
                      Theme.of(context).textTheme.bodyLarge!.color!,
                ),

              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Thấp nhất',
                      prefixText: '\$',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
                        )
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  ),
                   const SizedBox(width: 16),
                    Expanded(
                    child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Cao nhất',
                      prefixText: '\$',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: isDark ? Colors.grey[700]! : Colors.grey[300]!,
                        )
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                'Danh Mục',
              style: AppTestStyle.withColor(
                      AppTestStyle.bodyLarge,
                      Theme.of(context).textTheme.bodyLarge!.color!,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  'All',
                  'Laptop',
                  'Điện Thoại',
                  'Giày Dép',
                ]
                .map((category) => FilterChip(
                  label: Text(category),
                  selected: category == 'All',
                  onSelected: (selected){},
                  backgroundColor: Theme.of(context).cardColor,
                  selectedColor:
                      Theme.of(context).primaryColor.withOpacity(0.2),
                      labelStyle: AppTestStyle.withColor(
                        AppTestStyle.bodyMedium,
                        category == 'All'
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).textTheme.bodyLarge!.color!,
                        ),

                ))
                .toList(),
              ),
              const SizedBox(height: 24,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)
                    )
                  ),
                  child: Text(
                    'Ap dụng bộ lọc',
                    style: AppTestStyle.withColor(
                      AppTestStyle.buttonMedium,
                      Colors.white,
                ),
                  )
                  ),
              )

            ],
          ),
        ),
        ),
    );
  }
}