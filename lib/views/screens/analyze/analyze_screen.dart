import 'package:financial_ai_mobile/controller/analyze/analyze_controller.dart';
import 'package:financial_ai_mobile/core/helper/widget_helper.dart';
import 'package:financial_ai_mobile/core/utils/app_icons.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:financial_ai_mobile/views/screens/home/subs_screen/accounts/components/tab_item.dart';
import 'package:financial_ai_mobile/views/screens/profie/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../notification/notification_screen.dart';

class AnalyzeScreen extends StatelessWidget {
  AnalyzeScreen({super.key});
  final analyzeController = Get.put(AnalyzeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.bgColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
              child: Column(
                children: [
                  customAppBar(),
                  SizedBox(height: 20.h),
                  Obx(() {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 36,
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.r), //Responsive padding
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment:
                              MainAxisAlignment.spaceAround, // Use spaceAround
                          children:
                              analyzeController.accountTab.map((tab) {
                                // Use map directly
                                return Expanded(
                                  // Wrap TabItem in Expanded
                                  child: TabItem(
                                    isSelected:
                                        tab ==
                                        analyzeController.selectedTab.value,
                                    title: tab,
                                    onTap: () {
                                      analyzeController.selectedTab.value = tab;
                                    },
                                  ),
                                );
                              }).toList(), // Convert the map to a list
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),

            Expanded(child: analyzeController.tabListWidget[0]),
            SizedBox(height: 15.h),
          ],
        ),
      ),
    );
  }

  Row customAppBar() {
    return Row(
      children: [
        SizedBox(
          width: 65.w,
          height: 32.h,
          child: Image.asset(
            AppIcons.appBrandLogo,
            fit: BoxFit.contain, //Added fit property
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.error);
            },
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: () => Get.to(NotificationScreen()),
          child: SvgPicture.asset(
            AppIcons.bellIcon,
            width: 24.w,
            height: 24.h,
            color: Colors.black,
            placeholderBuilder: (context) => const Icon(Icons.error),
          ),
        ),
        SizedBox(width: 10.w),
        InkWell(
          onTap: () => Get.to(ProfileScreen()),
          child: SvgPicture.asset(
            AppIcons.profileIcon,
            width: 24.w,
            height: 24.h,
            color: Colors.black,
            placeholderBuilder: (context) => const Icon(Icons.error),
          ),
        ),
        SizedBox(width: 10.w),
      ],
    );
  }
}
