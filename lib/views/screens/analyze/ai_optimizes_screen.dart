import 'package:financial_ai_mobile/core/helper/widget_helper.dart';
import 'package:financial_ai_mobile/core/utils/app_icons.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class AiOptimizesScreen extends StatelessWidget {
  const AiOptimizesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.bgColor,
      appBar: WidgetHelper.showAppBar(
        isBack: true,
        title: 'AI Optimizes',
        isCenter: false,
        showActions: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white, // White background
                borderRadius: BorderRadius.circular(32.r),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 36,
                    color: Colors.black.withOpacity(0.1), // More visible shadow
                    offset: const Offset(
                      0,
                      4,
                    ), // Slight offset for better effect
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

                    financial_item(
                      iconPath: AppIcons.houseIcon,
                      title: 'Housing',
                      percents: 30,
                    ),
                    SizedBox(height: 5.h),
                    financial_item(
                      iconPath: AppIcons.transportIcon,
                      title: 'Transportation',
                      percents: 15,
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
          ],
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
              radius: 25.0,
              // Adjust radius if necessary for smaller screens
              lineWidth: 10.0,
              // Set width to 10
              percent: 0.3,
              // 30% progress
              center: Text(
                "$percents%",
                style: AppStyles.smallText.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 12.sp,
                ),
              ),
              progressColor: AppStyles.primaryColor,
              // Filled progress color
              backgroundColor:
                  AppStyles.lightGreyColor, // Non-filled (remaining) color
            ),
          ],
        ),
      ),
    );
  }
}
