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
            _buildInputField('Enter your monthly income'),

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

            SizedBox(height: 10.h),
            Obx(() {
              return welcomeController.fixedMonthAmounts.isNotEmpty
                  ? SizedBox(
                    height: 25.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: welcomeController.fixedMonthAmounts.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () async {
                            welcomeController.fixedMonthAmounts.removeAt(index);

                            welcomeController.fixedMonthAmounts.refresh();
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 8.w),
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '${welcomeController.fixedMonthAmounts[index]['category']}: ${welcomeController.fixedMonthAmounts[index]['amount']}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  SizedBox(width: 5.w),
                                  Icon(
                                    Icons.cancel,
                                    color: Colors.white,
                                    size: 18.sp,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                  : const SizedBox.shrink();
            }),
            SizedBox(height: 16.h),
            // Next Button
            Obx(() {
              return SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  onPressed: () async {
                    if (welcomeController
                        .monthlyIncomeController
                        .text
                        .isEmpty) {
                      Get.snackbar(
                        'Error',
                        'Please enter your monthly income',
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                      return;
                    }
                    if (welcomeController.fixedMonthAmounts.isEmpty) {
                      Get.snackbar(
                        'Error',
                        'Please add at least one fixed expense',
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                      return;
                    }
                    await welcomeController.saveUserFixedData();
                  },
                  child:
                      welcomeController.isLoading.value
                          ? const CupertinoActivityIndicator(
                            color: Colors.white,
                          )
                          : Text(
                            'Next',
                            style: AppStyles.mediumText.copyWith(
                              color: Colors.white,
                              fontSize: 16.sp,
                            ),
                          ),
                ),
              );
            }),

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
      height: 50.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Center(
        child: TextField(
          controller: welcomeController.monthlyIncomeController,
          keyboardType: TextInputType.number,
          style: TextStyle(fontSize: 14.sp, color: Colors.black),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
          ),
        ),
      ),
    );
  }
}
