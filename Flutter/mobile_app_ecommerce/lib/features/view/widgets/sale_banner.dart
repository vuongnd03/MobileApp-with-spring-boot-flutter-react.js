import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_app_ecommerce/utils/app_teststyle.dart';

class SaleBanner extends StatelessWidget {
  const SaleBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dành cho bạn',
                  style: AppTestStyle.withColor(
                    AppTestStyle.h3,
                    Colors.white,
                  ),
                ),
                  Text(
                  'Giảm giá đặc biệt',
                  style: AppTestStyle.withColor(
                    AppTestStyle.withWeight(
                      AppTestStyle.h2,
                      FontWeight.bold),
                    Colors.white,
                  ),
                ),
                Text(
                  'Lên tới 40%',
                  style: AppTestStyle.withColor(
                    AppTestStyle.h3,
                    Colors.white,
                  ),
                )
              ],
            ),
            ),
            ElevatedButton(
              onPressed: (){

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ) 
              ),
              child: Text(
                'Mua sắm ngay',
                style: AppTestStyle.buttonMedium,
                
              ),
              ),
        ],
      ),
    );
  }
}