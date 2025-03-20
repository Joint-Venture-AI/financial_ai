import 'package:financial_ai_mobile/controller/accounts/accounts_controller.dart';
import 'package:financial_ai_mobile/core/helper/widget_helper.dart';
import 'package:financial_ai_mobile/core/utils/app_icons.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:financial_ai_mobile/views/screens/accounts/components/card_tab_section.dart';
import 'package:financial_ai_mobile/views/screens/accounts/components/cash_tab_section.dart';
import 'package:financial_ai_mobile/views/screens/accounts/components/tab_all_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({super.key});
  final accountTabController = Get.put(AccountsTabController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.bgColor,
      appBar: WidgetHelper.showAppBar(
        isBack: false,
        title: 'Accounts',
        isCenter: false,
        showActions: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///time_schedule
            Row(
              children: [
                Obx(() {
                  return Row(
                    children: List.generate(
                      accountTabController.timeSchedule.length,
                      (index) {
                        return Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10.r),
                            onTap: () {
                              accountTabController
                                      .selectedTimeScheduleTab
                                      .value =
                                  accountTabController.timeSchedule[index];
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color:
                                    accountTabController.timeSchedule[index] ==
                                            accountTabController
                                                .selectedTimeScheduleTab
                                                .value
                                        ? AppStyles.lightGreyColor
                                        : Colors.transparent,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 5.h,
                                ),
                                child: Text(
                                  accountTabController.timeSchedule[index],
                                  style: AppStyles.smallText.copyWith(
                                    color: AppStyles.greyColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
                // const Spacer(),
                // SvgPicture.asset(
                //   AppIcons.filterIcon,
                //   color: AppStyles.darkGreyColor,
                // ),
              ],
            ),

            // Account Tabs Section
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
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                child: Obx(() {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      accountTabController.accountTab.length,
                      (index) {
                        return Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: InkWell(
                            onTap: () {
                              accountTabController.selectedAccountTab.value =
                                  accountTabController.accountTab[index];
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color:
                                    accountTabController.accountTab[index] ==
                                            accountTabController
                                                .selectedAccountTab
                                                .value
                                        ? AppStyles.primaryColor
                                        : Colors.transparent,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 5.h,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                  ),
                                  child: Text(
                                    accountTabController.accountTab[index],
                                    style: AppStyles.smallText.copyWith(
                                      color:
                                          accountTabController
                                                      .accountTab[index] ==
                                                  accountTabController
                                                      .selectedAccountTab
                                                      .value
                                              ? Colors.white
                                              : AppStyles.greyColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
              ),
            ),

            // Display the Selected Tab Content
            SizedBox(height: 20.h),
            Obx(() {
              final selectedTab = accountTabController.selectedAccountTab.value;
              Widget content;
              switch (selectedTab) {
                case 'All':
                  content = TabAllSection();
                  break;
                case 'Cash':
                  content = CashTabSection();
                  break;
                case 'Card':
                  content = CardTabSection();
                  break;
                default:
                  content = Container(); // Handle default case or error
              }
              return Expanded(
                child: content,
              ); // Wrap with Expanded to take remaining space
            }),
          ],
        ),
      ),
    );
  }
}
