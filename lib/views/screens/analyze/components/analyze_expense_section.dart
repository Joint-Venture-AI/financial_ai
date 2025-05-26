import 'package:financial_ai_mobile/controller/analyze/analyze_controller.dart';
import 'package:financial_ai_mobile/core/utils/app_icons.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:financial_ai_mobile/views/screens/ai_chat/ai_chat_screen.dart';
import 'package:financial_ai_mobile/views/screens/analyze/ai_expense_details_screen.dart';
// import 'package:financial_ai_mobile/views/screens/analyze/ai_optimizes_screen.dart'; // This import was unused
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
    return AppIcons.healthIcon; // Or some other generic icon
  }

  @override
  Widget build(BuildContext context) {
    // NOTE: If this AnalyzeExpenseSection widget is placed inside a parent Column,
    // ensure AnalyzeExpenseSection is wrapped with an Expanded widget to prevent RenderFlex overflow.
    // Example:
    // Column(
    //   children: [
    //     // ... other widgets ...
    //     Expanded(child: AnalyzeExpenseSection()),
    //     // ... other widgets ...
    //   ],
    // )
    // If this widget is the body of a Scaffold, it should work as is.

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Column(
          // This is the Column referenced in the error (approx. line 20 of this file)
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
                              height: 250.h,
                              child: Obx(() {
                                if (controller.isLoading.value &&
                                    controller.expenseCategoryList.isEmpty) {
                                  // Show a loader while pie chart data is loading initially
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                // PieChartSample2 should handle its own empty state if expenseCategories is empty.
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
                      // Show a general loading indicator for the list if it's still loading
                      // and pie chart might have already shown its own.
                      // This condition might be redundant if the pie chart loader is sufficient.
                      // return Center(child: CircularProgressIndicator());
                    }
                    if (controller.expenseCategoryList.isEmpty &&
                        !controller.isLoading.value) {
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
                            return expense_details_item(
                              text: expense.category,
                              iconPath: _getIconForCategory(expense.category),
                              percents: expense.percent,
                            );
                          }).toList(),
                    );
                  }),
                  SizedBox(
                    height: 8.h,
                  ), // Consider adding more padding if needed before card ends
                ],
              ),
            ),
            SizedBox(height: 10.h),
            _buildAISuggestionCard(),
            SizedBox(height: 10.h),
            _buildOptimizedSpendingCard(),
            SizedBox(height: 20.h), // Bottom padding for scrollable content
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
          padding: EdgeInsets.symmetric(
            horizontal: 15.w,
            vertical: 12.h,
          ), // Adjusted vertical padding
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
                    SizedBox(height: 4.h), // Added space
                    Text(
                      'AI will suggest how to spend your money & make a better savings suggestion',
                      style: AppStyles.smallText.copyWith(
                        fontSize: 12.sp,
                        color: Colors.white.withOpacity(
                          0.8,
                        ), // Adjusted text color for better contrast
                      ),
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
                    colorFilter: ColorFilter.mode(
                      AppStyles.primaryColor,
                      BlendMode.srcIn,
                    ), // Correct way to color SVG
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
        borderRadius: BorderRadius.circular(
          16.r,
        ), // Matched radius with other card
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
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 5.w),
                Text(
                  'Optimized Your Spending',
                  style: AppStyles.mediumText.copyWith(
                    color: Colors.black,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h), // Added space
            Text(
              'AI optimizes your expenses by cutting unnecessary costs.',
              style: AppStyles.smallText.copyWith(
                color: AppStyles.greyColor,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 20.h),
            Obx(() {
              if (controller.expenseCategoryList.isEmpty &&
                  !controller.isLoading.value) {
                // Show a message if list is empty and not loading
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Center(
                    child: Text(
                      "No spending data to optimize yet.",
                      style: AppStyles.smallText.copyWith(
                        color: AppStyles.greyColor,
                      ),
                    ),
                  ),
                );
              }
              // If loading and list is empty, an outer loader might be active.
              // Or, show a compact loader here if preferred.
              if (controller.isLoading.value &&
                  controller.expenseCategoryList.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(strokeWidth: 2.0),
                  ),
                );
              }
              return Column(
                children:
                    controller.expenseCategoryList.map((expense) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: 8.h,
                        ), // Increased spacing
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
    return Padding(
      padding: EdgeInsets.only(
        left: 15.w,
        right: 15.w,
        bottom: 8.h,
      ), // Adjusted bottom padding
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: AppStyles.lightGreyColor),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.start, // Default for Row
            children: [
              Container(
                width: 44.w,
                height: 44.h,
                decoration: BoxDecoration(
                  color: AppStyles.simpleGreenColor.withOpacity(
                    0.15,
                  ), // Softer background
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    iconPath,
                    colorFilter: ColorFilter.mode(
                      AppStyles.simpleGreenColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                // Allow text and slider to share space properly
                flex: 2, // Give more space to text column initially
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      text,
                      style: AppStyles.mediumText.copyWith(
                        color: Colors.black,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
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
              ),
              SizedBox(width: 10.w),
              Expanded(
                flex: 3, // Give more space to slider
                child: CustomSlider(
                  value: percents.toDouble(),
                  // Assuming CustomSlider takes a value, if it's meant to represent 'percents'
                  // value: percents / 100.0,
                  // onChanged: (newValue) { /* handle change if interactive */ },
                ),
              ),
            ],
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
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 8.h,
        ), // Adjusted vertical padding
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
                child: SvgPicture.asset(
                  iconPath,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                title,
                style: AppStyles.smallText.copyWith(
                  color: Colors.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 8.w),
            CircularPercentIndicator(
              animation: true,
              radius:
                  25.0, // Make sure this radius is appropriate for the row height
              lineWidth: 6.0, // Slightly thinner line
              percent: percents / 100.0,
              center: Text(
                "$percents%",
                style: AppStyles.smallText.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 10.sp, // Adjusted for smaller circle
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
