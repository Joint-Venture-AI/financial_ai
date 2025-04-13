import 'package:financial_ai_mobile/core/models/income_expense_model.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BudgetItem extends StatelessWidget {
  final bool isExpense;
  final IncomeExpenseModel incomeExpenseModel;
  const BudgetItem({
    super.key,
    required this.isExpense,
    required this.incomeExpenseModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                incomeExpenseModel.source,
                style: AppStyles.smallText.copyWith(
                  fontSize: 14.sp,
                  color: AppStyles.greyColor,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    incomeExpenseModel.note,
                    style: AppStyles.mediumText.copyWith(
                      fontSize: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    incomeExpenseModel.method,
                    style: AppStyles.mediumText.copyWith(
                      fontSize: 12.sp,
                      color: AppStyles.greyColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '\$${incomeExpenseModel.amount}',
                  style: AppStyles.smallText.copyWith(
                    color: isExpense ? Colors.red : AppStyles.primaryColor,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }
}
