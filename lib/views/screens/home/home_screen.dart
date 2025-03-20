import 'package:financial_ai_mobile/core/utils/app_icons.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:financial_ai_mobile/views/screens/analyze/ai_expense_details_screen.dart';
import 'package:financial_ai_mobile/views/screens/analyze/ai_optimizes_screen.dart';
import 'package:financial_ai_mobile/views/screens/home/subs_screen/accounts/accounts_screen.dart';
import 'package:financial_ai_mobile/views/screens/home/subs_screen/courses/courses_screen.dart';
import 'package:financial_ai_mobile/views/screens/home/subs_screen/expense_details/espense_details_screen.dart';
import 'package:financial_ai_mobile/views/screens/notification/notification_screen.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppStyles.bgColor ?? Colors.white,
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
                    custom_app_bar(),
                    SizedBox(height: 26.h),
                    InkWell(
                      onTap: () => Get.to(AccountsScreen()),
                      child: header_body_section(),
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
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () => Get.to(CoursesScreen()),
                          child: Text(
                            'See all',
                            style: AppStyles.smallText.copyWith(
                              color: AppStyles.greyColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              course_section(),
              SizedBox(height: 15.h),
              InkWell(
                onTap: () => Get.to(ExpenseDetailsScreen()),
                child: financial_health(),
              ),
              SizedBox(height: 15.h),
              InkWell(
                onTap: () => Get.to(AiOptimizesScreen()),
                child: Padding(
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
                                  color: Colors.black,
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

                          financial_item(
                            iconPath: AppIcons.houseIcon,
                            title: 'Housing',
                            percents: 30,
                          ),
                          SizedBox(height: 5.h),
                          financial_item(
                            iconPath: AppIcons.foodIcon,
                            title: 'Food & Groceries',
                            percents: 10,
                          ),
                          SizedBox(height: 5.h),
                        ],
                      ),
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

  Container financial_item({
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
          vertical: 5.h,
        ), // Reduced vertical padding for responsiveness
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.start, // Ensure items align correctly
          children: [
            // Icon Container
            Container(
              height: 44.h, // Use .h for responsiveness
              width: 44.w, // Use .w for responsiveness
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
            Text(
              title,
              style: AppStyles.smallText.copyWith(
                color: Colors.black,
                fontSize: 14.sp,
              ),
            ),
            const Spacer(), // To align the CircularPercentIndicator properly
            // CircularPercentIndicator
            CircularPercentIndicator(
              animation: true,
              radius: 25.0, // Adjust radius if necessary for smaller screens
              lineWidth: 10.0, // Set width to 10
              percent: 0.3, // 30% progress
              center: Text(
                "$percents%",
                style: AppStyles.smallText.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 12.sp,
                ),
              ),
              progressColor: AppStyles.primaryColor, // Filled progress color
              backgroundColor:
                  AppStyles.lightGreyColor, // Non-filled (remaining) color
            ),
          ],
        ),
      ),
    );
  }

  Padding financial_health() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white, // White background
              borderRadius: BorderRadius.circular(32.r),
              boxShadow: [
                BoxShadow(
                  blurRadius: 36,
                  color: Colors.black.withOpacity(0.1), // More visible shadow
                  offset: const Offset(0, 4), // Slight offset for better effect
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Your Financial Health',
                        style: AppStyles.mediumText.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      const Spacer(),
                      SvgPicture.asset(AppIcons.moreIcon, color: Colors.grey),
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
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  'Total cost in month',
                                  style: AppStyles.smallText.copyWith(
                                    color: Colors.grey,
                                    fontSize: 12.sp,
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
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  'Save in month',
                                  style: AppStyles.smallText.copyWith(
                                    color: Colors.grey,
                                    fontSize: 12.sp,
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
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 100.w,
                        height: 100.h, // Specify a height for the PieChart
                        child: PieChart(
                          PieChartData(
                            sections: [
                              PieChartSectionData(
                                value: 93,
                                title: '93%',

                                color: AppStyles.orangeColor,
                              ),
                              PieChartSectionData(
                                value: 7,
                                title: '7%',
                                color: AppStyles.primaryColor,
                              ),
                            ],
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
      ),
    );
  }

  Row custom_app_bar() {
    return Row(
      children: [
        SizedBox(
          width: 65.w,
          height: 32.h,
          child: Image.asset(
            AppIcons.appBrandLogo,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.error);
            },
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: ()=> Get.to(NotificationScreen()),
          child: SvgPicture.asset(
            AppIcons.bellIcon,
            width: 24.w,
            height: 24.h,
            color: Colors.black,
            placeholderBuilder: (context) => const Icon(Icons.error),
          ),
        ),
        SizedBox(width: 10.w),
        SvgPicture.asset(
          AppIcons.profileIcon,
          width: 24.w,
          height: 24.h,
          color: Colors.black,
          placeholderBuilder: (context) => const Icon(Icons.error),
        ),
        SizedBox(width: 10.w),
      ],
    );
  }

  SingleChildScrollView course_section() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(4, (index) {
          return Padding(
            padding: EdgeInsets.only(left: 15.w),
            child: SizedBox(
              width: 242.w,
              height: 150.h,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Image.asset(
                        AppIcons.coverImage,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        gradient: LinearGradient(
                          colors: [Colors.black, Colors.transparent],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.h,
                      horizontal: 10.w,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Upgrade ',
                              style: AppStyles.mediumText.copyWith(
                                color: AppStyles.primaryColor,
                                fontSize: 15.sp,
                              ),
                            ),
                            Text(
                              'Yourself Financially',
                              style: AppStyles.mediumText.copyWith(
                                color: Colors.white,
                                fontSize: 15.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          'Master budgeting, investing & money management with expert courses!',
                          style: AppStyles.smallText.copyWith(
                            color: Colors.white,
                            fontSize: 12.sp,
                          ),
                        ),
                        SizedBox(height: 15.h),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            'Enroll Now',
                            style: AppStyles.mediumText.copyWith(
                              color: Colors.white,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget header_body_section() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // White background
        borderRadius: BorderRadius.circular(32.r),
        boxShadow: [
          BoxShadow(
            blurRadius: 36,
            color: Colors.black.withOpacity(0.1), // More visible shadow
            offset: const Offset(0, 4), // Slight offset for better effect
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28.r),
                gradient: LinearGradient(
                  colors: [
                    AppStyles.primaryColor ?? Colors.blue,
                    AppStyles.primarySecondColor ?? Colors.green,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
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
                          const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
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
                          const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      '\$10,000',
                      style:
                          AppStyles.smallText?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 40.sp,
                          ) ??
                          const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 40,
                          ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'Today (-\$140)',
                      style:
                          AppStyles.smallText?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                          ) ??
                          const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
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
                              ) ??
                              const TextStyle(color: Colors.black),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          '\$32,000.00',
                          style:
                              AppStyles.smallText?.copyWith(
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                              ) ??
                              const TextStyle(color: Colors.green),
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
                              ) ??
                              const TextStyle(color: Colors.black),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          '\$22,000.00',
                          style:
                              AppStyles.smallText?.copyWith(
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                              ) ??
                              const TextStyle(color: Colors.red),
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
  }
}
