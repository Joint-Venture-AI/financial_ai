import 'package:financial_ai_mobile/controller/add_data_controller/add_data_controller.dart';
import 'package:financial_ai_mobile/core/helper/widget_helper.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:financial_ai_mobile/views/screens/add/components/add_expense_section.dart';
import 'package:financial_ai_mobile/views/screens/add/components/add_income_section.dart';
import 'package:financial_ai_mobile/views/screens/home/subs_screen/accounts/components/income_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _addDataController = Get.find<AddDataController>();
  final List<String> tabTitles = ['Income', 'Expense'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      _addDataController.selectedTab.value = tabTitles[_tabController.index];
    });
    // Initialize with the first tab title
    _addDataController.selectedTab.value = tabTitles[0];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: AppStyles.bgColor,
        appBar: WidgetHelper.showAppBar(
          isBack: true,
          title:
              _addDataController
                  .selectedTab
                  .value, // Changed title to be more generic
          isCenter: false,
          showActions: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              // Add Expanded here to constrain the container's height
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 16.w,
                        right: 16.w,
                        top: 10.h,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white, // White background
                          borderRadius: BorderRadius.circular(16.r),
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
                        child: TabBar(
                          controller: _tabController,
                          dividerColor: Colors.transparent,
                          labelColor:
                              _addDataController.selectedTab.value.contains(
                                    'Expense',
                                  )
                                  ? AppStyles.redColor
                                  : AppStyles.primaryColor, // Active tab color
                          unselectedLabelColor:
                              Colors.grey, // Inactive tab color
                          indicator: UnderlineTabIndicator(
                            // Use UnderlineTabIndicator
                            borderSide: BorderSide(
                              width: 2.0, // Adjust thickness as needed

                              color:
                                  _addDataController.selectedTab.value.contains(
                                        'Expense',
                                      )
                                      ? AppStyles.redColor
                                      : AppStyles
                                          .primaryColor, // Indicator color
                            ),
                            insets:
                                EdgeInsets.zero, // Remove any default insets
                          ),
                          tabs: [
                            Expanded(child: Tab(text: 'Income')),
                            Expanded(child: Tab(text: 'Expense')),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h), // Spacing after tab bar
                    Expanded(
                      // Keep Expanded here
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          // Content for Income Tab
                          AddIncomeSection(),
                          AddExpenseSection(),
                          // Content for Expense Tab
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
