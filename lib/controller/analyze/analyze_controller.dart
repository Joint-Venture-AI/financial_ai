import 'package:financial_ai_mobile/views/screens/analyze/components/analyze_expense_section.dart';
import 'package:financial_ai_mobile/views/screens/home/subs_screen/accounts/components/expense_section.dart';
import 'package:financial_ai_mobile/views/screens/home/subs_screen/accounts/components/income_section.dart';
import 'package:get/get.dart';

class AnalyzeController extends GetxController {
  var accountTab = ['Income', 'Expense'].obs;

  ///add balance
  var selectedTab = 'Income'.obs;

  ///tab selected value
  var selectedIndexTab = 0.obs;

  ///selected index of tab
  var tabListWidget = [AnalyzeExpenseSection(), AnalyzeExpenseSection()].obs;

  var showHousingDetails = false.obs;
  var showTransportationDetails = false.obs;
  var showFoodDetails = false.obs;
}
