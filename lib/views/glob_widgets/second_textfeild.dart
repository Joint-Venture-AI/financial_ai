import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SecondTextfeild extends StatelessWidget {
  final String hintText;
  const SecondTextfeild({super.key, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        fillColor: AppStyles.filledColor,
        filled: true,
        hintStyle: AppStyles.smallText.copyWith(
          color: AppStyles.greyColor,
          fontSize: 12.sp,
        ),

        border: InputBorder.none,
        hintText: hintText,
      ),
    );
  }
}
