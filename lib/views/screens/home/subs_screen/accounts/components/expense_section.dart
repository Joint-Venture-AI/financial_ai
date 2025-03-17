import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:financial_ai_mobile/views/screens/home/subs_screen/accounts/components/budget_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpenseSection extends StatelessWidget {
  const ExpenseSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              '03',
              style: AppStyles.mediumText.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(width: 2.w),
            Container(
              decoration: BoxDecoration(
                color: AppStyles.primaryTransparent,
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Text(
                  'Sun',
                  style: AppStyles.smallText.copyWith(
                    color: AppStyles.primaryColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(width: 2.w),

            Text(
              '12,25',
              style: AppStyles.smallText.copyWith(
                color: Colors.black,
                fontSize: 12.sp,
              ),
            ),
            const Spacer(),
            Text(
              '\$89,000.00',
              style: AppStyles.smallText.copyWith(
                color: AppStyles.redColor,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return BudgetItem(isExpense: true);
            },
          ),
        ),
      ],
    );
  }
}
