import 'package:financial_ai_mobile/controller/add_data_controller/add_data_controller.dart';
import 'package:financial_ai_mobile/core/utils/app_icons.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
// Removed: import 'package:get/get_core/src/get_main.dart'; // Get.dart is sufficient

class BaseHelper {
  static showIncomeBottomSheet({required BuildContext context}) {
    final addController = Get.find<AddDataController>();
    return showModalBottomSheet(
      // Using showModalBottomSheet for better dismiss behavior
      context: context,
      backgroundColor: Colors.transparent, // For custom border radius
      builder: (context) {
        return Container(
          height: 220.h, // Adjusted height slightly for padding
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
                  height: 3.h, // Standardized handle height
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
                          mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceAround, // Better distribution
                          children: [
                            Expanded(
                              // Use Expanded for even distribution
                              child: _buildCategoryCell(
                                displayText: 'Salary',
                                backendValue: 'salary',
                                iconPath:
                                    AppIcons
                                        .saleryIcon, // Assuming this is AppIcons.salaryIcon
                                isIncome: true,
                                controller: addController,
                              ),
                            ),
                            VerticalDivider(
                              width: 1,
                              color: AppStyles.greyColor,
                              thickness: 1,
                            ),
                            Expanded(
                              child: _buildCategoryCell(
                                displayText: 'Freelance',
                                backendValue: 'freelance',
                                iconPath:
                                    AppIcons
                                        .cashIcon, // Placeholder, consider AppIcons.freelanceIcon
                                isIncome: true,
                                controller: addController,
                              ),
                            ),
                            VerticalDivider(
                              width: 1,
                              color: AppStyles.greyColor,
                              thickness: 1,
                            ),
                            Expanded(
                              child: _buildCategoryCell(
                                displayText: 'Investments',
                                backendValue: 'investments',
                                iconPath:
                                    AppIcons
                                        .bonus, // Placeholder, consider AppIcons.investmentsIcon
                                isIncome: true,
                                controller: addController,
                              ),
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
                        child: InkWell(
                          onTap: () {
                            addController.selectedIncomeCategory.value =
                                'other';
                            Get.back();
                          },
                          child: Padding(
                            // Added padding for better tap area
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 20.sp,
                                ),
                                SizedBox(width: 8.w),
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
    final addController = Get.find<AddDataController>();
    return showModalBottomSheet(
      // Using showModalBottomSheet
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          // Adjusted height based on content: 4 rows + header + padding
          height: 330.h, // Might need adjustment based on actual cell height
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
            // mainAxisSize: MainAxisSize.min, // Keep if height is dynamic
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
              Expanded(
                // Allow table to take available space if needed
                child: SingleChildScrollView(
                  // In case content overflows
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 0.75.w,
                        color: AppStyles.greyColor,
                      ),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Table(
                      border: TableBorder(
                        verticalInside: BorderSide(
                          color: AppStyles.greyColor,
                          width: 0.75.w,
                        ),
                        horizontalInside: BorderSide(
                          color: AppStyles.greyColor,
                          width: 0.75.w,
                        ),
                      ),
                      columnWidths: {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(1),
                        2: FlexColumnWidth(1),
                      },
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: [
                        // Row 1
                        TableRow(
                          children: [
                            _buildCategoryCell(
                              iconPath: AppIcons.myFoodIcon,
                              displayText: 'Food & Dining',
                              backendValue: 'food_dining',
                              isIncome: false,
                              controller: addController,
                            ),
                            _buildCategoryCell(
                              iconPath:
                                  AppIcons
                                      .transpost, // Assuming AppIcons.transportationIcon
                              displayText: 'Transportation',
                              backendValue: 'transportation',
                              isIncome: false,
                              controller: addController,
                            ),
                            _buildCategoryCell(
                              iconPath:
                                  AppIcons
                                      .rentIcon, // Placeholder, use AppIcons.utilitiesIcon
                              displayText: 'Utilities',
                              backendValue: 'utilities',
                              isIncome: false,
                              controller: addController,
                            ),
                          ],
                        ),
                        // Row 2
                        TableRow(
                          children: [
                            _buildCategoryCell(
                              iconPath:
                                  AppIcons
                                      .healthIcon, // Assuming AppIcons.healthMedicalIcon
                              displayText: 'Health/Medical',
                              backendValue: 'health_medical',
                              isIncome: false,
                              controller: addController,
                            ),
                            _buildCategoryCell(
                              iconPath:
                                  AppIcons
                                      .socialIcon, // Assuming AppIcons.entertainmentIcon
                              displayText: 'Entertainment',
                              backendValue: 'entertainment',
                              isIncome: false,
                              controller: addController,
                            ),
                            _buildCategoryCell(
                              iconPath:
                                  AppIcons
                                      .gitIcon, // Placeholder, use AppIcons.shoppingIcon
                              displayText: 'Shopping',
                              backendValue: 'shopping',
                              isIncome: false,
                              controller: addController,
                            ),
                          ],
                        ),
                        // Row 3
                        TableRow(
                          children: [
                            _buildCategoryCell(
                              iconPath: AppIcons.educationIcon,
                              displayText: 'Education',
                              backendValue: 'education',
                              isIncome: false,
                              controller: addController,
                            ),
                            _buildCategoryCell(
                              iconPath:
                                  AppIcons
                                      .apprarelIcon, // Placeholder, use AppIcons.travelIcon
                              displayText: 'Travel',
                              backendValue: 'travel',
                              isIncome: false,
                              controller: addController,
                            ),
                            _buildCategoryCell(
                              iconPath:
                                  AppIcons
                                      .rentIcon, // Assuming AppIcons.rentMortgageIcon
                              displayText: 'Rent/Mortgage',
                              backendValue: 'rent_mortgage',
                              isIncome: false,
                              controller: addController,
                            ),
                          ],
                        ),
                        // Row 4
                        TableRow(
                          children: [
                            _buildCategoryCell(
                              iconPath:
                                  AppIcons
                                      .beautyIcon, // Assuming AppIcons.personalCareIcon
                              displayText: 'Personal Care',
                              backendValue: 'personal_care',
                              isIncome: false,
                              controller: addController,
                            ),
                            _buildCategoryCell(
                              // Placeholder, use AppIcons.insuranceIcon or a generic shield/security icon
                              iconPath:
                                  AppIcons
                                      .healthIcon, // Reusing health icon as placeholder
                              displayText: 'Insurance',
                              backendValue: 'insurance',
                              isIncome: false,
                              controller: addController,
                            ),
                            TableCell(
                              // For the "Other" button with Icon
                              child: InkWell(
                                onTap: () {
                                  addController.selectedExpenseCategory.value =
                                      'other';
                                  Get.back();
                                },
                                child: Padding(
                                  // Consistent padding
                                  padding: EdgeInsets.all(10.w),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 20.sp,
                                      ),
                                      SizedBox(width: 5.w),
                                      Text(
                                        'Other',
                                        style: AppStyles.mediumText.copyWith(
                                          color: Colors.white,
                                          fontSize: 12.sp, // Kept original size
                                        ),
                                        textAlign:
                                            TextAlign
                                                .center, // Ensure text is centered
                                      ),
                                    ],
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
              ),
            ],
          ),
        );
      },
    );
  }

  static showPayBottomSheet({required BuildContext context}) {
    final addController = Get.find<AddDataController>();
    return showModalBottomSheet(
      // Using showModalBottomSheet
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: 180.h, // Adjusted height for 1 row of 2 items
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
            // mainAxisSize: MainAxisSize.min, // Keep if height is dynamic
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
              Expanded(
                // Allow table to take available space
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 0.75.w,
                      color: AppStyles.greyColor,
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Table(
                    border: TableBorder(
                      verticalInside: BorderSide(
                        color: AppStyles.greyColor,
                        width: 0.75.w,
                      ),
                    ),
                    columnWidths: {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(1),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      TableRow(
                        children: [
                          _buildPayCell(
                            iconPath: AppIcons.myCashIcon,
                            displayText: 'Cash',
                            backendValue: 'cash',
                            controller: addController,
                          ),
                          _buildPayCell(
                            iconPath: AppIcons.cardIcon,
                            displayText: 'Card',
                            backendValue: 'card',
                            controller: addController,
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
      },
    );
  }

  static Widget _buildCategoryCell({
    required String iconPath,
    required String displayText,
    required String backendValue,
    required bool isIncome,
    required AddDataController controller,
  }) {
    return InkWell(
      onTap: () {
        if (isIncome) {
          controller.selectedIncomeCategory.value = backendValue;
        } else {
          controller.selectedExpenseCategory.value = backendValue;
        }
        Get.back();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 12.h,
          horizontal: 8.w,
        ), // Adjusted padding
        child: Column(
          // Changed to Column for better icon-text alignment if text wraps
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 24.w,
              height: 24.h,
            ), // Ensure icon is white if needed
            SizedBox(height: 6.h),
            Text(
              displayText,
              textAlign: TextAlign.center,
              style: AppStyles.mediumText.copyWith(
                color: Colors.white,
                fontSize: 11.sp, // Slightly smaller to fit more text
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildPayCell({
    required String iconPath,
    required String displayText,
    required String backendValue,
    required AddDataController controller,
  }) {
    return InkWell(
      onTap: () {
        controller.selectedPayMethod.value = backendValue;
        Get.back();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 12.h,
          horizontal: 8.w,
        ), // Adjusted padding
        child: Column(
          // Changed to Column
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 28.w,
              height: 28.h,
              colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
            SizedBox(height: 6.h),
            Text(
              displayText,
              textAlign: TextAlign.center,
              style: AppStyles.mediumText.copyWith(
                color: Colors.white,
                fontSize: 14.sp, // Slightly larger for pay methods
              ),
            ),
          ],
        ),
      ),
    );
  }
}
