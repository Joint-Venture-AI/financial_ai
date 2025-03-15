import 'package:financial_ai_mobile/controller/tab_controller.dart';
import 'package:financial_ai_mobile/core/utils/app_icons.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class FloatingBottomNavBar extends StatelessWidget {
  final MyTabController tabController = Get.find();

  FloatingBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppStyles.primaryColor, AppStyles.primarySecondColor],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(100.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(AppIcons.home, 0, 'Home'),
              _buildNavItem(AppIcons.analyze, 1, 'Analyze'),
              SizedBox(width: 15.w), // Space for the FAB
              _buildNavItem(AppIcons.accounts, 3, 'Accounts'),
              _buildNavItem(AppIcons.aiChat, 4, 'AI Chat'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(String icon, int index, String label) {
    return GestureDetector(
      onTap: () {
        tabController.changeTabIndex(index);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            color:
                tabController.currentIndex.value == index
                    ? Colors.white
                    : Colors.white70,
            width: 24.w,
            height: 24.h,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color:
                  tabController.currentIndex.value == index
                      ? Colors.white
                      : Colors.white70,
              fontSize: 12,
              fontWeight:
                  tabController.currentIndex.value == index
                      ? FontWeight.bold
                      : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
