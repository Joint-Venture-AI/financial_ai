import 'package:financial_ai_mobile/core/helper/widget_helper.dart';
import 'package:financial_ai_mobile/core/utils/app_icons.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:financial_ai_mobile/views/screens/analyze/components/custom_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class AiExpenseDetailsScreen extends StatelessWidget {
  const AiExpenseDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.bgColor,
      appBar: WidgetHelper.showAppBar(
        isBack: true,
        title: 'Expense Details',
        isCenter: false,
        showActions: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    ///housing
                    expense_details_item(
                      text: 'Housing',

                      iconPath: AppIcons.house2dIcon,
                      percents: 30,
                    ),
                    SizedBox(height: 5.h),
                    expense_details_item(
                      text: 'Health',
                      iconPath: AppIcons.health2dIcon,
                      percents: 20,
                    ),
                    SizedBox(height: 5.h),

                    expense_details_item(
                      text: 'Apparel',

                      iconPath: AppIcons.apparel2dIcon,
                      percents: 12,
                    ),
                  ],
                ),
              ),
            ),
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
    return Container(
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
              mainAxisAlignment: MainAxisAlignment.start,
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

            Expanded(child: CustomSlider(value: percents.toDouble())),
          ],
        ),
      ),
    );
  }
}
