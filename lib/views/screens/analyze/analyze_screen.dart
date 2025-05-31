import 'package:custom_refresh_indicator/custom_refresh_indicator.dart'; // Added for refresh
import 'package:financial_ai_mobile/controller/analyze/analyze_controller.dart';
import 'package:financial_ai_mobile/core/utils/app_icons.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:financial_ai_mobile/views/screens/ai_chat/ai_chat_screen.dart';
// import 'package:financial_ai_mobile/views/screens/analyze/ai_expense_details_screen.dart'; // Not used in current active code
import 'package:financial_ai_mobile/views/screens/analyze/components/custom_slider.dart';
import 'package:financial_ai_mobile/views/screens/analyze/components/expense_pie_chart.dart'; // Renamed from PieChartSample2 in file, assuming this is it
import 'package:financial_ai_mobile/views/screens/profie/profile_screen.dart';
import 'package:financial_ai_mobile/views/screens/notification/notification_screen.dart';
import 'package:flutter/cupertino.dart'; // Added for CupertinoActivityIndicator
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

// Main Screen Widget
class AnalyzeScreen extends StatelessWidget {
  AnalyzeScreen({super.key});

  // Moved controller instantiation here to be consistent, though AnalyzeExpenseSection will find it
  // final AnalyzeController analyzeController = Get.put(AnalyzeController()); // Or Get.find() if already put elsewhere (e.g. by HomeScreen)

  @override
  Widget build(BuildContext context) {
    // Ensure AnalyzeController is available. If HomeScreen puts it, Get.find() in AnalyzeExpenseSection is fine.
    // If AnalyzeScreen can be accessed independently, putting it here or ensuring it's put by a parent route is necessary.
    // For now, assuming Get.find() in AnalyzeExpenseSection will work.
    return Scaffold(
      backgroundColor: AppStyles.bgColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
              child: customAppBar(),
            ),
            Expanded(child: AnalyzeExpenseSection()),
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
          style:
              AppStyles.mediumText?.copyWith(fontSize: 20.sp) ??
              TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
              ), // Added fallback
        ),
        const Spacer(),
        InkWell(
          onTap: () => Get.to(() => NotificationScreen()),
          child: SvgPicture.asset(
            AppIcons.bellIcon,
            width: 24.w,
            height: 24.h,
            colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
            placeholderBuilder:
                (context) => const SizedBox(
                  width: 24,
                  height: 24,
                ), // Simpler placeholder
          ),
        ),
        SizedBox(width: 10.w),
        InkWell(
          onTap: () => Get.to(() => ProfileScreen()),
          child: SvgPicture.asset(
            AppIcons.profileIcon,
            width: 24.w,
            height: 24.h,
            colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
            placeholderBuilder:
                (context) => const SizedBox(
                  width: 24,
                  height: 24,
                ), // Simpler placeholder
          ),
        ),
        // SizedBox(width: 10.w), // Removed this as it was likely a typo from previous code copy
      ],
    );
  }
}

