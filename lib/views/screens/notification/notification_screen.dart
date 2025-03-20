import 'package:financial_ai_mobile/core/utils/app_icons.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Notification',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: ListView(
          children: [
            /// **Today Section**
            Text(
              'Today',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.teal.shade700,
              ),
            ),
            SizedBox(height: 10.h),
            _notificationCard(
              icon: AppIcons.health2dIcon,

              title: 'Healthcare Limit Exceeded!',
              subtitle:
                  'You’ve exceeded your healthcare budget for this month!',
            ),
            _notificationCard(
              icon: AppIcons.saleryIcon,

              title: 'You just got the salary',
              subtitle: 'out now Get 30% off now with promo msj2045',
            ),

            SizedBox(height: 20.h),

            /// **Yesterday Section**
            Text(
              'Yesterday',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
            SizedBox(height: 10.h),
            _notificationCard(
              icon: AppIcons.saleryIcon,
              title: 'Health Limit Cross',
              subtitle:
                  'You just cross your health expense budget of this month',
            ),
            _notificationCard(
              icon: AppIcons.health2dIcon,
              title: 'Health Limit Cross',
              subtitle: 'out now Get 30% off now with promo msj2045',
            ),
            _notificationCard(
              icon: AppIcons.saleryIcon,
              title: 'Health Limit Cross',
              subtitle:
                  'You just cross your health expense budget of this month',
            ),
            _notificationCard(
              icon: AppIcons.health2dIcon,
              title: 'Health Limit Cross',
              subtitle: 'out now Get 30% off now with promo msj2045',
            ),
          ],
        ),
      ),
    );
  }

  /// **Notification Item Widget**
  Widget _notificationCard({
    required String icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// **Icon**
          Container(
            width: 40.w,
            height: 40.w,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Center(child: SvgPicture.asset(icon)),
          ),
          SizedBox(width: 12.w),

          /// **Text Content**
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
