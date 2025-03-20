import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppStyles extends GetxController {
  ///colors
  static Color primaryColor = Color(0xff1F9A90);
  static Color primarySecondColor = Color(0xff0A3431);

  static Color secondaryColor = Color(0xff0C0C0C);
  static Color lightGreyColor = Color(0xffE0E0E0);
  static Color bgColor = Color(0xffFFFFFF);
  static Color greyColor = Color(0xff707070);
  static Color simpleGrey = Color(0xffF5F5F5);
  static Color filledColor = Color(0xffF5F5F5);
  static Color orangeColor = Color(0xffF38042);
  static Color redColor = Color(0xffFF2C2C);
  static Color primaryTransparent = Color(0xff95EAE3);
  static Color darkGreyColor = Color(0xff252525);
  static Color pinkColor = Color(0xffFF008C);
  static Color purpleColor = Color(0xff6C0BD4);
  static Color simpleBlueColor = Color(0xff00EAEA);
  static Color blueColor = Color(0xff428EFF);
  static Color simpleGreenColor = Color(0xffC8F4F0);

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
    color: Colors.black,
    fontWeight: FontWeight.w400,
  );
}
