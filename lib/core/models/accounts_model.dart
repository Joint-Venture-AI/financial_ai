import 'dart:convert';
import 'package:intl/intl.dart'; // Import the intl package

class AccountsModel {
  final int totalIncome;
  final int totalExpense;
  final DateTime date; // Store the actual date
  final String dayName; // Store the derived day name

  AccountsModel({
    required this.totalIncome,
    required this.totalExpense,
    required this.date,
    required this.dayName,
  });

  // Factory constructor to create an instance from the *original* JSON structure
  factory AccountsModel.fromJson(Map<String, dynamic> json) {
    // Extract top-level income and expense
    int income = json['totalIncome'] as int? ?? 0;
    int expense = json['totalExpense'] as int? ?? 0;

    // --- Date and Day Name Extraction ---
    DateTime transactionDate = DateTime.now(); // Default if no details found
    String dayOfWeek = DateFormat(
      'EEEE',
    ).format(transactionDate); // Default ('EEEE' gives full name like 'Sunday')

    // Try to get the date from the first detail
    var detailsList = json['details'] as List<dynamic>?;
    if (detailsList != null && detailsList.isNotEmpty) {
      var firstDetail = detailsList[0] as Map<String, dynamic>?;
      if (firstDetail != null) {
        String? createdAtString = firstDetail['createdAt'] as String?;
        if (createdAtString != null) {
          try {
            // Parse the date string
            transactionDate = DateTime.parse(createdAtString);
            // Format to get the day name
            dayOfWeek = DateFormat('EEEE').format(transactionDate);
          } catch (e) {
            // Handle potential parsing errors, keep the default
            print("Error parsing date: $e. Using default date.");
          }
        }
      }
    }
    // --- End Date and Day Name Extraction ---

    return AccountsModel(
      totalIncome: income,
      totalExpense: expense,
      date: transactionDate,
      dayName: dayOfWeek,
    );
  }

  // Optional: Method to convert the simplified instance back to JSON
  Map<String, dynamic> toJson() {
    return {
      'totalIncome': totalIncome,
      'totalExpense': totalExpense,
      // Store date in a standard format
      'date': date.toIso8601String(),
      'dayName': dayName,
    };
  }

  // Helper function to decode JSON string directly
  static AccountsModel fromJsonString(String jsonString) {
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    return AccountsModel.fromJson(jsonMap);
  }

  // Helper function to encode to JSON string directly
  String toJsonString() {
    return json.encode(toJson());
  }

  @override
  String toString() {
    return 'FinanceSnapshot(totalIncome: $totalIncome, totalExpense: $totalExpense, date: ${DateFormat('yyyy-MM-dd').format(date)}, dayName: $dayName)';
  }
}
