import 'dart:convert';

import 'package:financial_ai_mobile/core/models/income_expense_model.dart';
import 'package:financial_ai_mobile/core/services/api_services.dart';
import 'package:financial_ai_mobile/core/utils/api_endpoint.dart';
import 'package:financial_ai_mobile/views/screens/accounts/components/card_tab_section.dart';
import 'package:financial_ai_mobile/views/screens/accounts/components/cash_tab_section.dart';
import 'package:financial_ai_mobile/views/screens/accounts/components/tab_all_section.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class AccountsTabController extends GetxController {
  var accountTab = ['All', 'Cash', 'Card'].obs;
  var timeSchedule = ['Daily', 'Weekly'].obs;

  var selectedAccountTab = 'All'.obs;
  var selectedTimeScheduleTab = 'Daily'.obs;

  Future<void> getAccountsData(String endPoint) async {
    try {
      final response = await ApiServices().getUserData(endPoint);
      final data = jsonDecode(response.body);
    } catch (e) {
      throw Exception('error $e');
    }
  }
}
