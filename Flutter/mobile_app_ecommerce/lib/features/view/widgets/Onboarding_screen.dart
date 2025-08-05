import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app_ecommerce/controller/auth_controller.dart';
import 'package:mobile_app_ecommerce/features/view/widgets/sign_screen.dart';
import 'package:mobile_app_ecommerce/utils/app_teststyle.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  final PageController _pageController = PageController();
  int _currentpage = 0;
  final List<OnboardingItem> _items = [
    OnboardingItem(
      description: 'Khám phá những xu hướng thời trang mới nhất và tìm phong cách riêng của bạn',
      title: 'Khám phá xu hướng mới',
      image: 'assets/images/intro.png',
    ),
    OnboardingItem(
      description: 'Mua sắm các sản phẩm chất lượng cao từ những thương hiệu hàng đầu trên toàn thế giới',
      title: 'Sản phẩm chất lượng',
      image: 'assets/images/intro1.png',
    ),
    OnboardingItem(
      description: 'Trải nghiệm mua sắm đơn giản và an toàn ngay trong tầm tay của bạn',
      title: 'Mua sắm dễ dàng',
      image: 'assets/images/intro2.png',
    ),
  ];

  //handle get started button pressed
  void _handleGetStarted(){
      final AuthController authController = Get.find<AuthController>();
      authController.setFirstTimeDone();
      Get.off(() => SignScreen());
  }
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _items.length,
            onPageChanged: (index){
              setState(() {
                _currentpage = index;
              });
            },
            itemBuilder: (context,index){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    _items[index].image,
                    height: MediaQuery.of(context).size.height * 0.4,
                  ),
                  const SizedBox(height: 40),
                  Text(
                    _items[index].title,
                    textAlign: TextAlign.center,
                    style: AppTestStyle.withColor(
                      AppTestStyle.h1,
                      Theme.of(context).textTheme.bodyLarge!.color!,
                    ),
                  ),
                  const SizedBox(height: 16,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      _items[index].description,
                      textAlign: TextAlign.center,
                      style: AppTestStyle.withColor(
                      AppTestStyle.bodyLarge,
                      isDark? Colors.grey[400]! : Colors.grey[600]!,
                    ),
                    ),
                    ),
                ],
              );
          },
          ),
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _items.length,
                (index)=>AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: _currentpage == index ? 24 : 8,
                  decoration: BoxDecoration(
                    color: _currentpage == index 
                        ? Theme.of(context).primaryColor
                        : (isDark? Colors.grey[700] : Colors.grey[300]),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  )),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => _handleGetStarted(),
               child: Text("Quay lại",
                  style: AppTestStyle.withColor(
                    AppTestStyle.buttonMedium,
                    isDark? Colors.grey[400]! : Colors.grey[600]!,
               ),
               ),
               ),
               ElevatedButton(onPressed: (){
                if(_currentpage < _items.length - 1){
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,);
                }else{
                  _handleGetStarted();
                }
               },
               style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
               ),
                child: Text(
                  _currentpage < _items.length - 1 ? 'Tiếp theo' : "Bắt đầu",
                  style: AppTestStyle.withColor(AppTestStyle.buttonMedium,Colors.white),
                ),
               ),
            ],
          ),)
        ],
      ),
    );
  }
}

class OnboardingItem{
  final String image;
  final String title;
  final String description;

  OnboardingItem({
    required this.image,
    required this.title,
    required this.description,
  });

}