import 'package:financial_ai_mobile/controller/add_data_controller/add_data_controller.dart';
import 'package:financial_ai_mobile/core/utils/app_icons.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:financial_ai_mobile/views/glob_widgets/gradiunt_global_button.dart';
import 'package:financial_ai_mobile/views/screens/add/components/base_helper.dart';
import 'package:financial_ai_mobile/views/screens/add/components/image_chosed_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AddExpenseSection extends StatelessWidget {
  AddExpenseSection({super.key});
  final addController = Get.find<AddDataController>();
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
                          child: Obx(() {
                            return InkWell(
                              onTap:
                                  () => BaseHelper.showExpenseBottomSheet(
                                    context: context,
                                  ),
                              child: TextField(
                                decoration: InputDecoration(
                                  enabled: false,
                                  hintText:
                                      addController
                                          .selectedExpenseCategory
                                          .value,
                                ),
                              ),
                            );
                          }),
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
                          child: Obx(() {
                            return InkWell(
                              onTap:
                                  () => BaseHelper.showPayBottomSheet(
                                    context: context,
                                  ),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText:
                                      addController.selectedPayMethod.value,
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
                            );
                          }),
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
                        InkWell(
                          onTap: () async {
                            await addController.imageChoser();
                          },
                          child: SvgPicture.asset(
                            AppIcons.addImage,
                            color: Colors.black,
                            width: 24.w,
                            height: 24.h,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    Divider(color: AppStyles.lightGreyColor, height: 1),
                    SizedBox(height: 5.h),
                    Obx(() {
                      return addController.images.isNotEmpty
                          ? SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children:
                                  addController.images.map((image) {
                                    final index = addController.images.indexOf(
                                      image,
                                    );
                                    return Padding(
                                      padding: EdgeInsets.only(right: 8.w),
                                      child: ImageChosedItem(
                                        imageFile: image,
                                        onDelete: () {
                                          addController.removeImage(index);
                                        },
                                      ),
                                    );
                                  }).toList(),
                            ),
                          )
                          : SizedBox();
                    }),
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
            SizedBox(height: 15.h),
            GradiuntGlobalButton(text: 'Save', onTap: () {}),
          ],
        ),
      ),
    );
  }
}
