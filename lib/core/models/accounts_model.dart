class AccountsModel {
  final double income;
  final double expense;
  final String day;
  final todayDate;

  const AccountsModel({
    required this.income,
    required this.expense,
    required this.day,
    required this.todayDate,
  });

  factory AccountsModel.fromJson(Map<String, dynamic> json) {
    return AccountsModel(
      income: json['income'],
      expense: json['expense'],
      day: json['day'],
      todayDate: json['todayDate'],
    );
  }
  Map<String, dynamic> updateData() {
    return {
      'income': income,
      'expense': expense,
      'day': day,
      'today': todayDate,
    };
  }
}
