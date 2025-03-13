import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppStyles extends GetxController {
  ///colors
  static Color primaryColor = Color(0xff1F9A90);
  static Color secondaryColor = Color(0xff0C0C0C);
  static Color lightGreyColor = Color(0xffE0E0E0);
  static Color bgColor = Color(0xffFFFFFF);
  static Color greyColor = Color(0xff707070);

  ///text_styles
  static TextStyle largeText = TextStyle(
    fontSize: 40.sp,
    color: Colors.black,
    fontWeight: FontWeight.w800,
  );

  static TextStyle mediumText = TextStyle(
    fontSize: 18.sp,
    color: Colors.black,
    fontWeight: FontWeight.w500,
  );

  static TextStyle smallText = TextStyle(
    fontSize: 16.sp,
    color: Colors.white,
    fontWeight: FontWeight.w400,
  );
}
