import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GlobTextButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  const GlobTextButton({
    super.key,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          ),
          backgroundColor: WidgetStatePropertyAll(AppStyles.primaryColor),
          foregroundColor: WidgetStatePropertyAll(Colors.white),
        ),
        onPressed: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Center(child: Text(buttonText, style: AppStyles.smallText)),
        ),
      ),
    );
  }
}
