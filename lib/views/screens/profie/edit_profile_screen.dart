import 'package:financial_ai_mobile/controller/profile_controller.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:financial_ai_mobile/views/glob_widgets/custom_text_feild.dart';
import 'package:financial_ai_mobile/views/screens/profie/component/custom_date_input.dart';
import 'package:financial_ai_mobile/views/screens/profie/component/profile_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final ProfileController controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.bgColor,
      appBar: profileAppBar("Edit Profile"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: SingleChildScrollView(
          child: Column(
            spacing: 20.h,
            children: [
              // =========>>>>>>>> Full Name <<<<<<<<==========
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Full Name", style: AppStyles.mediumText),
                  SizedBox(height: 8.h),
                  CustomTextFeild(
                    hintText: "Enter your Full Name...",
                    isObsecure: false,
                    type: TextInputType.text,
                    controller: controller.fullNameController,
                  ),
                ],
              ),
              // =========>>>>>>>> Nick Name <<<<<<<<==========
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Nickname", style: AppStyles.mediumText),
                  SizedBox(height: 8.h),
                  CustomTextFeild(
                    hintText: "Enter your Nickname...",
                    isObsecure: false,
                    type: TextInputType.text,
                    controller: controller.nickNameController,
                  ),
                ],
              ),
              // =========>>>>>>>> DOB <<<<<<<<==========
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Date of Birth", style: AppStyles.mediumText),
                  SizedBox(height: 8.h),
                  DateInput(
                    dateController: controller.dobController,
                    icon: null,
                    hintText: "Date of Birth",
                  ),
                ],
              ),
              // =========>>>>>>>> Email <<<<<<<<==========
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Email", style: AppStyles.mediumText),
                  SizedBox(height: 8.h),
                  CustomTextFeild(
                    hintText: "Enter your Email...",
                    isObsecure: false,
                    type: TextInputType.text,
                    controller: controller.emailController,
                  ),
                ],
              ),
              // =========>>>>>>>> Phone <<<<<<<<==========
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Phone", style: AppStyles.mediumText),
                  SizedBox(height: 8.h),
                  CustomTextFeild(
                    hintText: "Enter your Phone...",
                    isObsecure: false,
                    type: TextInputType.text,
                    controller: controller.phoneController,
                  ),
                ],
              ),
              // =========>>>>>>>> Address <<<<<<<<==========
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Address", style: AppStyles.mediumText),
                  SizedBox(height: 8.h),
                  CustomTextFeild(
                    hintText: "Enter your Address...",
                    isObsecure: false,
                    type: TextInputType.text,
                    controller: controller.addressController,
                  ),
                ],
              ),
              // =========>>>>>>>> Update Button <<<<<<<<==========
              ClipRRect(
                borderRadius: BorderRadius.circular(100.r),
                child: SizedBox(
                  height: 56,
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text("Update"),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
