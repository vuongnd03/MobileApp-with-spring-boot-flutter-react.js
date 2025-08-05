import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';
import 'package:mobile_app_ecommerce/controller/navigation_controller.dart';

class CustomBottomNavbar extends StatelessWidget {
  const CustomBottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationController navigationController = Get.find<NavigationController>();
    return Obx(
      ()=> BottomNavigationBar(
        currentIndex: navigationController.currentIndex.value,
        onTap: (index) => navigationController.changeIndex(index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
            ),
             BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'Mua sắm',
            ),
             BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: 'Yêu thích',
            ),
             BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Tài khoản',
            ),
        ],
        ),
    );
  }
}