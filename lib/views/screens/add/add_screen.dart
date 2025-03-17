import 'package:financial_ai_mobile/core/helper/widget_helper.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.bgColor,
      appBar: WidgetHelper.showAppBar(
        isBack: true,
        title: 'Add Transaction', // Changed title to be more generic
        isCenter: false,
        showActions: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w), // Added padding for better visual appeal
        child: Column(
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
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: TabBar(
                          controller: _tabController,
                          dividerColor: Colors.transparent,
                          labelColor:
                              AppStyles.primaryColor, // Active tab color
                          unselectedLabelColor:
                              Colors.grey, // Inactive tab color
                          indicatorColor:
                              AppStyles.primaryColor, // Indicator color
                          tabs: const [
                            Tab(text: 'Income'),
                            Tab(text: 'Expense'),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h), // Spacing after tab bar
                    Expanded(
                      // Keep Expanded here
                      child: TabBarView(
                        controller: _tabController,
                        children: const [
                          // Content for Income Tab
                          Center(child: Text('Income Content')),
                          // Content for Expense Tab
                          Center(child: Text('Expense Content')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
