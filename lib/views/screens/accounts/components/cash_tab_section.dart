import 'package:financial_ai_mobile/controller/accounts/accounts_tab_controller.dart';
import 'package:financial_ai_mobile/core/models/accounts_model.dart';
import 'package:financial_ai_mobile/core/utils/api_endpoint.dart';
import 'package:financial_ai_mobile/views/screens/accounts/components/week_transaction_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

class CashTabSection extends StatelessWidget {
  CashTabSection({super.key});
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

        return FutureBuilder(
          future: accountTabController.getAccountsData(ApiEndpoint.getDaily),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CupertinoActivityIndicator());
            } else if (snapshot.hasError) {
              printError(info: '=====>>>> ${snapshot.error}');
              return Center(child: Icon(Icons.error));
            }
            return ListView.builder(
              itemCount: accountTabController.accountsModel.length,
              itemBuilder: (context, index) {
                return accountTabController.selectedTimeScheduleTab.value
                        .contains('Daily')
                    ? daily_transaction_item(
                      accountTabController.accountsModel[index],
                    )
                    : TransactionItem(
                      category: index == 1 ? "Sale" : "Food",
                      description: "Buy for some b...",
                      paymentMethod: index == 1 ? "Card" : "Cash",
                      amount:
                          index == 1 ? 220.00 : (index == 0 ? 80.00 : 40.00),
                      isIncome: index == 1,
                    );
              },
            );
          },
        );
      }),
    );
  }
}

Widget daily_transaction_item(AccountsModel data) {
  return Container(
    padding: EdgeInsets.all(10.w), // Adjust if not using screenutil
    margin: EdgeInsets.only(bottom: 10.h), // Adjust if not using screenutil
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(
        10.r,
      ), // Adjust if not using screenutil
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
        /// Date section - Updated to use DateTime object directly
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              // Get day from DateTime, format with leading zero
              data.date.day.toString().padLeft(2, '0'),
              style: TextStyle(
                fontSize: 22.sp, // Adjust if not using screenutil
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              // Format month and year using intl package
              DateFormat('MM-yyyy').format(data.date),
              style: TextStyle(
                fontSize: 12.sp, // Adjust if not using screenutil
                color: Colors.grey.shade600,
              ),
            ),
            SizedBox(height: 4.h), // Adjust if not using screenutil
            Text(
              // Use the pre-calculated dayName from the model
              data.dayName,
              style: TextStyle(
                fontSize: 10.sp, // Adjust if not using screenutil
                color: Colors.teal,
              ),
            ),
          ],
        ),

        /// Labels (No change needed)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Income',
              style: TextStyle(
                fontSize: 12.sp, // Adjust if not using screenutil
                color: Colors.teal,
              ),
            ),
            SizedBox(height: 6.h), // Adjust if not using screenutil
            Text(
              'Expense',
              style: TextStyle(
                fontSize: 12.sp, // Adjust if not using screenutil
                color: Colors.red,
              ),
            ),
          ],
        ),

        /// Values - Updated to use totalIncome and totalExpense
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              // Use totalIncome from the model
              '\$${data.totalIncome}',
              style: TextStyle(
                fontSize: 14.sp, // Adjust if not using screenutil
                color: Colors.teal,
              ),
            ),
            SizedBox(height: 6.h), // Adjust if not using screenutil
            Text(
              // Use totalExpense from the model
              '\$${data.totalExpense}',
              style: TextStyle(
                fontSize: 14.sp, // Adjust if not using screenutil
                color: Colors.red,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// The _getDayOfWeek function is NO LONGER NEEDED
// String _getDayOfWeek(String dateStr) { ... } // Remove this function
// The _getDayOfWeek function is NO LONGER NEEDED
// String _getDayOfWeek(String dateStr) { ... } // Remove this function
