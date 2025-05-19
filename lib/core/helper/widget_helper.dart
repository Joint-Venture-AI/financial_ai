import 'package:financial_ai_mobile/core/utils/app_icons.dart';
import 'package:financial_ai_mobile/core/utils/app_routes.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:financial_ai_mobile/views/screens/notification/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class WidgetHelper {
  static showAppBar({
    required bool isBack,
    required String title,
    required bool isCenter,
    required bool showActions,
  }) {
    return AppBar(
      leading:
          isBack
              ? IconButton(
                onPressed: () => Get.back(),
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.black,
                ),
              )
              : SizedBox(),

      title: Text(
        title,
        style: AppStyles.mediumText.copyWith(
          color: Colors.black,
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      centerTitle: isCenter,
      actions:
          showActions
              ? [
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
              ]
              : [],
    );
  }

  static void showToast({required bool isSuccess, required String message}) {
    Get.snackbar(
      isSuccess ? 'Sucess' : 'Failed',
      message,
      backgroundColor: isSuccess ? Colors.green : Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      borderRadius: 30,
    );
  }
}
