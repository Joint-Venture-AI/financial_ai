import 'package:financial_ai_mobile/controller/tab_controller.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:financial_ai_mobile/views/screens/add/add_screen.dart';
import 'package:financial_ai_mobile/views/screens/bottom_nav/components/tab_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  final MyTabController tabController = Get.put(MyTabController());

  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Obx(
              () => IndexedStack(
                index: tabController.currentIndex.value,
                children: tabController.tabScreens,
              ),
            ),
          ),
          Positioned(
            left: 15.w,
            right: 15.w,
            bottom: 10.h, // Adjusted to ensure FAB aligns properly
            child: FloatingBottomNavBar(),
          ),
        ],
      ),
      floatingActionButton: InkWell(
        borderRadius: BorderRadius.circular(100.r),
        onTap: () => Get.to(AddScreen()),
        child: Container(
          width: 56.w,
          height: 56.h,
          decoration: BoxDecoration(
            color: AppStyles.primaryColor,
            borderRadius: BorderRadius.circular(50.r),
          ),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
