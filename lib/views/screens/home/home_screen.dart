import 'package:financial_ai_mobile/controller/home/home_controller.dart';
import 'package:financial_ai_mobile/core/utils/app_icons.dart';
import 'package:financial_ai_mobile/core/utils/app_routes.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:financial_ai_mobile/views/glob_widgets/our_gob_text_button.dart';
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
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final homeController = Get.find<HomeController>();

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
                    customAppBar(),
                    SizedBox(height: 26.h),
                    InkWell(
                      onTap: () => Get.to(AccountsScreen()),
                      child: headerBodySection(),
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
                          onPressed: () => Get.to(CoursesScreen()),
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
              courseSection(),
              SizedBox(height: 15.h),
              InkWell(
                onTap: () => Get.to(ExpenseDetailsScreen()),
                child: financialHealth(),
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

                          financialItem(
                            iconPath: AppIcons.houseIcon,
                            title: 'Housing',
                            percents: 30,
                          ),
                          SizedBox(height: 5.h),
                          financialItem(
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

  Container financialItem({
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
            Expanded(
              // Added Expanded widget
              child: Text(
                title,
                style: AppStyles.smallText.copyWith(
                  color: Colors.black,
                  fontSize: 14.sp,
                ),
                overflow: TextOverflow.ellipsis, // Added overflow property
              ),
            ),
            const Spacer(), // To align the CircularPercentIndicator properly
            // CircularPercentIndicator
            CircularPercentIndicator(
              animation: true,
              radius: 25.0, // Adjust radius if necessary for smaller screens
              lineWidth: 10.0, // Set width to 10
              percent: percents / 100, //Progress should be between 0 to 1
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

  Padding financialHealth() {
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
              padding: EdgeInsets.all(20.r), //Make padding responsive
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Your Financial Health',
                        style: AppStyles.mediumText.copyWith(
                          color: Colors.black,
                          fontSize: 16.sp, //Added font size responsiveness
                        ),
                      ),
                      // const Spacer(),
                      // SvgPicture.asset(
                      //   AppIcons.moreIcon,
                      //   color: Colors.grey,
                      //   width: 20.w,
                      //   height: 20.h,
                      // ), //make it responsive
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
                                    borderRadius: BorderRadius.circular(5.r),
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
                              textAlign:
                                  TextAlign.start, // Added text alignment
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
                                radius: 30, //Added radius
                                titleStyle: TextStyle(
                                  fontSize: 10.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ), //Added text style
                                color: AppStyles.orangeColor,
                              ),
                              PieChartSectionData(
                                value: 7,
                                title: '7%',
                                radius: 30, //Added radius
                                titleStyle: TextStyle(
                                  fontSize: 10.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ), //Added text style
                                color: AppStyles.primaryColor,
                              ),
                            ],
                            centerSpaceRadius:
                                0, // remove space around piechart
                            borderData: FlBorderData(show: false),
                            sectionsSpace: 0,
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

  Widget courseSection() {
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
                          maxLines: 2, // Added maxLines and overflow properties
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacer(),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                12,
                              ), // Set the radius here
                            ),
                            backgroundColor:
                                AppStyles
                                    .primaryColor, // Set background color if needed
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ), // Adjust padding if needed
                          ),
                          onPressed: () {},
                          child: Text(
                            'Enroll Now',
                            style: AppStyles.mediumText.copyWith(
                              color: Colors.white,
                              fontSize: 12,
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

  Widget headerBodySection() {
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
        padding: EdgeInsets.all(8.r), //responsive padding
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
                padding: EdgeInsets.all(15.r), //responsive padding
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
                            fontSize: 16.sp, // responsive font size
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
                            fontSize: 14.sp, // responsive font size
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
                          TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 40.sp, // responsive font size
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
                          TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp, // responsive font size
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
                                fontSize: 14.sp, // responsive font size
                              ) ??
                              TextStyle(color: Colors.black, fontSize: 14.sp),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          '\$32,000.00',
                          style:
                              AppStyles.smallText?.copyWith(
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp, // responsive font size
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
                                fontSize: 14.sp, // responsive font size
                              ) ??
                              TextStyle(color: Colors.black, fontSize: 14.sp),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          '\$22,000.00',
                          style:
                              AppStyles.smallText?.copyWith(
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp, // responsive font size
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
  }
}
