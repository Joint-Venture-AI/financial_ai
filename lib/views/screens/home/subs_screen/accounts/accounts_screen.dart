import 'package:financial_ai_mobile/controller/home/accounts_controller.dart';
import 'package:financial_ai_mobile/controller/home/home_controller.dart';
import 'package:financial_ai_mobile/core/helper/widget_helper.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart' show AppStyles;
import 'package:financial_ai_mobile/views/screens/home/subs_screen/accounts/components/expense_section.dart';
import 'package:financial_ai_mobile/views/screens/home/subs_screen/accounts/components/income_section.dart';
import 'package:financial_ai_mobile/views/screens/home/subs_screen/accounts/components/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AccountsScreen extends StatelessWidget {
  AccountsScreen({super.key});

  // Use Get.put only once, preferably higher up if needed elsewhere,
  // or use Get.lazyPut in bindings. For this screen, Get.put is okay.
  final accountController = Get.put(AccountsController());
  final homeController =
      Get.find<
        HomeController
      >(); // Assuming HomeController is already put elsewhere

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
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15.h),
                headerBodySection(homeController), // Keep your header
                SizedBox(height: 15.h),
                // SizedBox(height: 20.h), // Removed extra space
                Container(
                  // ... (Tab bar container decoration - Keep as is) ...
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 5.h,
                    ),
                    child: Obx(() {
                      // Obx rebuilds only this Row when selectedTab changes
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children:
                            accountController.accountTab.map((tab) {
                              return Expanded(
                                child: TabItem(
                                  isSelected:
                                      tab ==
                                      accountController.selectedTab.value,
                                  title: tab,
                                  onTap: () {
                                    // This automatically triggers the 'ever' listener
                                    // in the controller to fetch new data
                                    accountController.selectedTab.value = tab;
                                  },
                                ),
                              );
                            }).toList(),
                      );
                    }),
                  ),
                ),
                SizedBox(height: 10.h),
                // Conditionally display Income or Expense Section based on selected tab
                Obx(() {
                  // Obx rebuilds this part when selectedTab or data changes
                  if (accountController.selectedTab.value == 'Income') {
                    // Pass the controller to the section
                    return IncomeSection(controller: accountController);
                  } else {
                    // Pass the controller to the section
                    return ExpenseSection(controller: accountController);
                  }
                }),
                SizedBox(height: 20.h), // Keep bottom padding if desired
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget headerBodySection(HomeController homeController) {
    return Obx(() {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32.r),
          boxShadow: [
            BoxShadow(
              blurRadius: 36,
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(8.r),
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
                  padding: EdgeInsets.all(15.r),
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
                            TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
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
                            TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                            ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        '\$${homeController.availableMoney.value.toStringAsFixed(2)}',
                        style:
                            AppStyles.smallText?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 40.sp,
                            ) ??
                            TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 40.sp,
                            ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        'Today (-\$${homeController.todayExpense.value.toStringAsFixed(2)})',
                        style:
                            AppStyles.smallText?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                            ) ??
                            TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
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
                                  fontSize: 14.sp,
                                ) ??
                                TextStyle(color: Colors.black, fontSize: 14.sp),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            '\$${homeController.totalIncome.value.toStringAsFixed(2)}',
                            style:
                                AppStyles.smallText?.copyWith(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp,
                                ) ??
                                TextStyle(color: Colors.green, fontSize: 14.sp),
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
                                  fontSize: 14.sp,
                                ) ??
                                TextStyle(color: Colors.black, fontSize: 14.sp),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            '\$${homeController.totalExpense.value.toStringAsFixed(2)}',
                            style:
                                AppStyles.smallText?.copyWith(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp,
                                ) ??
                                TextStyle(color: Colors.red, fontSize: 14.sp),
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
    });
  }
}
