import 'package:financial_ai_mobile/controller/auth_controller.dart';
import 'package:financial_ai_mobile/core/helper/widget_helper.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:financial_ai_mobile/views/glob_widgets/custom_text_feild.dart';
import 'package:financial_ai_mobile/views/glob_widgets/our_gob_text_button.dart';
import 'package:financial_ai_mobile/views/screens/auth/verify_otp_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ForgetPassScreen extends StatelessWidget {
  ForgetPassScreen({super.key});
  final authContrller = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.bgColor,
      appBar: WidgetHelper.showAppBar(
        title: 'Forget Password',
        isCenter: false,
        isBack: true,
        showActions: false,
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.h),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Input your email address to get OTP',
                    style: AppStyles.smallText.copyWith(
                      color: Colors.black,
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 20.h),

                  Text('Email', style: AppStyles.mediumText),
                  SizedBox(height: 5.h),

                  CustomTextFeild(
                    hintText: 'Enter your email',
                    isObsecure: false,
                    type: TextInputType.text,
                    controller: authContrller.emailController,
                  ),
                ],
              ),
            ),
            SizedBox(height: 180.h),
            GlobTextButton(
              buttonText: 'Continue',
              onTap: () => Get.to(VerifyOtpScreen()),
            ),
            SizedBox(height: 80.h),
          ],
        ),
      ),
    );
  }
}
