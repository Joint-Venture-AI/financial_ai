import 'package:financial_ai_mobile/controller/add_data_controller/add_data_controller.dart';
import 'package:financial_ai_mobile/core/utils/app_icons.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:financial_ai_mobile/views/screens/add/components/base_helper.dart';
import 'package:financial_ai_mobile/views/screens/add/components/image_chosed_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

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
                          child: Obx(() {
                            return InkWell(
                              onTap: () {
                                addController.pickDateTime(context);
                              },
                              child: Text(
                                addController.formattedDateTime,
                                style: AppStyles.smallText.copyWith(
                                  color: Colors.black,
                                  fontSize: 16.sp,
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
                            controller: addController.amountController,
                            keyboardType: TextInputType.number,
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
                        Obx(() {
                          return Expanded(
                            flex: 2,
                            child: InkWell(
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
                            ),
                          );
                        }),
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
                            controller: addController.noteController,
                            keyboardType: TextInputType.text,
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

                    Obx(() {
                      return addController
                              .images
                              .isNotEmpty // Check if list is not empty
                          ? SingleChildScrollView(
                            // Wrap with SingleChildScrollView
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children:
                                  addController.images.map((image) {
                                    final index = addController.images.indexOf(
                                      image,
                                    );
                                    return Padding(
                                      padding: EdgeInsets.only(
                                        right: 8.w,
                                      ), // Add some spacing
                                      child: ImageChosedItem(
                                        onDelete:
                                            () => addController.removeImage(
                                              index,
                                            ),
                                        imageFile: image,
                                      ),
                                    );
                                  }).toList(),
                            ),
                          )
                          : const SizedBox(); // Return an empty SizedBox if no images
                    }),
                    SizedBox(height: 5.h),
                    Divider(color: AppStyles.lightGreyColor, height: 1),
                    SizedBox(height: 8.h),
                    TextField(
                      controller: addController.descriptionController,
                      maxLines: 3,
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
            Obx(() {
              return SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await addController.addIncomeData(false);
                  },
                  child:
                      addController.isLoading.value
                          ? CupertinoActivityIndicator(color: Colors.white)
                          : Text(
                            'Add Expense',
                            style: AppStyles.mediumText.copyWith(
                              color: Colors.white,
                              fontSize: 16.sp,
                            ),
                          ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
