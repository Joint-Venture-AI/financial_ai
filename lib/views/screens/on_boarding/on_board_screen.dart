import 'package:dots_indicator/dots_indicator.dart';
import 'package:financial_ai_mobile/controller/welcome_controller.dart';
import 'package:financial_ai_mobile/core/utils/app_routes.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:financial_ai_mobile/views/glob_widgets/our_gob_text_button.dart';
import 'package:financial_ai_mobile/views/screens/auth/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OnBoarding extends StatelessWidget {
  OnBoarding({Key? key}) : super(key: key);

  final welcomeController = Get.find<WelcomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Stack(
          children: [
            PageView(
              controller: welcomeController.pageController,
              scrollDirection: Axis.horizontal,
              children: welcomeController.boadring_views,
              onPageChanged: (index) {
                welcomeController.currentIndex.value = index;
              },
            ),
            Positioned(
              bottom: 20.h,
              left: 0.w,
              right: 0.w,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 120.w,
                      height: 50.h,
                      child: DotsIndicator(
                        dotsCount: welcomeController.boadring_views.length,
                        position: welcomeController.currentIndex.toDouble(),
                        decorator: DotsDecorator(
                          color: AppStyles.lightGreyColor,
                          activeColor: AppStyles.primaryColor,
                          size: const Size.square(9.0),
                          activeSize: const Size(18.0, 9.0),
                          activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    GlobTextButton(
                      buttonText:
                          welcomeController.currentIndex.value <
                                  welcomeController.boadring_views.length - 1
                              ? 'Next'
                              : 'Get Started',
                      onTap: () {
                        if (welcomeController.currentIndex.value <
                            welcomeController.boadring_views.length - 1) {
                          welcomeController.pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        } else {
                          Get.offAll(
                            SignUpScreen(),
                          ); // Navigate to SignUpScreen
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
