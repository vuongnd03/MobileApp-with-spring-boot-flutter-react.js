import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobile_app_ecommerce/utils/app_teststyle.dart';

class QuestionCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const QuestionCard({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: isDark 
                        ? Colors.black.withOpacity(0.2) 
                        : Colors.grey.withOpacity(0.1),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
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
                        Theme.of(context).textTheme.bodyLarge!.color!,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: isDark ?
                          Colors.grey[400] 
                          : Colors.grey[600],
                        size: 16,
                      ),
                      onTap: () => _showAnswerBottomSheet(context, title, isDark),
                  ),
                );
  }
  void _showAnswerBottomSheet(BuildContext context, String question, bool isDark) {
    
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16),
            ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    question,
                    style: AppTestStyle.withColor(
                        AppTestStyle.h3,
                        Theme.of(context).textTheme.bodyLarge!.color!,
                        ),
                  ),
                  ),
                  IconButton(
                    onPressed: () => Get.back(), 
                    icon: Icon(
                      Icons.close,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                    ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              _getAnswer(question),
               style: AppTestStyle.withColor(
                        AppTestStyle.bodyMedium,
                        isDark ? Colors.grey[400]! : Colors.grey[600]!,
                ),
            ),
            const SizedBox(height: 24),
            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.back(), 
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Đóng',
                  style: AppTestStyle.withColor(
                        AppTestStyle.buttonMedium,
                        Colors.white,
                        ),
                ),
                ),
            )
          ],
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }
  String _getAnswer(String question) {
    final answer ={
      'Theo dõi đơn hàng như thế nào?': 'Để theo dõi đơn hàng của bạn:\n\n'
    '1. Vào mục "Đơn hàng của tôi" trong tài khoản.\n'
    '2. Chọn đơn hàng bạn muốn theo dõi.\n'
    '3. Nhấn vào "Theo dõi đơn hàng".\n'
    '4. Bạn sẽ thấy các cập nhật theo thời gian thực về vị trí của gói hàng.\n\n'
    'Bạn cũng có thể sử dụng mã vận đơn được cung cấp trong email xác nhận đơn hàng để theo dõi trên trang web của đơn vị vận chuyển.',
    'Làm thế nào để trả lại sản phẩm?': 'Để trả lại sản phẩm:\n\n'
    '1. Vào mục "Đơn hàng của tôi" trong tài khoản.\n'
    '2. Chọn đơn hàng có sản phẩm bạn muốn trả lại.\n'
    '3. Nhấn vào "Trả hàng".\n'
    '4. Chọn lý do trả hàng.\n'
    '5. In nhãn trả hàng.\n'
    '6. Đóng gói sản phẩm cẩn thận.\n'
    '7. Giao gói hàng tại điểm vận chuyển gần nhất.\n\n'
    'Việc trả hàng phải được thực hiện trong vòng 30 ngày kể từ khi nhận hàng. Khi chúng tôi nhận được sản phẩm, tiền hoàn sẽ được xử lý trong vòng 5-7 ngày làm việc.',
    };
    return answer[question] ?? 'No answer available for this question.';
  }
} 