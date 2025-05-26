import 'package:financial_ai_mobile/controller/analyze/analyze_controller.dart';
import 'package:financial_ai_mobile/core/utils/app_icons.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:financial_ai_mobile/views/screens/ai_chat/ai_chat_screen.dart';
import 'package:financial_ai_mobile/views/screens/analyze/ai_expense_details_screen.dart';
import 'package:financial_ai_mobile/views/screens/analyze/components/custom_slider.dart';
import 'package:financial_ai_mobile/views/screens/analyze/components/expense_pie_chart.dart';
import 'package:financial_ai_mobile/views/screens/profie/profile_screen.dart';
import 'package:financial_ai_mobile/views/screens/notification/notification_screen.dart'; // Ensured consistent path
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

// Main Screen Widget
class AnalyzeScreen extends StatelessWidget {
  AnalyzeScreen({super.key});

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
            Expanded(
              // Added Expanded here to prevent RenderFlex overflow
              child: AnalyzeExpenseSection(),
            ),
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
            colorFilter: const ColorFilter.mode(
              Colors.black,
              BlendMode.srcIn,
            ), // Using colorFilter for SVG
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
            colorFilter: const ColorFilter.mode(
              Colors.black,
              BlendMode.srcIn,
            ), // Using colorFilter for SVG
            placeholderBuilder: (context) => const Icon(Icons.error),
          ),
        ),
        SizedBox(
          width: 10.w,
        ), // Removed extra SizedBox that was there in original AnalyzeScreen.dart
      ],
    );
  }
}

// Analyze Expense Section Widget (previously in a separate file)
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
    final Map<String, String> categoryIconMap = {
      "food_dining": AppIcons.foodIcon,
      "transportation": AppIcons.transportIcon,
      "utilities": AppIcons.utilitiesIcon,
      "health_medical": AppIcons.health2dIcon,
      "entertainment": AppIcons.entertainment,
      "shopping": AppIcons.shopingBag,
      "education": AppIcons.educationIcon,
      "travel": AppIcons.transpost,
      "rent_mortgage": AppIcons.home, // for housing/rent/mortgage
      "personal_care": AppIcons.profileIcon,
      "insurance": AppIcons.insuranceIcon,
      "transfer": AppIcons.transferIcon,
      "other": AppIcons.otherIcon,
    };

    final key = categoryName.toLowerCase();

    // Return the matching icon or default if not found
    return categoryIconMap[key] ?? AppIcons.otherIcon;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
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
                              height: 250.h,
                              child: Obx(() {
                                if (controller.isLoading.value &&
                                    controller.expenseCategoryList.isEmpty) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return PieChartSample2(
                                  // Ensure PieChartSample2 handles its own empty state
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
                      // This specific loader might be redundant if PieChart loader is sufficient
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
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
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
                    SizedBox(height: 4.h),
                    Text(
                      'AI will suggest how to spend your money & make a better savings suggestion',
                      style: AppStyles.smallText.copyWith(
                        fontSize: 12.sp,
                        color: Colors.white.withOpacity(0.8),
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
                    ),
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
            SizedBox(height: 4.h),
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
                        padding: EdgeInsets.only(bottom: 8.h),
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
        padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 8.h),
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
              children: [
                Container(
                  width: 44.w,
                  height: 44.h,
                  decoration: BoxDecoration(
                    color: AppStyles.simpleGreenColor.withOpacity(0.50),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      iconPath,
                      colorFilter: ColorFilter.mode(
                        AppStyles.primaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  flex: 2,
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
                  flex: 3,
                  child: CustomSlider(
                    value:
                        percents
                            .toDouble(), // Assuming percents is between 0 and 100
                    // value: percents / 100.0, // If CustomSlider needs a value
                    // onChanged: (newValue) {},
                  ),
                ),
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
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
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
              radius: 25.0,
              lineWidth: 6.0,
              percent: percents / 100.0,
              center: Text(
                "$percents%",
                style: AppStyles.smallText.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 10.sp,
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
