import 'package:financial_ai_mobile/controller/auth_controller.dart';
import 'package:financial_ai_mobile/core/utils/app_icons.dart';
import 'package:financial_ai_mobile/core/utils/app_routes.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:financial_ai_mobile/views/glob_widgets/custom_text_feild.dart';
import 'package:financial_ai_mobile/views/glob_widgets/our_gob_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
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
                  key: _formKey,
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.h),
                      Text('Email', style: AppStyles.mediumText),
                      SizedBox(height: 5.h),
                      CustomTextFeild(
                        isObsecure: false,
                        hintText: 'Enter your email',
                        type: TextInputType.emailAddress,
                        controller: authController.emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!value.contains('@')) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.h),
                      Text('Password', style: AppStyles.mediumText),
                      SizedBox(height: 5.h),
                      CustomTextFeild(
                        hintText: 'Enter your password',
                        type: TextInputType.text,
                        isObsecure: true,
                        controller: authController.passController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
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
                GlobTextButton(
                  buttonText: 'SignUp',
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      // Form is valid, proceed with sign-up logic
                      if (authController.isChecked.value) {
                        // Agreement to terms is checked
                        // Implement signup logic here (e.g., API call)
                        print('Signup successful!');
                        Get.toNamed(AppRoutes.signIn); // Example navigation
                      } else {
                        // Show an error if the agreement is not checked
                        Get.snackbar(
                          'Error',
                          'Please agree to the processing of Personal data',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      }
                    }
                  },
                ),
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
