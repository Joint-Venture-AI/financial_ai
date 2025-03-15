import 'package:financial_ai_mobile/controller/welcome_controller.dart';
import 'package:financial_ai_mobile/core/utils/app_icons.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:financial_ai_mobile/views/glob_widgets/custom_text_feild.dart';
import 'package:financial_ai_mobile/views/glob_widgets/our_gob_text_button.dart';
import 'package:financial_ai_mobile/views/glob_widgets/second_textfeild.dart';
import 'package:financial_ai_mobile/views/screens/home/home_screen.dart';
import 'package:financial_ai_mobile/views/screens/bottom_nav/tab_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class UserFinancialInputScreen extends StatelessWidget {
  UserFinancialInputScreen({super.key});
  final welcomeController = Get.find<WelcomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.bgColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 45.h),
            Text(
              'Financial Overview',
              style: AppStyles.mediumText.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Provide key financial details for personalized advice from your AI financial advisor.',
              style: AppStyles.smallText.copyWith(
                color: AppStyles.greyColor,
                fontSize: 12.sp,
              ),
            ),
            SizedBox(height: 40.h),
            Text(
              'Monthly Income',
              style: AppStyles.mediumText.copyWith(fontSize: 14.sp),
            ),
            SizedBox(height: 5.h),
            SecondTextfeild(hintText: 'Ex 50,000\$'),
            SizedBox(height: 5.h),

            Text(
              'Monthly Expense',
              style: AppStyles.mediumText.copyWith(fontSize: 14.sp),
            ),
            SizedBox(height: 5.h),
            SecondTextfeild(hintText: 'Ex 30,000\$'),
            SizedBox(height: 5.h),

            Text(
              'Current Balance',
              style: AppStyles.mediumText.copyWith(fontSize: 14.sp),
            ),
            SizedBox(height: 5.h),
            SecondTextfeild(hintText: 'Ex 30,000\$'),
            SizedBox(height: 20.h),
            GlobTextButton(
              buttonText: 'Finish',
              onTap: () => Get.to(MainScreen()),
            ),
            SizedBox(height: 15.h),

            InkWell(
              onTap: () => Get.back(),
              borderRadius: BorderRadius.circular(10.r),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppIcons.backIcon,
                    color: AppStyles.greyColor,
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    'Back',
                    style: AppStyles.smallText.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
