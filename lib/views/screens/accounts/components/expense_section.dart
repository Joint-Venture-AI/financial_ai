// import 'package:financial_ai_mobile/controller/home/accounts_controller.dart';
// import 'package:financial_ai_mobile/core/models/income_expense_model.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart'; // For date formatting

// class ExpenseSection extends StatelessWidget {
//   final AccountsController controller; // Receive the controller

//   const ExpenseSection({super.key, required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     // Use Obx to react to changes in controller's state
//     return Obx(() {
//       if (controller.isLoadingExpense.value) {
//         return const Center(child: CircularProgressIndicator());
//       }

//       if (controller.expenseError.value != null) {
//         return Center(
//           child: Text(
//             'Error loading expenses: ${controller.expenseError.value}',
//             style: const TextStyle(color: Colors.red),
//             textAlign: TextAlign.center,
//           ),
//         );
//       }

//       if (controller.expenseData.isEmpty) {
//         return const Center(child: Text('No expenses recorded for today.'));
//       }

//       // Display the list of expense transactions
//       return ListView.builder(
//         shrinkWrap: true, // Important inside SingleChildScrollView
//         physics:
//             const NeverScrollableScrollPhysics(), // Disable scrolling if parent scrolls
//         itemCount: controller.expenseData.length,
//         itemBuilder: (context, index) {
//           final IncomeExpenseModel item = controller.expenseData[index];
//           return Card(
//             // Example: Display each item in a Card
//             margin: const EdgeInsets.symmetric(vertical: 5.0),
//             child: ListTile(
//               leading: const Icon(Icons.arrow_upward, color: Colors.red),
//               title: Text(item.note ?? 'Expense'),
//               subtitle: Text(
//                 '${item.descriptionInfo ?? ''}\n${DateFormat.yMd().add_jm().format(item.createdAt.toLocal())}', // Format date/time
//               ),
//               trailing: Text(
//                 '-\$${item.amount.toStringAsFixed(2)}',
//                 style: const TextStyle(
//                   color: Colors.red,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               isThreeLine: (item.descriptionInfo ?? '').isNotEmpty,
//             ),
//           );
//         },
//       );
//     });
//   }
// }
