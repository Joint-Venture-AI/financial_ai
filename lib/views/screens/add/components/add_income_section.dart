import 'package:financial_ai_mobile/core/utils/app_icons.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:financial_ai_mobile/views/screens/add/components/base_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddIncomeSection extends StatelessWidget {
  AddIncomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white, // White background
                borderRadius: BorderRadius.circular(16.r),
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
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Date',
                            style: AppStyles.mediumText.copyWith(
                              color: Colors.black,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),

                        Expanded(
                          flex: 2,
                          child: Text(
                            'Mar 10, 2025  01:20 pm',
                            style: AppStyles.smallText.copyWith(
                              color: Colors.black,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Amount',
                            style: AppStyles.mediumText.copyWith(
                              color: Colors.black,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),

                        Expanded(
                          flex: 2,

                          child: TextField(
                            decoration: InputDecoration(hintText: 'Amount'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Container(
              decoration: BoxDecoration(
                color: Colors.white, // White background
                borderRadius: BorderRadius.circular(16.r),
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
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Category',
                            style: AppStyles.mediumText.copyWith(
                              color: Colors.black,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: InkWell(
                            onTap:
                                () => BaseHelper.showIncomeBottomSheet(
                                  context: context,
                                ),
                            child: TextField(
                              decoration: InputDecoration(
                                enabled: false,
                                hintText: 'Add your purpose',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Account',
                            style: AppStyles.mediumText.copyWith(
                              color: Colors.black,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: InkWell(
                            onTap:
                                () => BaseHelper.showPayBottomSheet(
                                  context: context,
                                ),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Pay method',
                                enabled: false,
                                suffixIconConstraints: BoxConstraints(
                                  maxWidth: 24.w,
                                  maxHeight: 24.h,
                                ),
                                suffixIcon: SvgPicture.asset(
                                  width: 24.w,
                                  height: 24.h,
                                  AppIcons.dropDownMenu,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Note',
                            style: AppStyles.mediumText.copyWith(
                              color: Colors.black,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Tag your cost',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white, // White background
                borderRadius: BorderRadius.circular(16.r),
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
                padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 14.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Description',
                          style: AppStyles.mediumText.copyWith(
                            color: Colors.black,
                            fontSize: 16.sp,
                          ),
                        ),
                        const Spacer(),
                        SvgPicture.asset(
                          AppIcons.addImage,
                          color: Colors.black,
                          width: 24.w,
                          height: 24.h,
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    Divider(color: AppStyles.lightGreyColor, height: 1),
                    SizedBox(height: 8.h),
                    TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Add something you want',
                        hintStyle: AppStyles.smallText.copyWith(
                          color: AppStyles.lightGreyColor,
                          fontSize: 14.sp,
                        ),
                      ),
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
}
