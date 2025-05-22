class ExpenseCategory {
  final String id;
  final double totalExpense;
  final String category;
  final int percent;

  ExpenseCategory({
    required this.id,
    required this.totalExpense,
    required this.category,
    required this.percent,
  });

  factory ExpenseCategory.fromJson(Map<String, dynamic> json) {
    return ExpenseCategory(
      id: json['_id'] as String,
      totalExpense: (json['totalExpense'] as num).toDouble(),
      category: json['category'] as String,
      percent: json['percent'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'totalExpense': totalExpense,
      'category': category,
      'percent': percent,
    };
  }
}
