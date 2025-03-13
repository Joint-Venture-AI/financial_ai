import 'package:financial_ai_mobile/controller/auth_controller.dart';
import 'package:financial_ai_mobile/core/utils/app_icons.dart';
import 'package:financial_ai_mobile/core/utils/app_routes.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:financial_ai_mobile/views/glob_widgets/custom_text_feild.dart';
import 'package:financial_ai_mobile/views/glob_widgets/our_gob_text_button.dart';
import 'package:financial_ai_mobile/views/screens/auth/sign_in_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.bgColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Create your Account', style: AppStyles.largeText),
                SizedBox(height: 10.h),
                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text('Name', style: AppStyles.mediumText),
                      SizedBox(height: 5.h),

                      CustomTextFeild(
                        isObsecure: false,

                        hintText: 'Enter your name',
                        type: TextInputType.text,
                        controller: authController.nameController,
                      ),
                      SizedBox(height: 10.h),
                      Text('Email', style: AppStyles.mediumText),
                      SizedBox(height: 5.h),

                      CustomTextFeild(
                        isObsecure: false,
                        hintText: 'Enter your email',
                        type: TextInputType.text,
                        controller: authController.emailController,
                      ),

                      SizedBox(height: 10.h),
                      Text('Password', style: AppStyles.mediumText),
                      SizedBox(height: 5.h),

                      CustomTextFeild(
                        hintText: 'Enter your password',
                        type: TextInputType.text,
                        isObsecure: true,
                        controller: authController.passController,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 5.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Obx(() {
                      return Checkbox(
                        value: authController.isChecked.value,
                        onChanged: (v) {
                          authController.isChecked.value = v!;
                        },
                      );
                    }),

                    Expanded(
                      child: Text(
                        'I agree to the proccessing of Personal date',
                        style: AppStyles.smallText.copyWith(
                          color: AppStyles.greyColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                GlobTextButton(buttonText: 'SignUp', onTap: () {}),
                SizedBox(height: 32.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have a account?',
                      style: AppStyles.smallText.copyWith(
                        color: AppStyles.greyColor,
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    InkWell(
                      onTap: () => Get.toNamed(AppRoutes.signIn),
                      child: Text(
                        'SignIn',
                        style: AppStyles.smallText.copyWith(
                          color: AppStyles.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
