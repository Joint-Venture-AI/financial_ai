import 'package:financial_ai_mobile/controller/add_data_controller/add_data_controller.dart';
import 'package:financial_ai_mobile/core/helper/widget_helper.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:financial_ai_mobile/views/screens/add/components/add_expense_section.dart';
import 'package:financial_ai_mobile/views/screens/add/components/add_income_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
      if (_tabController.indexIsChanging) {
        _addDataController.selectedTab.value = tabTitles[_tabController.index];
      }
    });
    _addDataController.selectedTab.value = tabTitles[0];
  }

  @override
  void dispose() {
    if (mounted) {
      _tabController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: AppStyles.bgColor,
        appBar: WidgetHelper.showAppBar(
          isBack: true,
          title: _addDataController.selectedTab.value,
          isCenter: false,
          showActions: true,
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
                child: TabBar(
                  dividerColor: Colors.transparent,
                  controller: _tabController,
                  labelColor:
                      _addDataController.selectedTab.value.contains('Expense')
                          ? AppStyles.redColor
                          : AppStyles.primaryColor,
                  unselectedLabelColor: Colors.grey,
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      width: 2.0,
                      color:
                          _addDataController.selectedTab.value.contains(
                                'Expense',
                              )
                              ? AppStyles.redColor
                              : AppStyles.primaryColor,
                    ),
                  ),
                  tabs: [Tab(text: 'Income'), Tab(text: 'Expense')],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [AddIncomeSection(), AddExpenseSection()],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
