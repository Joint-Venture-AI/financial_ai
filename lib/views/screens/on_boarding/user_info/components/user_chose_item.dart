import 'package:financial_ai_mobile/core/utils/app_icons.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class UserChoseItem extends StatelessWidget {
  final bool isSelected;
  final String title;
  final String iconPath;

  final VoidCallback onTap;
  const UserChoseItem({
    super.key,
    required this.isSelected,
    required this.title,
    required this.onTap,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: 8.h),
        width: double.infinity,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : AppStyles.simpleGrey,
          borderRadius: BorderRadius.circular(10.sp),
          border: Border.all(
            width: isSelected ? 1 : 0,
            color: isSelected ? AppStyles.primaryColor : Colors.transparent,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected ? AppStyles.primaryColor : Colors.transparent,
              blurRadius: 2,
              blurStyle: BlurStyle.normal,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 48.w,
                height: 48.h,
                decoration: BoxDecoration(
                  color: isSelected ? AppStyles.primaryColor : Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    iconPath,
                    color: isSelected ? Colors.white : AppStyles.greyColor,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                title,
                style: AppStyles.mediumText.copyWith(
                  color: isSelected ? Colors.black : AppStyles.greyColor,
                ),
              ),
              const Spacer(),
              Checkbox(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.r),
                ),
                activeColor: AppStyles.primaryColor,
                value: isSelected,
                onChanged: (v) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
