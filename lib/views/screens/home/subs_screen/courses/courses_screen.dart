import 'package:financial_ai_mobile/controller/home/home_controller.dart';
import 'package:financial_ai_mobile/core/helper/widget_helper.dart';
import 'package:financial_ai_mobile/core/utils/app_icons.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:financial_ai_mobile/views/screens/home/subs_screen/courses/courses_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CoursesScreen extends StatelessWidget {
  CoursesScreen({super.key});

  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.bgColor,
      appBar: WidgetHelper.showAppBar(
        isBack: true,
        title: 'Courses',
        isCenter: false,
        showActions: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 48.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white, // White background
                        borderRadius: BorderRadius.circular(14.r),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 36,
                            color: Colors.black.withOpacity(
                              0.1,
                            ), // More visible shadow
                            offset: const Offset(
                              0,
                              4,
                            ), // Slight offset for better effect
                          ),
                        ],
                      ),
                      child: Center(
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                            ),
                            hintText: 'Search',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Container(
                    width: 48.w,
                    height: 48.h,
                    decoration: BoxDecoration(
                      color: AppStyles.lightGreyColor,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: SvgPicture.asset(
                        AppIcons.searchIcon,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: ListView.builder(
                itemCount: homeController.coursesModel.length,
                itemBuilder: (context, index) {
                  return CoursesItem(
                    course: homeController.coursesModel[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
