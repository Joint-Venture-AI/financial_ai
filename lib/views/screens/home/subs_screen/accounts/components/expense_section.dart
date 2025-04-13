// Example Structure for ExpenseSection
import 'package:financial_ai_mobile/controller/home/accounts_controller.dart';
import 'package:financial_ai_mobile/views/screens/home/subs_screen/accounts/components/budget_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpenseSection extends StatelessWidget {
  final AccountsController controller;

  const ExpenseSection({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoadingExpense.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.expenseError.value.isNotEmpty) {
        return Center(
          child: Text(
            controller.expenseError.value,
            style: TextStyle(color: Colors.red),
          ),
        );
      }

      if (controller.expenseData.isEmpty) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'No expenses recorded for today.',
              style: AppStyles.smallText.copyWith(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
      // --- Similar logic as IncomeSection to display header (if needed) and ListView ---
      return Column(
        children: [
          // Optional: Header for the expense day/total
          // ...
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.expenseData.length,
            itemBuilder: (context, index) {
              final expenseItem = controller.expenseData[index];
              return BudgetItem(
                isExpense: true, // It's expense
                incomeExpenseModel: expenseItem,
              );
            },
          ),
        ],
      );
    });
  }
}
