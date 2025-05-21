import 'package:financial_ai_mobile/controller/welcome_controller.dart';
import 'package:financial_ai_mobile/core/services/pref_helper.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:financial_ai_mobile/core/utils/utils.dart';
import 'package:financial_ai_mobile/views/glob_widgets/our_gob_text_button.dart';
import 'package:financial_ai_mobile/views/screens/on_boarding/user_info/components/user_chose_item.dart';
import 'package:financial_ai_mobile/views/screens/on_boarding/user_info/user_financial_input_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class UserChoseScreen extends StatelessWidget {
  UserChoseScreen({super.key});
  final welcomeController = Get.find<WelcomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.bgColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 35.h),
              Text(
                'Set Up Your Finances',
                style: AppStyles.smallText.copyWith(
                  color: Colors.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                'Provide your financial details to get personalized insights and better money management.',
                style: AppStyles.smallText.copyWith(color: AppStyles.greyColor),
              ),
              SizedBox(height: 40.h),
              Text(
                'Your Profession',
                style: AppStyles.smallText.copyWith(
                  color: Colors.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Obx(() {
                return Column(
                  children: List.generate(welcomeController.userList.length, (
                    index,
                  ) {
                    final user = welcomeController.userList[index]['title'];
                    final icon = welcomeController.userList[index]['icon'];

                    return UserChoseItem(
                      onTap: () {
                        welcomeController.selectedUser.value = user;
                      },
                      isSelected: user == welcomeController.selectedUser.value,
                      title: user,
                      iconPath: icon,
                    );
                  }),
                );
              }),
              SizedBox(height: 40.h),
              GlobTextButton(
                buttonText: 'Next',
                onTap: () async {
                  await PrefHelper.setString(
                    Utils.PROFESSION,
                    welcomeController.selectedUser.value,
                  );
                  printInfo(
                    info:
                        'User Profession: ${welcomeController.selectedUser.value}',
                  );
                  // Navigate to the next screen
                  Get.to(() => UserFinancialInputScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
