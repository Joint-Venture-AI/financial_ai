import 'package:financial_ai_mobile/controller/add_data_controller/add_data_controller.dart';
import 'package:financial_ai_mobile/core/utils/app_icons.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class BaseHelper {
  static showIncomeBottomSheet({required BuildContext context}) {
    return showBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 200.h,
          decoration: BoxDecoration(
            color: AppStyles.darkGreyColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.r),
              topRight: Radius.circular(40.r),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: Column(
              children: [
                Container(
                  width: 40.w,
                  height: 2,
                  decoration: BoxDecoration(
                    color: AppStyles.lightGreyColor,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                SizedBox(height: 20.h),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 0.75,
                      color: AppStyles.lightGreyColor,
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            category_item_grid(
                              text: 'Salery',
                              iconPath: AppIcons.saleryIcon,
                            ),
                            VerticalDivider(
                              width: 1,
                              color: AppStyles.greyColor,
                              thickness: 1,
                            ),
                            category_item_grid(
                              text: 'Prety Cash',
                              iconPath: AppIcons.cashIcon,
                            ),
                            VerticalDivider(
                              width: 1,
                              color: AppStyles.greyColor,
                              thickness: 1,
                            ),
                            category_item_grid(
                              text: 'Bonus',
                              iconPath: AppIcons.bonus,
                            ),
                          ],
                        ),
                      ),

                      Container(
                        width: double.infinity,
                        color: AppStyles.lightGreyColor,
                        height: 1.h,
                      ),
                      SizedBox(height: 8.h),
                      Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add, color: Colors.white),
                            Text(
                              'Other',
                              style: AppStyles.mediumText.copyWith(
                                color: Colors.white,
                                fontSize: 16.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static showExpenseBottomSheet({required BuildContext context}) {
    return showBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 200.h,
          decoration: BoxDecoration(
            color: AppStyles.darkGreyColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.r),
              topRight: Radius.circular(40.r),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: Column(
              children: [
                Container(
                  width: 40.w,
                  height: 2,
                  decoration: BoxDecoration(
                    color: AppStyles.lightGreyColor,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                SizedBox(height: 20.h),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 0.75,
                      color: AppStyles.lightGreyColor,
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            category_item_grid(
                              text: 'Salery',
                              iconPath: AppIcons.saleryIcon,
                            ),
                            VerticalDivider(
                              width: 1,
                              color: AppStyles.greyColor,
                              thickness: 1,
                            ),
                            category_item_grid(
                              text: 'Prety Cash',
                              iconPath: AppIcons.cashIcon,
                            ),
                            VerticalDivider(
                              width: 1,
                              color: AppStyles.greyColor,
                              thickness: 1,
                            ),
                            category_item_grid(
                              text: 'Bonus',
                              iconPath: AppIcons.bonus,
                            ),
                          ],
                        ),
                      ),

                      Container(
                        width: double.infinity,
                        color: AppStyles.lightGreyColor,
                        height: 1.h,
                      ),
                      SizedBox(height: 8.h),
                      Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add, color: Colors.white),
                            Text(
                              'Other',
                              style: AppStyles.mediumText.copyWith(
                                color: Colors.white,
                                fontSize: 16.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Widget category_item_grid({
    required String text,
    required String iconPath,
  }) {
    return InkWell(
      onTap: () {
        final controller = Get.find<AddDataController>();
        controller.selectedIncomeCategory.value = text;
      },
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Expanded(
          child: Row(
            children: [
              SvgPicture.asset(iconPath, width: 24.w, height: 24.h),
              SizedBox(width: 5.w),
              Text(
                'Salery',
                style: AppStyles.mediumText.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
