import 'package:financial_ai_mobile/core/services/api_services.dart';
import 'package:financial_ai_mobile/core/utils/api_endpoint.dart';
import 'package:financial_ai_mobile/views/screens/home/subs_screen/accounts/components/expense_section.dart';
import 'package:financial_ai_mobile/views/screens/home/subs_screen/accounts/components/income_section.dart';
import 'package:get/get.dart';

class AccountsController extends GetxController {
  var accountTab = ['Income', 'Expense'].obs;
  var selectedTab = 'Income'.obs;
  var selectedIndexTab = 0.obs;
  var tabListWidget = [IncomeSection(), ExpenseSection()].obs;
}
