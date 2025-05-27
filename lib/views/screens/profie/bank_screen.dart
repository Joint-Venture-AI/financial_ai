// In a file like: lib/views/screens/profie/bank_screen.dart
import 'package:financial_ai_mobile/core/models/bank_data_model.dart'; // Import your model
// Make sure your BankController is correctly imported
import 'package:financial_ai_mobile/views/screens/profie/controller/bank_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BankScreen extends StatelessWidget {
  BankScreen({super.key});

  final BankController bankController = Get.put(BankController());

  Widget _buildTransactionList(
    List<BankDataModel> transactions,
    bool isUncategorizedList,
  ) {
    if (transactions.isEmpty) {
      return Center(
        child: Text(
          isUncategorizedList
              ? 'No uncategorized transactions.'
              : 'No categorized transactions.',
          style: TextStyle(fontSize: 18.sp, color: Colors.grey.shade600),
          textAlign: TextAlign.center,
        ),
      );
    }
    return Column(
      children: [
        // Only show "Make all categorized" button for uncategorized list
        // and if there are transactions
        if (isUncategorizedList && transactions.isNotEmpty)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: ElevatedButton(
              // Changed to ElevatedButton for better styling
              style: ElevatedButton.styleFrom(foregroundColor: Colors.white),
              onPressed: () {
                // Ensure you pass the correct list instance
                bankController.makeAllTransactionsCategorized(
                  bankController.nonCategorisedTransactions
                      .toList(), // Pass a copy
                );
              },
              child: const Text('Categorize All These Transactions'),
            ),
          ),
        Expanded(
          child: ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final transaction = transactions[index];
              return Card(
                key: ValueKey(transaction.id), // Use the main ID
                margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 18.r,
                            backgroundColor:
                                Theme.of(context).primaryColorLight,
                            child: Text(
                              // UPDATED: Access from nested Amount object
                              transaction.amount.currencyCode,
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Text(
                              // UPDATED: Access from nested Descriptions object
                              transaction.descriptions.display,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            // UPDATED: Access from nested Amount object
                            transaction.amount.actualAmount.toStringAsFixed(2),
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color:
                                  transaction.amount.actualAmount < 0
                                      ? Colors.red.shade700
                                      : Colors.green.shade700,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Status: ${transaction.status}',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      Text(
                        // Displaying tId if available (optional, for debugging/info)
                        'tId: ${transaction.tId ?? "N/A"}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Text(
                        'Created: ${transaction.createdAt.toLocal().toString().substring(0, 16)}',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      // Optionally, show other fields if needed for UI/debug
                      // Text('User: ${transaction.user ?? "N/A"}'),
                      // Text('Categorised: ${transaction.isCategorised}'),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Bank Transactions'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: bankController.tabController,
          indicatorColor: Theme.of(context).colorScheme.secondary,
          labelColor: Theme.of(context).colorScheme.secondary,
          unselectedLabelColor: Colors.grey.shade600,
          tabs: const [Tab(text: 'Uncategorized'), Tab(text: 'Categorized')],
        ),
      ),
      body: Obx(() {
        if (bankController.isLoadingTransactions.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (bankController.fetchErrorMessage.value.isNotEmpty &&
            bankController.nonCategorisedTransactions.isEmpty &&
            bankController.categorisedTransactions.isEmpty) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(16.sp),
              child: Text(
                bankController.fetchErrorMessage.value,
                style: TextStyle(fontSize: 18.sp, color: Colors.red.shade700),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        return TabBarView(
          controller: bankController.tabController,
          children: [
            _buildTransactionList(
              bankController.nonCategorisedTransactions,
              true,
            ),
            _buildTransactionList(
              bankController.categorisedTransactions,
              false,
            ),
          ],
        );
      }),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.sp),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                  onPressed: () {
                    bankController.bankAuthentication();
                  },
                  child: Text(
                    'Add/Link Bank',
                    style: TextStyle(fontSize: 15.sp),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                  onPressed: () {
                    bankController.fetchBankTransactions();
                  },
                  child: Text(
                    'Refresh Transactions',
                    style: TextStyle(fontSize: 15.sp),
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
