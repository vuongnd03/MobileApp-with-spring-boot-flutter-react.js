
import 'package:flutter/material.dart';
import 'package:mobile_app_ecommerce/utils/app_teststyle.dart';

class PaymentMethodCard extends StatelessWidget {
  const PaymentMethodCard({super.key});

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
                  : Colors.white.withOpacity(0.1),
                blurRadius: 8,
                offset: Offset(0, 2),

          )
        ]
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset(
                  'assets/images/mastercard.png',
                  height: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Visa ending in 424',
                        style: AppTestStyle.withColor(
                          AppTestStyle.bodyLarge, 
                          Theme.of(context).textTheme.bodyLarge!.color!,
                          ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Expires 12/42',
                        style: AppTestStyle.withColor(
                          AppTestStyle.bodySmall, 
                          isDark ? Colors.grey[400]! : Colors.grey[600]!,
                          ),
                    ),
                  ],
                ),
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