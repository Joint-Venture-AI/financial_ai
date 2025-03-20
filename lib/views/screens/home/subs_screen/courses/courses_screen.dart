import 'package:financial_ai_mobile/core/helper/widget_helper.dart';
import 'package:financial_ai_mobile/core/utils/app_icons.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

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
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25.h),
            Row(
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
                    padding: EdgeInsets.all(12),
                    child: SvgPicture.asset(
                      AppIcons.searchIcon,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(top: 5.h),
                    child: SizedBox(
                      width: 242.w,
                      height: 150.h,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.r),
                              child: Image.asset(
                                AppIcons.coverImage,
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
                            padding: EdgeInsets.symmetric(
                              vertical: 10.h,
                              horizontal: 10.w,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Upgrade ',
                                      style: AppStyles.mediumText.copyWith(
                                        color: AppStyles.primaryColor,
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                    Text(
                                      'Yourself Financially',
                                      style: AppStyles.mediumText.copyWith(
                                        color: Colors.white,
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  'Master budgeting, investing & money management with expert courses!',
                                  style: AppStyles.smallText.copyWith(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                  ),
                                  maxLines:
                                      2, // Added maxLines and overflow properties
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const Spacer(),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12.w,
                                      vertical: 8.h,
                                    ), //responsive padding
                                    textStyle: AppStyles.mediumText.copyWith(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  child: Text('Enroll Now'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
