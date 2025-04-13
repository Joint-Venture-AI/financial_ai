import 'package:financial_ai_mobile/controller/accounts/accounts_tab_controller.dart';
import 'package:financial_ai_mobile/views/screens/accounts/components/week_transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CardTabSection extends StatelessWidget {
  CardTabSection({super.key});
  final accountTabController = Get.put(AccountsTabController());
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      child: Obx(() {
        if (accountTabController.selectedTimeScheduleTab.isEmpty) {
          return Center(
            child: CircularProgressIndicator(),
          ); // Handle case when it's empty
        }

        return ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return accountTabController.selectedTimeScheduleTab.value.contains(
                  'Daily',
                )
                ? daily_transaction_item()
                : TransactionItem(
                  category: index == 1 ? "Sale" : "Food",
                  description: "Buy for some b...",
                  paymentMethod: index == 1 ? "Card" : "Cash",
                  amount: index == 1 ? 220.00 : (index == 0 ? 80.00 : 40.00),
                  isIncome: index == 1,
                );
          },
        );
      }),
    );
  }
}

Container daily_transaction_item() {
  return Container(
    padding: EdgeInsets.all(10.w),
    margin: EdgeInsets.only(bottom: 10.h),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.r),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          blurRadius: 5,
          spreadRadius: 1,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// Left Section (Date + Day)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '03',
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 4.w),
                Text(
                  'Jun 25',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: Colors.teal.shade100,
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: Text(
                'Sunday',
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.teal.shade800,
                ),
              ),
            ),
          ],
        ),

        /// Middle Section (Income + Expense Labels)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Income',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.teal,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              'Expense',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),

        /// Right Section (Income + Expense Amounts)
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '\$220.00',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.teal,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              '\$1200.00',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
