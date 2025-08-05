import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:mobile_app_ecommerce/features/privacy%20policy/widget/info_section.dart';
import 'package:mobile_app_ecommerce/utils/app_teststyle.dart';

class PrivacyPolicyScreen extends StatelessWidget {

  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: ()=> Get.back(), 
          icon: Icon(
            Icons.arrow_back_ios,
            color: isDark ? Colors.white : Colors.black,
          ),
          ),
        title: Text(
          'Privacy Policy',
          style: AppTestStyle.withColor(
            AppTestStyle.h3, 
            isDark ? Colors.white : Colors.black,
            ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(screenSize.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                InfoSection(
                  title: 'Thông tin chúng tôi thu thập',
                  content: 'Chúng tôi thu thập thông tin về bạn khi bạn sử dụng ứng dụng của chúng tôi, bao gồm tên, địa chỉ email và dữ liệu sử dụng.',
                ),
                InfoSection(
                  title: 'Cách chúng tôi sử dụng thông tin của bạn',
                  content: 'Chúng tôi sử dụng thông tin của bạn để cung cấp và cải thiện dịch vụ, liên hệ với bạn và cá nhân hóa trải nghiệm của bạn.',
                ),
                InfoSection(
                  title: 'Chia sẻ thông tin',
                  content: 'Chúng tôi có thể chia sẻ thông tin của bạn trong các trường hợp cần thiết để vận hành dịch vụ hoặc tuân thủ pháp luật.',
                ),
                InfoSection(
                  title: 'Bảo mật dữ liệu',
                  content: 'Chúng tôi áp dụng các biện pháp bảo mật để bảo vệ dữ liệu của bạn khỏi truy cập, tiết lộ hoặc thay đổi trái phép.',
                ),
                InfoSection(
                  title: 'Quyền của bạn',
                  content: 'Bạn có quyền truy cập, chỉnh sửa hoặc xóa thông tin cá nhân của mình, cũng như yêu cầu chúng tôi ngừng sử dụng thông tin đó.',
                ),
                InfoSection(
                  title: 'Chính sách Cookie',
                  content: 'Chúng tôi sử dụng cookie để cải thiện trải nghiệm của bạn và phân tích cách bạn sử dụng ứng dụng.',
                ),
                const SizedBox(height: 24),
                Text(
                  'Cập nhật lần cuối: Tháng 3, 2025',
                  style: AppTestStyle.withColor(
                    AppTestStyle.bodySmall, 
                    isDark ? Colors.grey[400]! : Colors.grey[600]!,
                  ),
                ),
              ],
          ),
        ), 
      ),
    );
  }
}