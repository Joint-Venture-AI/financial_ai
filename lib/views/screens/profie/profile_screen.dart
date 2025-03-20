
import 'package:financial_ai_mobile/controller/profile_controller.dart';
import 'package:financial_ai_mobile/core/helper/widget_helper.dart';

import 'package:financial_ai_mobile/core/utils/app_icons.dart';
import 'package:financial_ai_mobile/core/utils/app_routes.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';

import 'package:financial_ai_mobile/views/screens/profie/component/profile_header.dart';

import 'package:financial_ai_mobile/views/screens/profie/upgrade/components/upgrade_widget_helper.dart';
import 'package:financial_ai_mobile/views/screens/profie/upgrade/upgrade_sceen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppStyles.bgColor,
        appBar: profileAppBar("Profile"),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            children: [
              // ========>>>>>>> Image selector <<<<<<<<==========
              Obx(() {
                final image = controller.pickedImage.value;
                return Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.pickImage();
                      },
                      child: CircleAvatar(
                        radius: 70,

                        child:
                            image != null
                                ? ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.file(
                                    image,
                                    fit: BoxFit.cover,
                                    height: 140.h,
                                    width: 140.w,
                                  ),
                                )
                                : Image.asset(
                                  "assets/images/profile_image.png",
                                ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.w,
                          vertical: 5.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppStyles.primaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(Icons.edit, color: Colors.white),
                      ),
                    ),
                  ],
                );
              }),
              // ========>>>>>>> Name Email <<<<<<<<==========
              Text(
                "Daniel Austin",
                style: AppStyles.mediumText.copyWith(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "daniel_austin@yourdomain.com",
                style: AppStyles.mediumText.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppStyles.greyColor,
                ),
              ),
              Divider(),
              // ========>>>>>>> Profile Options <<<<<<<<==========
              _buildProfileOption(
                icon: Icon(Icons.person_3_outlined),
                title: "Edit Profile",
                ontap: () {
                  Get.toNamed(AppRoutes.editProfile);
                },
              ),
              _buildProfileOption(
                icon: SvgPicture.asset(AppIcons.crownIcon),
                title: "Upgrade Plan",
                ontap: () => Get.to(UpgradeScreen()),
              ),
              _buildProfileOption(
                icon: SvgPicture.asset(AppIcons.lockIcon),
                title: "Privacy Policy",
                ontap: () {
                  Get.toNamed(AppRoutes.privacyPolicy);
                },
              ),
              _buildProfileOption(
                icon: SvgPicture.asset(
                  AppIcons.logOut,
                  color: AppStyles.redColor,
                ),
                title: "Logout",
                hasLast: false,
                ontap: () => UpgradeWidgetHelper.showLogOutSheet(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOption({icon, title, ontap, hasLast = true}) {
    return GestureDetector(
      onTap: ontap,
      child: ListTile(
        leading: icon,
        title: Text(
          title,
          style: AppStyles.mediumText.copyWith(
            fontSize: 16.sp,
            color: hasLast ? Colors.black : AppStyles.redColor,
          ),
        ),
        trailing: hasLast ? Icon(Icons.chevron_right_outlined, size: 30) : null,
      ),
    );
  }
}
