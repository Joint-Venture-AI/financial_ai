import 'package:financial_ai_mobile/controller/add_data_controller/add_data_controller.dart';
import 'package:financial_ai_mobile/core/helper/widget_helper.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:financial_ai_mobile/views/screens/add/components/add_expense_section.dart';
import 'package:financial_ai_mobile/views/screens/add/components/add_income_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart'; // Import SchedulerBinding
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
  final AddDataController _addDataController =
      Get.find<AddDataController>(); // Explicit type
  final List<String> tabTitles = ['Income', 'Expense'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // Set initial value for selectedTab based on TabController's initial index
    // This should be safe as it's before the first build.
    _addDataController.selectedTab.value = tabTitles[_tabController.index];

    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    // Ensure widget is still mounted before trying to update state from listener
    if (!mounted) return;

    final newSelectedTabTitle = tabTitles[_tabController.index];

    // Only update if the value has actually changed
    if (_addDataController.selectedTab.value != newSelectedTabTitle) {
      // Defer the update to the GetX observable to after the current build cycle
      SchedulerBinding.instance.addPostFrameCallback((_) {
        // Re-check mounted because this callback is executed after the current frame,
        // and the widget might have been disposed in the meantime.
        if (mounted) {
          _addDataController.selectedTab.value = newSelectedTabTitle;
        }
      });
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(
      _handleTabSelection,
    ); // Good practice to remove listener
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // It's generally safer to access GetX controllers this way inside build,
    // or ensure it's initialized as a final field if found in initState.
    // final AddDataController _addDataController = Get.find<AddDataController>();

    return Obx(() {
      // Obx will rebuild when _addDataController.selectedTab changes
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
                  tabs: const [
                    // const for tabs if they don't change
                    Tab(text: 'Income'),
                    Tab(text: 'Expense'),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    AddIncomeSection(), // Consider adding const if possible
                    AddExpenseSection(), // Consider adding const if possible
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
