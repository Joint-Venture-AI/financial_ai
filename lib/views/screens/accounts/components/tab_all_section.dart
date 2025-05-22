import 'package:financial_ai_mobile/controller/accounts/accounts_tab_controller.dart';
import 'package:financial_ai_mobile/core/models/accounts_model.dart';
// Import TransactionItem if you were to use it conditionally, but we are not for now with AccountsModel
// import 'package:financial_ai_mobile/views/screens/accounts/components/week_transaction_item.dart';
import 'package:flutter/cupertino.dart' show CupertinoActivityIndicator;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TabAllSection extends StatelessWidget {
  final AccountsTabController accountTabController =
      Get.find<AccountsTabController>();

  TabAllSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      child: Obx(() {
        if (accountTabController.isLoading.value) {
          return const Center(child: CupertinoActivityIndicator());
        }

        if (accountTabController.accountsDisplayModel.isEmpty) {
          return Center(
            child: Text(
              "No data available for ${accountTabController.selectedTimeScheduleTab.value} (${accountTabController.selectedAccountTab.value}).",
              style: TextStyle(color: Colors.grey, fontSize: 14.sp),
              textAlign: TextAlign.center,
            ),
          );
        }

        return ListView.builder(
          itemCount: accountTabController.accountsDisplayModel.length,
          itemBuilder: (context, index) {
            final AccountsModel accountData =
                accountTabController.accountsDisplayModel[index];

            // For both 'Daily' and 'Weekly' views, if the data is AccountsModel,
            // we use daily_transaction_item as per your existing design for this model.
            // If 'Weekly' data was fundamentally different (e.g., individual transactions
            // for a different widget like TransactionItem), the controller and this logic
            // would need to handle that different data model.
            return daily_transaction_item(accountData);

            // --- Previous conditional logic based on hardcoded TransactionItem ---
            // if (accountTabController.selectedTimeScheduleTab.value == 'Daily') {
            //   return daily_transaction_item(accountData);
            // } else { // Weekly
            //   // If weekly data was meant for TransactionItem, and your API for weekly
            //   // returns a list of items suitable for TransactionItem, you'd parse
            //   // that in the controller and use TransactionItem here.
            //   // For now, we assume weekly data is also List<AccountsModel>.
            //   // The below is the OLD hardcoded TransactionItem:
            //   /*
            //   return TransactionItem(
            //     category: index == 1 ? "Sale" : "Food",
            //     description: "Buy for some b...",
            //     paymentMethod: index == 1 ? "Card" : "Cash",
            //     amount: index == 1 ? 220.00 : (index == 0 ? 80.00 : 40.00),
            //     isIncome: index == 1,
            //   );
            //   */
            //   // If you have a specific "weekly item card" design for AccountsModel
            //   // that is different from daily_transaction_item, you'd use it here.
            //   // e.g., return weekly_summary_item_widget(accountData);
            //   return daily_transaction_item(accountData); // Defaulting to daily_transaction_item for weekly AccountsModel
            // }
            // --- End of previous conditional logic ---
          },
        );
      }),
    );
  }
}

// The daily_transaction_item widget remains unchanged as per your request
// (with minor robustness improvements like Flexible, toStringAsFixed made previously)
Widget daily_transaction_item(AccountsModel data) {
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
        Flexible(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.date.day.toString().padLeft(2, '0'),
                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
              ),
              Text(
                DateFormat('MM-yyyy').format(data.date),
                style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
              ),
              SizedBox(height: 4.h),
              Text(
                data.dayName,
                style: TextStyle(fontSize: 10.sp, color: Colors.teal),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        SizedBox(width: 8.w),
        Flexible(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Income',
                style: TextStyle(fontSize: 12.sp, color: Colors.teal),
              ),
              SizedBox(height: 6.h),
              Text(
                'Expense',
                style: TextStyle(fontSize: 12.sp, color: Colors.red),
              ),
            ],
          ),
        ),
        SizedBox(width: 8.w),
        Flexible(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${data.totalIncome.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.teal,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 6.h),
              Text(
                '\$${data.totalExpense.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
