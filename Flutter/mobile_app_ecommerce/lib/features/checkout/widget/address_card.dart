import 'package:flutter/material.dart';
import 'package:mobile_app_ecommerce/utils/app_teststyle.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black.withOpacity(0.2)
            : Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),

          )
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'Home',
                      style: AppTestStyle.withColor(
                          AppTestStyle.bodyLarge, 
                          Theme.of(context).textTheme.bodyLarge!.color!,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '123 Main street',
                       style: AppTestStyle.withColor(
                          AppTestStyle.bodySmall, 
                          isDark ? Colors.grey[400]! : Colors.grey[600]!,
                          ),
                    )
                  ],
                ) 
                ),
                IconButton(
                  onPressed: (){}, 
                  icon: Icon(
                    Icons.edit_outlined,
                    color: Theme.of(context).primaryColor,
                  ),
                  ),
            ],
          )
        ],
      ),
    );
  }
}