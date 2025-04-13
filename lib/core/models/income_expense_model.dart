class IncomeExpenseModel {
  final int amount;
  final String source;
  final String method;
  final String note;

  IncomeExpenseModel({
    required this.amount,
    required this.source,
    required this.method,
    required this.note,
  });

  factory IncomeExpenseModel.fromJson(Map<String, dynamic> json) {
    return IncomeExpenseModel(
      amount:
          json['amount'] is String ? int.parse(json['amount']) : json['amount'],
      source: json['source'],
      method: json['method'],
      note: json['note'],
    );
  }
}
