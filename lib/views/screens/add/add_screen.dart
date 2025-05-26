import 'package:financial_ai_mobile/controller/add_data_controller/add_data_controller.dart';
import 'package:financial_ai_mobile/core/helper/widget_helper.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:financial_ai_mobile/views/screens/add/components/add_expense_section.dart';
import 'package:financial_ai_mobile/views/screens/add/components/add_income_section.dart';
import 'package:financial_ai_mobile/views/screens/add/controller/add_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddScreen extends StatelessWidget {
  AddScreen({Key? key}) : super(key: key);

  final AddTabController _controller = Get.put(AddTabController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.bgColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Obx(
          () => WidgetHelper.showAppBar(
            isBack: true,
            title: _controller.selectedTab.value,
            isCenter: false,
            showActions: true,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Obx(() {
                // Reactive tab styling based on selected tab
                final isExpense = _controller.selectedTab.value == 'Expense';
                return TabBar(
                  controller: _controller.tabController,
                  labelColor:
                      isExpense ? AppStyles.redColor : AppStyles.primaryColor,
                  unselectedLabelColor: Colors.grey,
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      width: 2.0,
                      color:
                          isExpense
                              ? AppStyles.redColor
                              : AppStyles.primaryColor,
                    ),
                  ),
                  tabs: const [Tab(text: 'Income'), Tab(text: 'Expense')],
                );
              }),
            ),
            Expanded(
              child: TabBarView(
                controller: _controller.tabController,
                children: [AddIncomeSection(), AddExpenseSection()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
