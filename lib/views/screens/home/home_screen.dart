import 'package:financial_ai_mobile/core/utils/app_icons.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppStyles.bgColor ?? Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 65.w,
                        height: 32.h,
                        child: Image.asset(
                          AppIcons.appBrandLogo,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.error);
                          },
                        ),
                      ),
                      const Spacer(),
                      SvgPicture.asset(
                        AppIcons.bellIcon,
                        width: 24.w,
                        height: 24.h,
                        color: Colors.black,
                        placeholderBuilder:
                            (context) => const Icon(Icons.error),
                      ),
                      SizedBox(width: 10.w),
                      SvgPicture.asset(
                        AppIcons.profileIcon,
                        width: 24.w,
                        height: 24.h,
                        color: Colors.black,
                        placeholderBuilder:
                            (context) => const Icon(Icons.error),
                      ),
                      SizedBox(width: 10.w),
                    ],
                  ),
                  SizedBox(height: 26.h),
                  header_body_section(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget header_body_section() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // White background
        borderRadius: BorderRadius.circular(32.r),
        boxShadow: [
          BoxShadow(
            blurRadius: 36,
            color: Colors.black.withOpacity(0.1), // More visible shadow
            offset: const Offset(0, 4), // Slight offset for better effect
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28.r),
                gradient: LinearGradient(
                  colors: [
                    AppStyles.primaryColor ?? Colors.blue,
                    AppStyles.primarySecondColor ?? Colors.green,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'USD',
                      style:
                          AppStyles.smallText?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ) ??
                          const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'Available Balance',
                      style:
                          AppStyles.smallText?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                          ) ??
                          const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      '\$10,000',
                      style:
                          AppStyles.smallText?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 40.sp,
                          ) ??
                          const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 40,
                          ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'Today (-\$140)',
                      style:
                          AppStyles.smallText?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                          ) ??
                          const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.h),
            SizedBox(
              height: 60.h,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Income',
                          style:
                              AppStyles.smallText?.copyWith(
                                color: Colors.black,
                              ) ??
                              const TextStyle(color: Colors.black),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          '\$32,000.00',
                          style:
                              AppStyles.smallText?.copyWith(
                                color: Colors.green,
                              ) ??
                              const TextStyle(color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                  VerticalDivider(
                    width: 1,
                    thickness: 1,
                    color: AppStyles.lightGreyColor ?? Colors.grey,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Expense',
                          style:
                              AppStyles.smallText?.copyWith(
                                color: Colors.black,
                              ) ??
                              const TextStyle(color: Colors.black),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          '\$22,000.00',
                          style:
                              AppStyles.smallText?.copyWith(
                                color: Colors.red,
                              ) ??
                              const TextStyle(color: Colors.red),
                        ),
                      ],
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
