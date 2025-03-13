import 'package:financial_ai_mobile/controller/auth_controller.dart';
import 'package:financial_ai_mobile/core/helper/widget_helper.dart';
import 'package:financial_ai_mobile/core/utils/app_icons.dart';
import 'package:financial_ai_mobile/core/utils/app_routes.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:financial_ai_mobile/views/glob_widgets/custom_text_feild.dart';
import 'package:financial_ai_mobile/views/glob_widgets/our_gob_text_button.dart';
import 'package:financial_ai_mobile/views/screens/auth/forget_pass_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class PassSetScreen extends StatelessWidget {
  PassSetScreen({super.key});
  final authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetHelper.showAppBar(
        title: 'Password Set',
        isCenter: false,
        isBack: true,
      ),
      backgroundColor: AppStyles.bgColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Create your new password',
                  style: AppStyles.smallText.copyWith(color: Colors.black),
                ),
                SizedBox(height: 10.h),
                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text('New Password', style: AppStyles.mediumText),
                      SizedBox(height: 5.h),

                      CustomTextFeild(
                        hintText: 'Enter your password',
                        type: TextInputType.text,
                        isObsecure: true,
                        controller: authController.passController,
                      ),

                      SizedBox(height: 10.h),
                      Text('Re-Type Password', style: AppStyles.mediumText),
                      SizedBox(height: 5.h),

                      CustomTextFeild(
                        hintText: 'Re-type your password',
                        type: TextInputType.text,
                        isObsecure: true,
                        controller: authController.passController,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32.h),

                GlobTextButton(buttonText: 'Continue', onTap: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
