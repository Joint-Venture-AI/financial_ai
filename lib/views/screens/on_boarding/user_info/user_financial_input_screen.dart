import 'package:financial_ai_mobile/controller/welcome_controller.dart';
import 'package:financial_ai_mobile/core/utils/app_icons.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:financial_ai_mobile/views/glob_widgets/custom_text_feild.dart';
import 'package:financial_ai_mobile/views/glob_widgets/our_gob_text_button.dart';
import 'package:financial_ai_mobile/views/glob_widgets/second_textfeild.dart';
import 'package:financial_ai_mobile/views/screens/home/home_screen.dart';
import 'package:financial_ai_mobile/views/screens/bottom_nav/tab_screen.dart';
import 'package:financial_ai_mobile/views/screens/on_boarding/user_info/fixed_monthly_expense_screen.dart';
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
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 45.h),

            // Title
            Text(
              'Financial Overview',
              style: AppStyles.mediumText.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
              ),
            ),

            // Subtitle
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Text(
                'Provide key financial details for personalized\nadvice from your AI financial advisor.',
                style: AppStyles.smallText.copyWith(
                  color: AppStyles.greyColor,
                  fontSize: 13.sp,
                ),
              ),
            ),

            SizedBox(height: 32.h),

            // Monthly Income
            Text(
              'Monthly Income',
              style: AppStyles.mediumText.copyWith(fontSize: 14.sp),
            ),
            SizedBox(height: 6.h),
            _buildInputField('Ex 50,000\$'),

            SizedBox(height: 16.h),

            // Monthly Expense
            Text(
              'Monthly Expense',
              style: AppStyles.mediumText.copyWith(fontSize: 14.sp),
            ),
            SizedBox(height: 6.h),
            _buildInputField('Ex 30,000\$'),

            SizedBox(height: 16.h),

            // Current Balance
            Text(
              'Current Balance',
              style: AppStyles.mediumText.copyWith(fontSize: 14.sp),
            ),
            SizedBox(height: 6.h),
            _buildInputField('Ex 12,000\$'),

            SizedBox(height: 16.h),

            // Fixed Expense Row
            Text(
              'Add Fixed Expense',
              style: AppStyles.mediumText.copyWith(fontSize: 14.sp),
            ),
            SizedBox(height: 6.h),
            InkWell(
              onTap: () => Get.to(FixedMonthlyExpenseScreen()),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, color: Colors.teal),
                    SizedBox(width: 8.w),
                    Text(
                      'Add',
                      style: TextStyle(
                        color: Colors.teal,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 30.h),

            // Next Button
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                onPressed: () => Get.to(MainScreen()),
                child: Text(
                  'Next',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20.h),

            // Back Button
            InkWell(
              onTap: () => Get.back(),
              borderRadius: BorderRadius.circular(10.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.arrow_back_ios,
                    size: 16,
                    color: Colors.grey,
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

  Widget _buildInputField(String hint) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      height: 50.h,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          hint,
          style: TextStyle(color: Colors.grey, fontSize: 14.sp),
        ),
      ),
    );
  }
}
