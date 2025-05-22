import 'package:financial_ai_mobile/controller/accounts/accounts_tab_controller.dart';
import 'package:financial_ai_mobile/core/models/accounts_model.dart';
// import 'package:financial_ai_mobile/core/utils/api_endpoint.dart'; // Not needed here
import 'package:financial_ai_mobile/views/screens/accounts/components/week_transaction_item.dart'; // Not directly used for AccountsModel data
import 'package:flutter/cupertino.dart'
    show CupertinoActivityIndicator; // Explicit import
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart'; // Get.dart is sufficient
import 'package:intl/intl.dart';

class CashTabSection extends StatelessWidget {
  // Use Get.find to get the existing instance of the controller
  final AccountsTabController accountTabController =
      Get.find<AccountsTabController>();

  CashTabSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      child: Obx(() {
        // 1. Show loading indicator if isLoading is true
        if (accountTabController.isLoading.value) {
          return const Center(child: CupertinoActivityIndicator());
        }

        // 2. Handle empty data after loading
        // Note: The original check for selectedTimeScheduleTab.isEmpty is less relevant now,
        // as isLoading and accountsModel.isEmpty cover the states better.
        // The controller initializes selectedTimeScheduleTab to 'Daily'.
        if (accountTabController.accountsDisplayModel.isEmpty) {
          return Center(
            child: Text(
              "No cash data available for ${accountTabController.selectedTimeScheduleTab.value}.",
              style: TextStyle(color: Colors.grey, fontSize: 14.sp),
            ),
          );
        }

        // 3. Display data using ListView.builder
        return ListView.builder(
          itemCount: accountTabController.accountsDisplayModel.length,
          itemBuilder: (context, index) {
            final AccountsModel accountData =
                accountTabController.accountsDisplayModel[index];

            // If the data in accountsModel (for both Daily and Weekly) is of type AccountsModel,
            // we should use daily_transaction_item to display it.
            // The original distinction for TransactionItem was for hardcoded data.
            // To display fetched data consistently:
            return daily_transaction_item(accountData);

            // Original logic from your snippet:
            /*
            return accountTabController.selectedTimeScheduleTab.value
                    .contains('Daily')
                ? daily_transaction_item(
                    accountTabController.accountsModel[index],
                  )
                : TransactionItem( // This uses hardcoded data, not fetched data
                    category: index == 1 ? "Sale" : "Food",
                    description: "Buy for some b...",
                    paymentMethod: index == 1 ? "Card" : "Cash", // This conflicts with "Cash" tab intent
                    amount:
                        index == 1 ? 220.00 : (index == 0 ? 80.00 : 40.00),
                    isIncome: index == 1,
                  );
            */
            // If weekly data needs a different widget AND uses the fetched 'accountData',
            // you would introduce that widget here.
            // e.g., if (accountTabController.selectedTimeScheduleTab.value == 'Weekly') {
            //         return YourWeeklyCashWidget(accountData);
            //       }
          },
        );
      }),
    );
  }
}

// This is the daily_transaction_item widget exactly as you provided in this prompt.
// It's used to display items from the accountsModel list.
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
        /// Date section
        Flexible(
          // Added Flexible to prevent overflow with long day names
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
                overflow: TextOverflow.ellipsis, // Handle long day names
              ),
            ],
          ),
        ),
        SizedBox(width: 8.w),

        /// Labels
        Flexible(
          // Added Flexible
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

        /// Values
        Flexible(
          // Added Flexible
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                // Using string interpolation as per your original design.
                // For currency formatting, consider NumberFormat.currency().
                '\$${data.totalIncome.toStringAsFixed(2)}', // Ensure two decimal places
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.teal,
                  fontWeight:
                      FontWeight.w600, // Added for emphasis like in previous
                ),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 6.h),
              Text(
                '\$${data.totalExpense.toStringAsFixed(2)}', // Ensure two decimal places
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.red,
                  fontWeight: FontWeight.w600, // Added for emphasis
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
