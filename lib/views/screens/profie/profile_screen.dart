import 'package:financial_ai_mobile/core/utils/app_icons.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppStyles.bgColor,
        appBar: AppBar(
          backgroundColor: AppStyles.bgColor,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.chevron_left),
          ),
          title: Text("Profile", style: AppStyles.mediumText),
          actions: [Icon(Icons.more_vert)],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            children: [
              // ========>>>>>>> Image selector <<<<<<<<==========
              Stack(
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage(
                      "assets/images/profile_image.png",
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
              ),
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
                ontap: () {},
              ),
              _buildProfileOption(
                icon: SvgPicture.asset(AppIcons.crownIcon),
                title: "Upgrade Plan",
                ontap: () {},
              ),
              _buildProfileOption(
                icon: SvgPicture.asset(AppIcons.lockIcon),
                title: "Privacy Policy",
                ontap: () {},
              ),
              _buildProfileOption(
                icon: SvgPicture.asset(
                  AppIcons.logOut,
                  color: AppStyles.redColor,
                ),
                title: "Logout",
                hasLast: false,
                ontap: () {},
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
