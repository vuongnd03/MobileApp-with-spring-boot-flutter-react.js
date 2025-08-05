import 'package:flutter/material.dart';
import 'package:mobile_app_ecommerce/features/help%20center/views/widget/question_card.dart';

import 'package:mobile_app_ecommerce/utils/app_teststyle.dart';

class PopularQuestionsSection extends StatelessWidget {
  const PopularQuestionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Câu hỏi phổ biến',
            style: AppTestStyle.withColor(
                  AppTestStyle.h3,
                  Theme.of(context).textTheme.bodyLarge!.color!,
          ),
          ),
          const SizedBox(height: 16),
          const QuestionCard(
            title: 'Làm thế nào để theo dõi đơn hàng?',
            icon: Icons.local_shipping_outlined,
          ),
          const SizedBox(height: 12),
          const QuestionCard(
            title: 'Làm thế nào để trả lại sản phẩm?',
            icon: Icons.local_shipping_outlined,
          ),
        ],
      ),
    );
  }
}