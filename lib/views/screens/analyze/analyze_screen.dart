import 'package:financial_ai_mobile/controller/analyze/analyze_controller.dart';
import 'package:financial_ai_mobile/core/utils/app_icons.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:financial_ai_mobile/views/screens/analyze/components/analyze_expense_section.dart';
import 'package:financial_ai_mobile/views/screens/profie/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../notification/notification_screen.dart';

class AnalyzeScreen extends StatelessWidget {
  AnalyzeScreen({super.key}) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.bgColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
              child: customAppBar(),
            ),
            AnalyzeExpenseSection(), // Uses Get.find() internally
          ],
        ),
      ),
    );
  }

  Widget customAppBar() {
    return Row(
      children: [
        Text(
          'Expense Analysis',
          style: AppStyles.mediumText.copyWith(fontSize: 20.sp),
        ),
        const Spacer(),
        InkWell(
          onTap: () => Get.to(() => NotificationScreen()),
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
          onTap: () => Get.to(() => ProfileScreen()),
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
