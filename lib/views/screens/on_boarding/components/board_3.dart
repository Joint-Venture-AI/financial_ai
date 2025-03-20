import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Scaffold;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BoardThreeView extends StatelessWidget {
  const BoardThreeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Unlock the Power of Smart Money Management!',
            textAlign: TextAlign.center,
            style: AppStyles.largeText,
          ),
        ],
      ),
    );
  }
}
