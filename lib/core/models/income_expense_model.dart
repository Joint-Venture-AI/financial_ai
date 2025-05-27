class IncomeExpenseModel {
  final int amount;
  final String source;
  final String method;
  final String note;
  final DateTime createdAt; // Add this line

  IncomeExpenseModel({
    required this.amount,
    required this.source,
    required this.method,
    required this.note,
    required this.createdAt, // Add this line
  });

  factory IncomeExpenseModel.fromJson(Map<String, dynamic> json) {
    // 1. Handle 'amount' parsing robustly
    int parsedAmount;
    dynamic rawAmount = json['amount'];
    if (rawAmount == null) {
      parsedAmount = 0;
    } else if (rawAmount is String) {
      parsedAmount = int.tryParse(rawAmount) ?? 0;
    } else if (rawAmount is num) {
      parsedAmount = rawAmount.toInt();
    } else {
      parsedAmount = 0;
    }

    // 2. Determine the 'source' value
    String sourceValue;
    if (json['source'] != null &&
        json['source'] is String &&
        (json['source'] as String).isNotEmpty) {
      sourceValue = json['source'] as String;
    } else if (json['category'] != null &&
        json['category'] is String &&
        (json['category'] as String).isNotEmpty) {
      sourceValue = json['category'] as String;
    } else {
      sourceValue = 'Unknown Source/Category';
    }

    // 3. Handle 'method' and 'note'
    String methodValue = json['method'] as String? ?? 'Unknown Method';
    if (methodValue.isEmpty) {
      methodValue = 'Unknown Method';
    }
    String noteValue = json['note'] as String? ?? '';

    // 4. Parse 'createdAt'
    DateTime createdAtValue;
    if (json['createdAt'] != null && json['createdAt'] is String) {
      try {
        createdAtValue = DateTime.parse(json['createdAt'] as String);
      } catch (e) {
        // Fallback if parsing fails, though ideally the API sends a valid ISO 8601 string
        createdAtValue = DateTime.now();
        print(
          "Error parsing createdAt: ${json['createdAt']}, using current time. Error: $e",
        );
      }
    } else {
      // Fallback if 'createdAt' is missing or not a string
      createdAtValue = DateTime.now();
      print("createdAt field missing or not a string, using current time.");
    }

    return IncomeExpenseModel(
      amount: parsedAmount,
      source: sourceValue,
      method: methodValue,
      note: noteValue,
      createdAt: createdAtValue, // Add this line
    );
  }
}