// Analyze Expense Section Widget
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
    // It's safer to use Get.put if you are not sure it's already in memory,
    // or ensure it's put by a higher-level widget (like a TabController managing screens).
    // If HomeScreen and AnalyzeScreen are part of a BottomNavigationBar,
    // the controller might be put by the main navigation widget or by HomeScreen itself.
    // Using Get.find() assumes it's already been put.
    try {
      controller = Get.find<AnalyzeController>();
    } catch (e) {
      print(
        "AnalyzeController not found, putting a new instance. This might indicate a structural issue if it should have been found.",
      );
      controller = Get.put(AnalyzeController());
    }

    // Initial data fetch if list is empty
    // This is good, but refresh will handle subsequent fetches
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.expenseCategoryList.isEmpty &&
          !controller.isLoading.value) {
        print(
          "[AnalyzeExpenseSection - initState] Initial fetch: expenseCategoryList is empty.",
        );
        controller.getReportCategory();
      }
    });
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
      "rent_mortgage": AppIcons.home,
      "personal_care": AppIcons.profileIcon,
      "insurance": AppIcons.insuranceIcon,
      "transfer": AppIcons.transferIcon,
      "other": AppIcons.otherIcon,
    };
    final key = categoryName.toLowerCase();
    return categoryIconMap[key] ?? AppIcons.otherIcon;
  }

  String _getTitleForCategory(String categoryName) {
    final Map<String, String> categoryTitleMap = {
      "food_dining": 'Food & Dining',
      "transportation": 'Transportation',
      "utilities": 'Utilities',
      "health_medical": 'Health & Medical',
      "entertainment": 'Entertainment',
      "shopping": 'Shopping',
      "education": 'Education',
      "travel": 'Travel',
      "rent_mortgage": 'Housing / Rent / Mortgage',
      "personal_care": 'Personal Care',
      "insurance": 'Insurance',
      "transfer": 'Transfer',
      "other": 'Other',
    };
    final key = categoryName.toLowerCase();
    return categoryTitleMap[key] ?? 'Empty';
  }

  @override
  Widget build(BuildContext context) {
    return CustomMaterialIndicator(
      onRefresh: () async {
        print("[AnalyzeExpenseSection - onRefresh] Refresh initiated by user.");
        try {
          // The controller.getReportCategory() should internally set its isLoading flag
          // and update its reactive variables (like expenseCategoryList).
          await controller.getReportCategory();
          print("[AnalyzeExpenseSection - onRefresh] Data fetching complete.");
        } catch (error, stackTrace) {
          print(
            "[AnalyzeExpenseSection - onRefresh] Error during refresh: $error",
          );
          print("[AnalyzeExpenseSection - onRefresh] StackTrace: $stackTrace");
          if (mounted && Get.isSnackbarOpen == false) {
            Get.snackbar(
              "Refresh Error",
              "Could not update data. Please try again.",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.redAccent,
              colorText: Colors.white,
            );
          }
        } finally {
          print(
            "[AnalyzeExpenseSection - onRefresh] Refresh process finalized.",
          );
        }
      },
      indicatorBuilder: (
        BuildContext context,
        IndicatorController indicatorController,
      ) {
        return const CupertinoActivityIndicator();
      },
      child: SingleChildScrollView(
        physics:
            const AlwaysScrollableScrollPhysics(), // Crucial for pull-to-refresh
        scrollDirection: Axis.vertical,
        // physics: const BouncingScrollPhysics(), // BouncingScrollPhysics is fine too
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
                        // This inner container seems redundant with the outer one
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
                                  // Assuming controller.isLoading is for the category list fetch
                                  if (controller.isLoading.value &&
                                      controller.expenseCategoryList.isEmpty) {
                                    return const Center(
                                      child:
                                          CupertinoActivityIndicator(), // Changed to Cupertino
                                    );
                                  }
                                  // ExpensePieChart (PieChartSample2) should ideally handle its own empty/loading state internally for robustness
                                  // or at least have a way to display "No data" if categories are empty post-load.
                                  if (controller.expenseCategoryList.isEmpty &&
                                      !controller.isLoading.value) {
                                    return Center(
                                      child: Text(
                                        "No data for chart.",
                                        style: AppStyles.smallText?.copyWith(
                                          color: AppStyles.greyColor,
                                        ),
                                      ),
                                    );
                                  }
                                  return PieChartSample2(
                                    // Renamed PieChartSample2 to ExpensePieChart
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
                      // This loading state is covered by the PieChart's loading state above if it's for the same data.
                      // if (controller.isLoading.value && controller.expenseCategoryList.isEmpty) {
                      //   return const Center(child: CupertinoActivityIndicator());
                      // }
                      if (controller.expenseCategoryList.isEmpty &&
                          !controller.isLoading.value) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.h),
                            child: Text(
                              "No expense categories to display.",
                              style:
                                  AppStyles.smallText?.copyWith(
                                    color: AppStyles.greyColor,
                                  ) ??
                                  TextStyle(
                                    color: AppStyles.greyColor,
                                  ), // Added fallback
                            ),
                          ),
                        );
                      }
                      return Column(
                        children:
                            controller.expenseCategoryList.map((expense) {
                              return expense_details_item(
                                text: _getTitleForCategory(expense.category),
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
              SizedBox(height: 20.h), // For scrollability at the bottom
            ],
          ),
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
            colors: [
              AppStyles.primaryColor ?? Colors.teal, // Added fallback
              const Color(0xff0A3431),
            ],
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
                      style:
                          AppStyles.largeText?.copyWith(
                            // Added null-aware
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ) ??
                          TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'AI will suggest how to spend your money & make a better savings suggestion',
                      style:
                          AppStyles.smallText?.copyWith(
                            // Added null-aware
                            fontSize: 12.sp,
                            color: Colors.white.withOpacity(0.8),
                          ) ??
                          TextStyle(
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
                      AppStyles.primaryColor ?? Colors.teal, // Added fallback
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
                  style:
                      AppStyles.mediumText?.copyWith(
                        // Added null-aware
                        color: AppStyles.primaryColor,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ) ??
                      TextStyle(
                        color: AppStyles.primaryColor,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(width: 5.w),
                Text(
                  'Optimized Your Spending',
                  style:
                      AppStyles.mediumText?.copyWith(
                        // Added null-aware
                        color: Colors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ) ??
                      TextStyle(
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
              style:
                  AppStyles.smallText?.copyWith(
                    // Added null-aware
                    color: AppStyles.greyColor,
                    fontSize: 14.sp,
                  ) ??
                  TextStyle(color: AppStyles.greyColor, fontSize: 14.sp),
            ),
            SizedBox(height: 20.h),
            Obx(() {
              if (controller.isLoading.value &&
                  controller.expenseCategoryList.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CupertinoActivityIndicator(
                      radius: 12,
                    ), // Smaller indicator
                  ),
                );
              }
              if (controller.expenseCategoryList.isEmpty &&
                  !controller.isLoading.value) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Center(
                    child: Text(
                      "No spending data to optimize yet.",
                      style:
                          AppStyles.smallText?.copyWith(
                            // Added null-aware
                            color: AppStyles.greyColor,
                          ) ??
                          TextStyle(color: AppStyles.greyColor),
                    ),
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
                          title: _getTitleForCategory(expense.category),
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
      padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 8.h),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: AppStyles.lightGreyColor ?? Colors.grey.shade300,
          ), // Added fallback
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
                  color: (AppStyles.simpleGreenColor ?? Colors.green.shade100)
                      .withOpacity(0.50), // Added fallback
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    iconPath,
                    colorFilter: ColorFilter.mode(
                      AppStyles.primaryColor ?? Colors.teal, // Added fallback
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
                      style:
                          AppStyles.mediumText?.copyWith(
                            // Added null-aware
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ) ??
                          TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '$percents%',
                      style:
                          AppStyles.mediumText?.copyWith(
                            // Added null-aware
                            color: AppStyles.greyColor,
                            fontSize: 14.sp,
                          ) ??
                          TextStyle(
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
                  value: percents.toDouble().clamp(0.0, 100.0), // Clamped value
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
        border: Border.all(
          width: 1,
          color: AppStyles.lightGreyColor ?? Colors.grey.shade300,
        ), // Added fallback
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
                color: AppStyles.primaryColor ?? Colors.teal, // Added fallback
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
                style:
                    AppStyles.smallText?.copyWith(
                      // Added null-aware
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ) ??
                    TextStyle(
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
              percent: (percents / 100.0).clamp(0.0, 1.0), // Clamped value
              center: Text(
                "$percents%",
                style:
                    AppStyles.smallText?.copyWith(
                      // Added null-aware
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 10.sp,
                    ) ??
                    TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 10.sp,
                    ),
              ),
              progressColor:
                  AppStyles.primaryColor ?? Colors.teal, // Added fallback
              backgroundColor:
                  AppStyles.lightGreyColor ??
                  Colors.grey.shade300, // Added fallback
            ),
          ],
        ),
      ),
    );
  }
}
