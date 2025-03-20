import 'package:financial_ai_mobile/core/helper/widget_helper.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:financial_ai_mobile/views/glob_widgets/gradiunt_global_button.dart';
import 'package:financial_ai_mobile/views/screens/profie/upgrade/components/upgrade_widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpgradeScreen extends StatefulWidget {
  const UpgradeScreen({super.key});

  @override
  _UpgradeScreenState createState() => _UpgradeScreenState();
}

class _UpgradeScreenState extends State<UpgradeScreen> {
  bool isMonthly = true; // Toggle State

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.bgColor,
      appBar: WidgetHelper.showAppBar(
        isBack: true,
        title: 'Upgrade',
        isCenter: false,
        showActions: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20.h),

            /// **Header Section**
            Text(
              'How your trial works',
              style: AppStyles.largeText.copyWith(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5.h),
            Text(
              'fast, safe, and seamless transactions!',
              style: AppStyles.smallText.copyWith(
                fontSize: 14.sp,
                color: AppStyles.greyColor,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 20.h),

            /// **Toggle Switch (Monthly / Annual)**
            Container(
              width: 220.w,
              padding: EdgeInsets.all(5.w),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                children: [
                  _toggleButton('Monthly', isMonthly, () {
                    setState(() {
                      isMonthly = true;
                    });
                  }),
                  _toggleButton('Annual', !isMonthly, () {
                    setState(() {
                      isMonthly = false;
                    });
                  }),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            /// **Timeline Section**
            _timelineStep(
              icon: Icons.lock,
              title: 'Today',
              description:
                  'Access expert courses, smart budgeting tools, and more!',
            ),
            _timelineStep(
              icon: Icons.notifications,
              title: 'In 5 Days',
              description: 'We’ll send you a reminder that your trial call!',
            ),
            _timelineStep(
              icon: Icons.star,
              title: 'In 7 Days',
              description:
                  'You will be charged on March 29, cancel any time before.',
            ),

            SizedBox(height: 20.h),

            /// **Pricing Cards**
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _pricingCard(
                  title: '\$20.00 / Month',
                  subtitle: '\$120.00 per year, billed yearly',
                  discount: 'Save 20%',
                  isSelected: isMonthly,
                ),
                SizedBox(width: 10.w),
                _pricingCard(
                  title: '\$99.00 / Year',
                  subtitle: '8.33 Month per year, billed yearly',
                  isSelected: !isMonthly,
                ),
              ],
            ),

            SizedBox(height: 20.h),

            /// **Continue Button**
            GradiuntGlobalButton(
              text: 'Continue',
              onTap: () => UpgradeWidgetHelper.showPayBottomSheet(context),
            ),
          ],
        ),
      ),
    );
  }

  /// **Toggle Button Widget**
  Widget _toggleButton(String text, bool isSelected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          decoration: BoxDecoration(
            color: isSelected ? Colors.teal.shade600 : Colors.transparent,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// **Timeline Step Widget**
  Widget _timelineStep({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// **Timeline Icon**
          Container(
            width: 30.w,
            height: 30.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.teal.shade100,
            ),
            child: Icon(icon, size: 18.sp, color: Colors.teal.shade700),
          ),
          SizedBox(width: 10.w),

          /// **Text**
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  description,
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

  /// **Pricing Card Widget**
  Widget _pricingCard({
    required String title,
    required String subtitle,
    String? discount,
    required bool isSelected,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? Colors.teal.shade700 : Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (discount != null)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.teal.shade100,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  discount,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal.shade700,
                  ),
                ),
              ),
            SizedBox(height: 6.h),
            Text(
              title,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4.h),
            Text(
              subtitle,
              style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
}
