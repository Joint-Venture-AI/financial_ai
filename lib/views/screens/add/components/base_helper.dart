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
                            _buildCategoryCell(
                              text: 'Salery',
                              iconPath: AppIcons.saleryIcon,
                            ),
                            VerticalDivider(
                              width: 1,
                              color: AppStyles.greyColor,
                              thickness: 1,
                            ),
                            _buildCategoryCell(
                              text: 'Prety Cash',
                              iconPath: AppIcons.cashIcon,
                            ),
                            VerticalDivider(
                              width: 1,
                              color: AppStyles.greyColor,
                              thickness: 1,
                            ),
                            _buildCategoryCell(
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
          height: 300.h,
          decoration: BoxDecoration(
            color: AppStyles.darkGreyColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(36.r),
              topRight: Radius.circular(36.r),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min, // Dynamic height based on content
            children: [
              Container(
                width: 40.w,
                height: 3.h,
                decoration: BoxDecoration(
                  color: AppStyles.greyColor,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 0.75.w, color: AppStyles.greyColor),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Table(
                  border: TableBorder(
                    verticalInside: BorderSide(color: Colors.grey, width: 1),
                    horizontalInside: BorderSide(color: Colors.grey, width: 1),
                    top: BorderSide.none,
                    bottom: BorderSide.none,
                    left: BorderSide.none,
                    right: BorderSide.none,
                  ),
                  columnWidths: {
                    0: FlexColumnWidth(1),
                    1: FlexColumnWidth(1),
                    2: FlexColumnWidth(1),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    // Row 1: Food, Social Life, Pets
                    TableRow(
                      children: [
                        _buildCategoryCell(
                          iconPath: AppIcons.myFoodIcon,
                          text: 'Food',
                        ),
                        _buildCategoryCell(
                          iconPath: AppIcons.socialIcon,
                          text: 'Social Life',
                        ),
                        _buildCategoryCell(
                          iconPath: AppIcons.petsIcon,
                          text: 'Pets',
                        ),
                      ],
                    ),
                    // Row 2: Education, Gift, Transport
                    TableRow(
                      children: [
                        _buildCategoryCell(
                          iconPath: AppIcons.educationIcon,
                          text: 'Education',
                        ),
                        _buildCategoryCell(
                          iconPath: AppIcons.gitIcon,
                          text: 'Gift',
                        ),
                        _buildCategoryCell(
                          iconPath: AppIcons.transpost,
                          text: 'Transport',
                        ),
                      ],
                    ),
                    // Row 3: Rent, Apparel, Beauty
                    TableRow(
                      children: [
                        _buildCategoryCell(
                          iconPath: AppIcons.rentIcon,
                          text: 'Rent',
                        ),
                        _buildCategoryCell(
                          iconPath: AppIcons.apprarelIcon,
                          text: 'Apparel',
                        ),
                        _buildCategoryCell(
                          iconPath: AppIcons.beautyIcon,
                          text: 'Beauty',
                        ),
                      ],
                    ),
                    // Row 4: Health, Other (spanning all columns)
                    TableRow(
                      children: [
                        _buildCategoryCell(
                          iconPath: AppIcons.healthIcon,
                          text: 'Health',
                        ),
                        TableCell(child: SizedBox.shrink()),
                        TableCell(
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 24.w,
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  'Other',
                                  style: AppStyles.mediumText.copyWith(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                  ),
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
            ],
          ),
        );
      },
    );
  }

  static showPayBottomSheet({required BuildContext context}) {
    return showBottomSheet(
      context: context,

      builder: (context) {
        return Container(
          height: 300.h,
          decoration: BoxDecoration(
            color: AppStyles.darkGreyColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(36.r),
              topRight: Radius.circular(36.r),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min, // Dynamic height based on content
            children: [
              Container(
                width: 40.w,
                height: 3.h,
                decoration: BoxDecoration(
                  color: AppStyles.greyColor,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 0.75.w, color: AppStyles.greyColor),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Table(
                  border: TableBorder(
                    verticalInside: BorderSide(color: Colors.grey, width: 1),
                    horizontalInside: BorderSide(color: Colors.grey, width: 1),
                    top: BorderSide.none,
                    bottom: BorderSide.none,
                    left: BorderSide.none,
                    right: BorderSide.none,
                  ),
                  columnWidths: {0: FlexColumnWidth(1), 1: FlexColumnWidth(1)},
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    // Row 1: Food, Social Life, Pets
                    TableRow(
                      children: [
                        _buildCategoryCell(
                          iconPath: AppIcons.myCashIcon,
                          text: 'Cash',
                        ),
                        _buildCategoryCell(
                          iconPath: AppIcons.cardIcon,
                          text: 'Card',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static Widget _buildCategoryCell({
    required String iconPath,
    required String text,
  }) {
    return InkWell(
      onTap: () {
        final controller = Get.find<AddDataController>();
        controller.selectedIncomeCategory.value =
            text; // Assuming this works for expenses too
      },
      child: Padding(
        padding: EdgeInsets.all(10.w), // Responsive padding
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(iconPath, width: 24.w, height: 24.h),
            SizedBox(width: 5.w),
            Text(
              text,
              style: AppStyles.mediumText.copyWith(
                color: Colors.white,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
