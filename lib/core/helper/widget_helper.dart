import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class WidgetHelper {
  static showAppBar({
    required String title,
    required bool isCenter,
    required bool isBack,
  }) {
    return AppBar(
      surfaceTintColor: Colors.white,
      leading:
          isBack
              ? IconButton(
                onPressed: () => Get.back(),
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.black,
                ),
              )
              : null,
      title: Text(
        title,
        style: AppStyles.mediumText.copyWith(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18.sp,
        ),
      ),
      centerTitle: isCenter,
    );
  }
}
