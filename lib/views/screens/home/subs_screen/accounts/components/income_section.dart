import 'package:financial_ai_mobile/controller/home/accounts_controller.dart'; // Import controller
import 'package:financial_ai_mobile/core/models/income_expense_model.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:financial_ai_mobile/views/screens/home/subs_screen/accounts/components/budget_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart'; // Import GetX

class IncomeSection extends StatelessWidget {
  final AccountsController controller; // Receive the controller

  const IncomeSection({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    // Use Obx to reactively rebuild when controller's state changes
    return Obx(() {
      // Show loading indicator
      if (controller.isLoadingIncome.value) {
        return const Center(child: CircularProgressIndicator());
      }

      // Show error message if any
      if (controller.incomeError.value.isNotEmpty) {
        return Center(
          child: Text(
            controller.incomeError.value,
            style: TextStyle(color: Colors.red),
          ),
        );
      }

      // Show message if data is empty
      if (controller.incomeData.isEmpty) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'No income recorded for today.',
              style: AppStyles.smallText.copyWith(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
        );
      }

      // Display the list if data is available
      // You might want to group by date here if the API provides multiple dates,
      // but based on your current API (getDailyIncome), it seems to return only one day's data.
      // This example assumes you just want to list the items for the fetched day.

      // --- Example Header (Optional - adapt if needed) ---
      // You might need to get date/total info differently if API changes
      // String dateStr = controller.todayDate; // Or get from API response if available
      // String dayOfWeek = "Sun"; // Calculate this based on date
      // String totalIncome = controller.incomeData.fold<double>(0, (sum, item) => sum + item.amount).toStringAsFixed(2);

      return Column(
        children: [
          // --- Example Header (Replace with actual data if needed) ---
          // Row(
          //   children: [
          //     Text(
          //       // Extract day number from dateStr
          //       style: AppStyles.mediumText.copyWith(fontWeight: FontWeight.bold, color: Colors.black),
          //     ),
          //     // ... other header elements using calculated dayOfWeek, totalIncome ...
          //     const Spacer(),
          //     Text(
          //       '\$$totalIncome',
          //       style: AppStyles.smallText.copyWith(color: AppStyles.primaryColor, fontSize: 14.sp),
          //     ),
          //   ],
          // ),
          // SizedBox(height: 10.h), // Spacing after header
          // --- End Example Header ---
          ListView.builder(
            physics:
                const NeverScrollableScrollPhysics(), // Important inside SingleChildScrollView
            shrinkWrap: true,
            itemCount: controller.incomeData.length, // Use actual data length
            itemBuilder: (context, index) {
              final incomeItem =
                  controller.incomeData[index]; // Get item from controller list
              return BudgetItem(
                isExpense: false, // It's income
                incomeExpenseModel: incomeItem, // Pass the fetched data
              );
            },
          ),
        ],
      );
    });
  }
}
