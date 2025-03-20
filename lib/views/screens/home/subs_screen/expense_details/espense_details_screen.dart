import 'package:financial_ai_mobile/core/helper/widget_helper.dart';
import 'package:financial_ai_mobile/core/utils/app_icons.dart' show AppIcons;
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ExpenseDetailsScreen extends StatefulWidget {
  const ExpenseDetailsScreen({super.key});

  @override
  State<ExpenseDetailsScreen> createState() => _ExpenseDetailsScreenState();
}

class _ExpenseDetailsScreenState extends State<ExpenseDetailsScreen> {
  bool _incomeRulesExpanded = false;
  bool _expenseRulesExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.bgColor,
      appBar: WidgetHelper.showAppBar(
        isBack: true,
        title: 'Expense Details',
        isCenter: false,
        showActions: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
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
                child: Column(
                  children: [
                    SizedBox(
                      width: 200.w,
                      height: 200.h,
                      child: SfCircularChart(
                        series: <CircularSeries>[
                          PieSeries<ChartData, String>(
                            dataSource: <ChartData>[
                              ChartData('Available Blance', 7),
                              ChartData('Total Cost', 93),
                            ],
                            xValueMapper: (ChartData data, _) => data.category,
                            yValueMapper: (ChartData data, _) => data.amount,
                            dataLabelSettings: const DataLabelSettings(
                              isVisible: true,
                            ),
                            enableTooltip: true,
                            pointColorMapper: (ChartData data, _) {
                              switch (data.category) {
                                case 'Available Blance':
                                  return AppStyles
                                      .primaryColor; // Change color for 'Food'
                                case 'Total Cost':
                                  return AppStyles.redColor;

                                default:
                                  return Colors
                                      .grey; // Default color if no match
                              }
                            },
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 10.h,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 12.w,
                            height: 12.h,
                            decoration: BoxDecoration(
                              color: AppStyles.redColor,
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Total Cost',
                            style: AppStyles.smallText.copyWith(
                              color: AppStyles.greyColor,
                              fontSize: 12.sp,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            width: 12.w,
                            height: 12.h,
                            decoration: BoxDecoration(
                              color: AppStyles.primaryColor,
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Available Balance',
                            style: AppStyles.smallText.copyWith(
                              color: AppStyles.primaryColor,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5.h),
                  ],
                ),
              ),
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
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Ai',
                            style: AppStyles.mediumText.copyWith(
                              color: AppStyles.primaryColor,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            'Smart Financial Rules',
                            style: AppStyles.mediumText.copyWith(
                              color: Colors.black,
                              fontSize: 20.sp,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Simple guidelines to manage income, control expenses, and build financial stability',
                        style: AppStyles.smallText.copyWith(
                          fontSize: 12.sp,
                          color: AppStyles.greyColor,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _incomeRulesExpanded = !_incomeRulesExpanded;
                          });
                        },
                        child: FinancialItem(
                          iconPath: AppIcons.houseIcon,
                          title: 'Income Rules',
                          isExpanded: _incomeRulesExpanded,
                        ),
                      ),
                      if (_incomeRulesExpanded)
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          child: IncomeRulesContent(),
                        ),
                      SizedBox(height: 5.h),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _expenseRulesExpanded = !_expenseRulesExpanded;
                          });
                        },
                        child: FinancialItem(
                          iconPath: AppIcons.houseIcon,
                          title: 'Income Rules',
                          isExpanded: _incomeRulesExpanded,
                        ),
                      ),
                      if (_expenseRulesExpanded)
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          child: ExpenseRulesContent(),
                        ),
                      SizedBox(height: 5.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FinancialItem extends StatelessWidget {
  const FinancialItem({
    super.key,
    required this.iconPath,
    required this.title,
    required this.isExpanded,
  });

  final String iconPath;
  final String title;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: AppStyles.lightGreyColor),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 5.h,
        ), // Reduced vertical padding for responsiveness
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.start, // Ensure items align correctly
          children: [
            // Icon Container
            Container(
              height: 44.h, // Use .h for responsiveness
              width: 44.w, // Use .w for responsiveness
              decoration: BoxDecoration(
                color: AppStyles.primaryColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(iconPath, color: Colors.white),
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              title,
              style: AppStyles.smallText.copyWith(
                color: Colors.black,
                fontSize: 14.sp,
              ),
            ),
            const Spacer(), // To align the CircularPercentIndicator properly
            SvgPicture.asset(
              isExpanded ? AppIcons.arrowUpIcon : AppIcons.arrowDownIcon,
              color: Colors.black,
            ),
            // CircularPercentIndicator
          ],
        ),
      ),
    );
  }
}

class IncomeRulesContent extends StatelessWidget {
  const IncomeRulesContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Income Rules",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            "1. 50/30/20 Rule: Allocate 50% of your income to needs, 30% to wants, and 20% to savings and debt repayment.",
          ),
          const SizedBox(height: 4),
          const Text(
            "2. Multiple Income Streams: Relying on a single income source is risky. Consider side hustles, investments, or passive income.",
          ),
          const SizedBox(height: 4),
          const Text(
            "3. Pay Yourself First: Before spending, save a fixed percentage (e.g., 10-20%) of your income.",
          ),
          const SizedBox(height: 4),
          const Text(
            "4. Increase Earnings, Not Just Savings: Focus on skill-building, career growth, or business opportunities to boost income.",
          ),
          const SizedBox(height: 4),
          const Text(
            "5. Emergency Fund Rule: Save at least 3-6 months' worth of expenses in an emergency fund.",
          ),
          const SizedBox(height: 4),
          const Text(
            "6. Tax Planning: Understand and optimize tax deductions to maximize after-tax income.",
          ),
        ],
      ),
    );
  }
}

class ExpenseRulesContent extends StatelessWidget {
  const ExpenseRulesContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Expense Rules",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            "1. 50/30/20 Rule: Allocate 50% of your income to needs, 30% to wants, and 20% to savings and debt repayment.",
          ),
          const SizedBox(height: 4),
          const Text(
            "2. Multiple Income Streams: Relying on a single income source is risky. Consider side hustles, investments, or passive income.",
          ),
          const SizedBox(height: 4),
          const Text(
            "3. Pay Yourself First: Before spending, save a fixed percentage (e.g., 10-20%) of your income.",
          ),
          const SizedBox(height: 4),
          const Text(
            "4. Increase Earnings, Not Just Savings: Focus on skill-building, career growth, or business opportunities to boost income.",
          ),
          const SizedBox(height: 4),
          const Text(
            "5. Emergency Fund Rule: Save at least 3-6 months' worth of expenses in an emergency fund.",
          ),
          const SizedBox(height: 4),
          const Text(
            "6. Tax Planning: Understand and optimize tax deductions to maximize after-tax income.",
          ),
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.category, this.amount);

  final String category;
  final double amount;
}
