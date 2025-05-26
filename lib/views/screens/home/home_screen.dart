import 'package:financial_ai_mobile/controller/analyze/analyze_controller.dart';
import 'package:financial_ai_mobile/controller/home/home_controller.dart';
import 'package:financial_ai_mobile/core/utils/app_icons.dart';
import 'package:financial_ai_mobile/core/utils/app_routes.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:financial_ai_mobile/views/screens/analyze/ai_optimizes_screen.dart';
import 'package:financial_ai_mobile/views/screens/home/subs_screen/accounts/accounts_screen.dart';
import 'package:financial_ai_mobile/views/screens/home/subs_screen/courses/courses_item.dart';
import 'package:financial_ai_mobile/views/screens/home/subs_screen/courses/courses_screen.dart';
import 'package:financial_ai_mobile/views/screens/home/subs_screen/expense_details/espense_details_screen.dart';
import 'package:financial_ai_mobile/views/screens/notification/notification_screen.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final homeController = Get.put(HomeController());
  final controller = Get.put(AnalyzeController());

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
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppStyles.bgColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customAppBar(),
                    SizedBox(height: 26.h),
                    InkWell(
                      onTap: () => Get.to(AccountsScreen()),
                      child: headerBodySection(homeController),
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Financial Academy',
                          style: AppStyles.mediumText.copyWith(
                            color: Colors.black,
                            fontSize: 16.sp, //Added font size responsiveness
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () => Get.to(() => CoursesScreen()),
                          child: Text(
                            'See all',
                            style: AppStyles.smallText.copyWith(
                              color: AppStyles.greyColor,
                              fontSize: 12.sp, //Added font size responsiveness
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              courseSection(homeController),
              SizedBox(height: 15.h),
              InkWell(
                onTap:
                    () => Get.to(
                      ExpenseDetailsScreen(
                        totalCost: homeController.espenseBalancePer.value,
                        availableBalance:
                            homeController.availableBalancePer.value,
                      ),
                    ),
                child: financialHealth(homeController),
              ),
              SizedBox(height: 15.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white, // White background
                    borderRadius: BorderRadius.circular(32.r),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 36,
                        color: Colors.black.withOpacity(
                          0.1,
                        ), // More visible shadow
                        offset: const Offset(
                          0,
                          4,
                        ), // Slight offset for better effect
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.w,
                      vertical: 20.h,
                    ),
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
                              'Financial Alert!',
                              style: AppStyles.mediumText.copyWith(
                                color: const Color.fromARGB(255, 221, 202, 202),
                                fontSize: 20.sp,
                              ),
                            ),
                          ],
                        ),
                        Text.rich(
                          TextSpan(
                            text: "You're Spending ",
                            style: AppStyles.smallText.copyWith(
                              color: Colors.grey,
                              fontSize: 12.sp,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '93%',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold, // Make it bold
                                  color:
                                      Colors
                                          .black, // You can adjust the color if needed
                                  fontSize: 12.sp, // Make it responsive
                                ),
                              ),
                              TextSpan(
                                text: ' of your income',
                                style: AppStyles.smallText.copyWith(
                                  color: Colors.grey,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
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
                                      iconPath: _getIconForCategory(
                                        expense.category,
                                      ),
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
                ),
              ),
              SizedBox(height: 50.h),
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

  Widget financialHealth(HomeController homeController) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Obx(() {
        return homeController.isLoading.value
            ? CupertinoActivityIndicator()
            : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
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
                    padding: EdgeInsets.all(20.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Your Financial Health',
                              style: AppStyles.mediumText.copyWith(
                                color: Colors.black,
                                fontSize: 16.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15.h),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 16.w,
                                        height: 16.h,
                                        decoration: BoxDecoration(
                                          color: Color(0xffF38042),
                                          borderRadius: BorderRadius.circular(
                                            5.r,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 5.w),
                                      Expanded(
                                        child: Text(
                                          'Total cost in month',
                                          style: AppStyles.smallText.copyWith(
                                            color: Colors.grey,
                                            fontSize: 12.sp,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5.h),
                                  Row(
                                    children: [
                                      Container(
                                        width: 16.w,
                                        height: 16.h,
                                        decoration: BoxDecoration(
                                          color: AppStyles.primaryColor,
                                          borderRadius: BorderRadius.circular(
                                            5.r,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 5.w),
                                      Expanded(
                                        child: Text(
                                          'Save in month',
                                          style: AppStyles.smallText.copyWith(
                                            color: Colors.grey,
                                            fontSize: 12.sp,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15.h),
                                  Text(
                                    'Use AI to cut non-essentials and reduce fixed costs.',
                                    style: AppStyles.smallText.copyWith(
                                      color: Colors.grey,
                                      fontSize: 12.sp,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 100.w,
                              height: 100.h,
                              child: Obx(
                                () => PieChart(
                                  PieChartData(
                                    sections: [
                                      PieChartSectionData(
                                        value:
                                            homeController
                                                .espenseBalancePer
                                                .value,
                                        title:
                                            '${homeController.espenseBalancePer.value.toStringAsFixed(0)}%',
                                        radius: 30,
                                        titleStyle: TextStyle(
                                          fontSize: 10.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        color: AppStyles.orangeColor,
                                      ),
                                      PieChartSectionData(
                                        value:
                                            homeController
                                                .availableBalancePer
                                                .value,
                                        title:
                                            '${homeController.availableBalancePer.value.toStringAsFixed(0)}%',
                                        radius: 30,
                                        titleStyle: TextStyle(
                                          fontSize: 10.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        color: AppStyles.primaryColor,
                                      ),
                                    ],
                                    centerSpaceRadius: 0,
                                    borderData: FlBorderData(show: false),
                                    sectionsSpace: 0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
      }),
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
            fit: BoxFit.contain, //Added fit
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
        GestureDetector(
          onTap: () {
            Get.toNamed(AppRoutes.profile);
          },
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

  Widget courseSection(HomeController homeController) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Obx(() {
        return homeController.isLoading.value
            ? CupertinoActivityIndicator()
            : Row(
              children: List.generate(homeController.coursesModel.length, (
                index,
              ) {
                return CoursesItem(course: homeController.coursesModel[index]);
              }),
            );
      }),
    );
  }

  Widget headerBodySection(HomeController homeController) {
    return Obx(() {
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
          padding: EdgeInsets.all(8.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28.r),
                  gradient: LinearGradient(
                    colors: [
                      AppStyles.primaryColor,
                      AppStyles.primarySecondColor,
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(15.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'USD',
                        style:
                            AppStyles.smallText?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ) ??
                            TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        'Available Balance',
                        style:
                            AppStyles.smallText?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                            ) ??
                            TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                            ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        '\$${homeController.availableMoney.value.toStringAsFixed(2)}',
                        style:
                            AppStyles.smallText?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 40.sp,
                            ) ??
                            TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 40.sp,
                            ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        'Today (-\$${homeController.todayExpense.value.toStringAsFixed(2)})',
                        style:
                            AppStyles.smallText?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                            ) ??
                            TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              SizedBox(
                height: 60.h,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Income',
                            style:
                                AppStyles.smallText?.copyWith(
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                ) ??
                                TextStyle(color: Colors.black, fontSize: 14.sp),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            '\$${homeController.totalIncome.value.toStringAsFixed(2)}',
                            style:
                                AppStyles.smallText?.copyWith(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp,
                                ) ??
                                TextStyle(color: Colors.green, fontSize: 14.sp),
                          ),
                        ],
                      ),
                    ),
                    VerticalDivider(
                      width: 1,
                      thickness: 1,
                      color: AppStyles.lightGreyColor ?? Colors.grey,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Expense',
                            style:
                                AppStyles.smallText?.copyWith(
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                ) ??
                                TextStyle(color: Colors.black, fontSize: 14.sp),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            '\$${homeController.totalExpense.value.toStringAsFixed(2)}',
                            style:
                                AppStyles.smallText?.copyWith(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp,
                                ) ??
                                TextStyle(color: Colors.red, fontSize: 14.sp),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
