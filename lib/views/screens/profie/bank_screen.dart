// In a file like: lib/views/screens/profie/bank_screen.dart
import 'package:financial_ai_mobile/views/screens/profie/controller/bank_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// Import your transaction item model if you need to access its properties directly
// import '../../../../models/bank_models.dart'; // Adjust path

class BankScreen extends StatelessWidget {
  BankScreen({super.key});

  // Initialize or find your controller.
  // Using Get.put() here will create a new instance if one doesn't exist.
  // If you manage bindings elsewhere, Get.find<BankController>() is appropriate.
  final BankController bankController = Get.put(BankController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Bank Details'), centerTitle: true),
      body: Obx(() {
        // Use Obx to listen to observable changes
        if (bankController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (bankController.errorMessage.value.isNotEmpty &&
            bankController.transactions.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                ' ${bankController.errorMessage.value}',
                style: const TextStyle(fontSize: 18, color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }
        if (bankController.transactions.isEmpty) {
          return const Center(
            child: Text(
              'No transactions to display. Tap "View Transactions".',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          );
        }

        // Display the list of transactions
        return ListView.builder(
          itemCount: bankController.transactions.length,
          itemBuilder: (context, index) {
            // In BankScreen.dart, inside ListView.builder:
            final transaction = bankController.transactions[index];
            return Card(
              key: ValueKey(
                transaction.id,
              ), // Good practice to add a key if 'id' is available
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(
                    transaction.currencyCode,
                  ), // Directly access from transaction
                ),
                title: Text(transaction.descriptionDisplay), // Directly access
                subtitle: Text(
                  'Status: ${transaction.status} \nCreated: ${transaction.createdAt.toLocal().toString().substring(0, 16)}', // Directly access
                ),
                trailing: Text(
                  transaction.actualAmount.toStringAsFixed(
                    2,
                  ), // Directly access
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:
                        transaction.actualAmount < 0
                            ? Colors.red
                            : Colors.green,
                  ),
                ),
                isThreeLine: true,
              ),
            );
          },
        );
      }),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    bankController.bankAuthentication();
                  },
                  child: const Text('Add Bank'),
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Call the method to fetch transactions
                    bankController.fetchBankTransactions();
                  },
                  child: const Text('View Transactions'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
