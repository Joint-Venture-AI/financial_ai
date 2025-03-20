import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final bool isOutline;
  final VoidCallback onTap;
  const CustomButton({
    super.key,
    required this.text,
    required this.isOutline,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isOutline ? Colors.transparent : AppStyles.primaryColor,
        borderRadius: BorderRadius.circular(100.r),
        border: Border.all(width: 1, color: AppStyles.primaryColor),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Text(
            text,
            style: AppStyles.mediumText.copyWith(
              color: isOutline ? AppStyles.primaryColor : Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
