import 'package:financial_ai_mobile/core/utils/app_icons.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:financial_ai_mobile/views/glob_widgets/custom_button.dart';
import 'package:financial_ai_mobile/views/glob_widgets/gradiunt_global_button.dart';
import 'package:financial_ai_mobile/views/screens/profie/upgrade/add_card_screen.dart';
import 'package:financial_ai_mobile/views/screens/profie/upgrade/payment_method_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart' show Get;

class UpgradeWidgetHelper {
  static showPayBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows full-screen bottom sheet
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.45, // Makes bottom sheet take 45% of screen height
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// **Price & Discount Row**
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '\$20.00',
                              style: AppStyles.mediumText.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp,
                              ),
                            ),
                            Text(
                              ' /Month',
                              style: AppStyles.mediumText.copyWith(
                                color: Colors.grey,
                                fontSize: 16.sp,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '\$120.00 per year, billed yearly',
                          style: AppStyles.smallText.copyWith(
                            color: AppStyles.greyColor,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppStyles.primaryColor,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        'Save 20%',
                        style: AppStyles.smallText.copyWith(
                          color: Colors.white,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 24.h),

                /// **Pay With Section**
                Text(
                  'Pay with',
                  style: AppStyles.mediumText.copyWith(
                    color: AppStyles.greyColor,
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 10.h),

                /// **Saved Card**
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: AppStyles.lightGreyColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppIcons.masterCardIcon,
                        width: 30.w,
                        height: 30.h,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        '**** 2029',
                        style: AppStyles.smallText.copyWith(
                          fontSize: 16.sp,
                          color: Colors.black,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 18.sp,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),

                /// **Add Card Button**
                SizedBox(height: 10.h),
                InkWell(
                  onTap: () {
                    // Handle add card logic
                    Get.to(AddCardScreen());
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppStyles.lightGreyColor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: AppStyles.greyColor,
                          size: 20.sp,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Add Card',
                          style: AppStyles.smallText.copyWith(
                            fontSize: 14.sp,
                            color: AppStyles.greyColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 40.h),
                GradiuntGlobalButton(
                  text: 'Pay Now',
                  onTap: () => Get.to(PaymentMethodScreen()),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static showLogOutSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: ((context) {
        return Container(
          width: double.infinity,
          height: 250.h,
          decoration: BoxDecoration(
            color: Colors.white,

            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            child: Column(
              children: [
                Container(
                  width: 38.w,
                  height: 3.h,
                  decoration: BoxDecoration(color: AppStyles.lightGreyColor),
                ),
                SizedBox(height: 30.h),
                Text(
                  'Logout',
                  style: AppStyles.largeText.copyWith(
                    color: AppStyles.redColor,
                    fontSize: 24.sp,
                  ),
                ),
                SizedBox(height: 10.h),
                const Divider(),
                SizedBox(height: 15.h),
                Text(
                  'Are you sure want to logout?',
                  style: AppStyles.largeText.copyWith(
                    color: Colors.black,
                    fontSize: 20.sp,
                  ),
                ),
                SizedBox(height: 20.h),

                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: 'Cancel',
                        isOutline: true,
                        onTap: () {},
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Expanded(
                      child: CustomButton(
                        text: 'Yes, Logout',
                        isOutline: false,
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
