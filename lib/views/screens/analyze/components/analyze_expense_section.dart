import 'package:financial_ai_mobile/controller/analyze/analyze_controller.dart';
import 'package:financial_ai_mobile/core/utils/app_icons.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:financial_ai_mobile/views/screens/ai_chat/ai_chat_screen.dart';
import 'package:financial_ai_mobile/views/screens/analyze/ai_expense_details_screen.dart';
import 'package:financial_ai_mobile/views/screens/analyze/ai_optimizes_screen.dart';
// import 'package:financial_ai_mobile/views/screens/analyze/ai_personal_suggetions.dart'; // This import was unused
import 'package:financial_ai_mobile/views/screens/analyze/components/custom_slider.dart';
import 'package:financial_ai_mobile/views/screens/analyze/components/expense_pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class AnalyzeExpenseSection extends StatefulWidget {
  const AnalyzeExpenseSection({super.key});

  @override
  State<AnalyzeExpenseSection> createState() => _AnalyzeExpenseSectionState();
}

class _AnalyzeExpenseSectionState extends State<AnalyzeExpenseSection> {
  late final AnalyzeController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<AnalyzeController>();

    // Fetch data if not already loaded
    // This check might be better inside the controller or using a flag
    // to prevent multiple calls if the view is rebuilt.
    // For simplicity, keeping it as is.
    if (controller.expenseCategoryList.isEmpty) {
      controller.getReportCategory();
    }
  }

  String _getIconForCategory(String categoryName) {
    final name = categoryName.toLowerCase();
    if (name.contains('housing')) return AppIcons.house2dIcon;
    if (name.contains('health')) return AppIcons.health2dIcon;
    if (name.contains('apparel') || name.contains('clothing')) {
      return AppIcons.apparel2dIcon;
    }
    if (name.contains('transport')) return AppIcons.transportIcon;
    // A default icon if no specific match
    return AppIcons
        .healthIcon; // Or some other generic icon like AppIcons.defaultCategoryIcon
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          children: [
            Container(
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
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Container(
                      width: double.infinity,
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
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height:
                                  250.h, // Increased height to accommodate legend better if it's part of chart
                              child: Obx(() {
                                if (controller.expenseCategoryList.isEmpty) {
                                  // You might want a specific placeholder for the chart area
                                  // or let PieChartSample2 handle its empty state.
                                  // For now, PieChartSample2 will show "No data..."
                                  return PieChartSample2(expenseCategories: []);
                                }
                                // Pass the list of expense categories to the chart
                                return PieChartSample2(
                                  expenseCategories:
                                      controller.expenseCategoryList.toList(),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Obx(() {
                    if (controller.isLoading.value &&
                        controller.expenseCategoryList.isEmpty) {
                      // Assuming an isLoading state
                      return Center(child: CircularProgressIndicator());
                    }
                    if (controller.expenseCategoryList.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          child: Text(
                            "No expense categories to display.",
                            style: AppStyles.smallText.copyWith(
                              color: AppStyles.greyColor,
                            ),
                          ),
                        ),
                      );
                    }
                    return Column(
                      children:
                          controller.expenseCategoryList.map((expense) {
                            // Assuming 'expense' object has 'category' (String) and 'percent' (int)
                            return expense_details_item(
                              text: expense.category,
                              iconPath: _getIconForCategory(expense.category),
                              percents: expense.percent,
                            );
                          }).toList(),
                    );
                  }),
                  SizedBox(height: 8.h),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            _buildAISuggestionCard(),
            SizedBox(height: 10.h),
            _buildOptimizedSpendingCard(),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildAISuggestionCard() {
    return InkWell(
      onTap: () => Get.to(() => AiChatScreen()),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          gradient: LinearGradient(
            colors: [AppStyles.primaryColor, const Color(0xff0A3431)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AI Personal Suggestion',
                      style: AppStyles.largeText.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'AI will suggest how to spend your money & make a better savings suggestion',
                      style: AppStyles.smallText.copyWith(fontSize: 12.sp),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                width: 32.w,
                height: 32.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    AppIcons.verticalSend,
                    color:
                        AppStyles.primaryColor, // Ensure this color is correct
                    width: 16.w,
                    height: 16.h,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptimizedSpendingCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32.r),
        boxShadow: [
          BoxShadow(
            blurRadius: 36,
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Ai',
                  style: AppStyles.mediumText.copyWith(
                    color: AppStyles.primaryColor,
                    fontSize: 20.sp,
                  ),
                ),
                SizedBox(width: 5.w),
                Text(
                  'Optimized Your Spending',
                  style: AppStyles.mediumText.copyWith(
                    color: Colors.black,
                    fontSize: 20.sp,
                  ),
                ),
                // const Spacer(),
                // Container(
                //   width: 32.w,
                //   height: 32.h,
                //   decoration: BoxDecoration(
                //     color: AppStyles.lightGreyColor,
                //     borderRadius: BorderRadius.circular(100.r),
                //   ),
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: SvgPicture.asset(
                //       AppIcons.verticalSend,
                //       color: AppStyles.greyColor,
                //       width: 16.w,
                //       height: 16.h,
                //     ),
                //   ),
                // ),
              ],
            ),
            Text(
              'AI optimizes your expenses by cutting unnecessary costs.',
              style: AppStyles.smallText.copyWith(
                color: AppStyles.greyColor,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 20.h),
            Obx(() {
              if (controller.expenseCategoryList.isEmpty) {
                // Show nothing or a placeholder if the list is empty
                return SizedBox.shrink();
              }
              return Column(
                children:
                    controller.expenseCategoryList.map((expense) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 5.h),
                        child: financial_item(
                          iconPath: _getIconForCategory(expense.category),
                          title: expense.category,
                          percents: expense.percent,
                        ),
                      );
                    }).toList(),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget expense_details_item({
    required String text,
    required String iconPath,
    required int percents,
  }) {
    return InkWell(
      onTap:
          () => Get.to(
            () => AiExpenseDetailsScreen(),
          ), // Consider passing category info
      child: Padding(
        padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 5.h),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: AppStyles.lightGreyColor),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 44.w,
                  height: 44.h,
                  decoration: BoxDecoration(
                    color: AppStyles.simpleGreenColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(iconPath),
                  ),
                ),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      style: AppStyles.mediumText.copyWith(
                        color: Colors.black,
                        fontSize: 14.sp,
                      ),
                    ),
                    Text(
                      '$percents%',
                      style: AppStyles.mediumText.copyWith(
                        color: AppStyles.greyColor,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: CustomSlider(),
                ), // This slider seems unrelated to the item's percent
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget financial_item({
    required String iconPath,
    required String title,
    required int percents,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: AppStyles.lightGreyColor),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        child: Row(
          children: [
            Container(
              height: 44.h,
              width: 44.w,
              decoration: BoxDecoration(
                color: AppStyles.primaryColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(iconPath, color: Colors.white),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                title,
                style: AppStyles.smallText.copyWith(
                  color: Colors.black,
                  fontSize: 14.sp,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 8.w),
            CircularPercentIndicator(
              animation: true,
              radius: 25.0,
              lineWidth: 8.0,
              percent:
                  percents / 100.0, // percents is int, ensure double division
              center: Text(
                "$percents%",
                style: AppStyles.smallText.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 12.sp,
                ),
              ),
              progressColor: AppStyles.primaryColor,
              backgroundColor: AppStyles.lightGreyColor,
            ),
          ],
        ),
      ),
    );
  }
}
