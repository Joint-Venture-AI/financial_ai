import 'package:financial_ai_mobile/controller/auth_controller.dart';
import 'package:financial_ai_mobile/core/helper/widget_helper.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:financial_ai_mobile/views/glob_widgets/custom_text_feild.dart';
import 'package:financial_ai_mobile/views/glob_widgets/our_gob_text_button.dart';
import 'package:financial_ai_mobile/views/screens/auth/pass_set_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class VerifyOtpScreen extends StatelessWidget {
  final String email;
  final bool isForgetPass;
  VerifyOtpScreen({super.key, required this.email, required this.isForgetPass});
  final authContrller = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.bgColor,
      appBar: WidgetHelper.showAppBar(
        title: 'OTP Verify',
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
                    'Code has been send to $email',
                    style: AppStyles.smallText.copyWith(
                      color: Colors.black,
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  SizedBox(
                    width: double.infinity,
                    child: OtpTextField(
                      fieldHeight: 61.h,
                      fieldWidth: 71.w,
                      numberOfFields: 4,
                      borderColor: Color.fromARGB(255, 34, 31, 41),
                      //set to true to show as box or false to show as dash
                      showFieldAsBox: true,
                      //runs when a code is typed in
                      onCodeChanged: (String code) {
                        //handle validation or checks here
                      },
                      //runs when every textfield is filled
                      onSubmit: (String verificationCode) async {
                        authContrller.otpController.text = verificationCode;
                        await authContrller.verifyOtp(
                          email,
                          verificationCode,
                          isForgetPass,
                        );
                      }, // end onSubmit
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 180.h),
            SizedBox(
              width: double.infinity,
              child: Obx(() {
                return ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      authContrller.otpController.text.length == 4
                          ? AppStyles.primaryColor
                          : Color.fromARGB(255, 34, 31, 41),
                    ),
                  ),
                  onPressed: () async {
                    await authContrller.verifyOtp(
                      email,
                      authContrller.otpController.text.trim(),
                      isForgetPass,
                    );
                  },
                  child:
                      authContrller.isLoading.value
                          ? CupertinoActivityIndicator()
                          : Text('Continue'),
                );
              }),
            ),
            SizedBox(height: 80.h),
          ],
        ),
      ),
    );
  }
}
