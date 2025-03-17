import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BudgetItem extends StatelessWidget {
  final bool isExpense;
  const BudgetItem({super.key, required this.isExpense});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Salary',
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
                    'Sale Product',
                    style: AppStyles.mediumText.copyWith(
                      fontSize: 16.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'Card',
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
                  '\$89,000.00',
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
