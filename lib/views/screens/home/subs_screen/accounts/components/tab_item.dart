import 'package:financial_ai_mobile/controller/home/accounts_controller.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

// TabItem Class (Simplified)
class TabItem extends StatelessWidget {
  final bool isSelected;
  final String title;
  final VoidCallback onTap;

  TabItem({
    super.key,
    required this.isSelected,
    required this.title,
    required this.onTap,
  });

  final _accountController = Get.find<AccountsController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color:
              isSelected
                  ? _accountController.selectedTab.value.contains('Income')
                      ? AppStyles.primaryColor
                      : AppStyles.redColor
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 15.w,
          vertical: 8.h,
        ), // Add vertical padding
        child: Center(
          child: Text(
            title,
            style: AppStyles.mediumText.copyWith(
              color: isSelected ? Colors.white : AppStyles.greyColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
