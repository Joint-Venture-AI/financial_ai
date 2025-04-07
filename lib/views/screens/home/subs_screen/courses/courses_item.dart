import 'package:financial_ai_mobile/controller/home/home_controller.dart';
import 'package:financial_ai_mobile/core/models/courses_model.dart';
import 'package:financial_ai_mobile/core/utils/api_endpoint.dart';
import 'package:financial_ai_mobile/core/utils/app_icons.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CoursesItem extends StatelessWidget {
  final Course course;
  const CoursesItem({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());

    return Padding(
      padding: EdgeInsets.only(top: 8.w, left: 8.w, right: 8.w),
      child: SizedBox(
        width: 242.w,
        height: 150.h,
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.network(
                  '${ApiEndpoint.mainBase}${course.image}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  gradient: LinearGradient(
                    colors: [Colors.black, Colors.transparent],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        course.title,
                        style: AppStyles.mediumText.copyWith(
                          color: Colors.white,
                          fontSize: 15.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    course.description,
                    style: AppStyles.smallText.copyWith(
                      color: Colors.white,
                      fontSize: 12.sp,
                    ),
                    maxLines: 2, // Added maxLines and overflow properties
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          12,
                        ), // Set the radius here
                      ),
                      backgroundColor:
                          AppStyles
                              .primaryColor, // Set background color if needed
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ), // Adjust padding if needed
                    ),
                    onPressed: () async {
                      await homeController.launchCourseUrl(course.url);
                    },
                    child: Text(
                      'Enroll Now',
                      style: AppStyles.mediumText.copyWith(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
