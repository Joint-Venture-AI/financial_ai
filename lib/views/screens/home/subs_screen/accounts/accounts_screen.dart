import 'package:financial_ai_mobile/controller/home/accounts_controller.dart';
import 'package:financial_ai_mobile/core/helper/widget_helper.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart' show AppStyles;
import 'package:financial_ai_mobile/views/screens/home/subs_screen/accounts/components/expense_section.dart';
import 'package:financial_ai_mobile/views/screens/home/subs_screen/accounts/components/income_section.dart';
import 'package:financial_ai_mobile/views/screens/home/subs_screen/accounts/components/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AccountsScreen extends StatelessWidget {
  AccountsScreen({super.key});
  final accountController = Get.put(AccountsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.bgColor,
      appBar: WidgetHelper.showAppBar(
        isBack: true,
        title: 'Accounts',
        isCenter: false,
        showActions: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                header_body_section(),
                SizedBox(height: 15.h),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white, // White background
                    borderRadius: BorderRadius.circular(32.r),
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
                ),
                SizedBox(height: 20.h),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 36,
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 5.h,
                    ),
                    child: Obx(() {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment:
                            MainAxisAlignment.spaceAround, // Use spaceAround
                        children:
                            accountController.accountTab.map((tab) {
                              // Use map directly
                              return Expanded(
                                // Wrap TabItem in Expanded
                                child: TabItem(
                                  isSelected:
                                      tab ==
                                      accountController.selectedTab.value,
                                  title: tab,
                                  onTap: () {
                                    accountController.selectedTab.value = tab;
                                  },
                                ),
                              );
                            }).toList(), // Convert the map to a list
                      );
                    }),
                  ),
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  height: 350.h, // Or any appropriate fixed height
                  child: Obx(() {
                    return accountController.selectedTab.value.contains(
                          'Income',
                        )
                        ? IncomeSection()
                        : ExpenseSection();
                  }),
                ),
              ],
            ),
          ),
        ],
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
                                fontWeight: FontWeight.w600,
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
                                fontWeight: FontWeight.w600,
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
