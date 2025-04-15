import 'dart:convert';

import 'package:financial_ai_mobile/core/models/accounts_model.dart';
import 'package:financial_ai_mobile/core/models/income_expense_model.dart';
import 'package:financial_ai_mobile/core/services/api_services.dart';
import 'package:financial_ai_mobile/core/utils/api_endpoint.dart';
import 'package:financial_ai_mobile/core/utils/global_base.dart';
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

  RxList<AccountsModel> accountsModel = <AccountsModel>[].obs;

  var isLoading = false.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getAccountsData(ApiEndpoint.getDaily);
  }

  ///get usre all account data
  Future<void> getAccountsData(String endPoint) async {
    try {
      isLoading.value = true;
      final response = await ApiServices().getUserData(endPoint);
      final body = jsonDecode(response.body);
      printInfo(info: '=====>>>>> ${body['data']}}');
      accountsModel.clear();
      if (response.statusCode == 200) {
        for (var data in body['data']) {
          accountsModel.add(AccountsModel.fromJson(data));
        }
      }
    } catch (e) {
      throw Exception('====>>>>>>>>>error $e');
    } finally {
      isLoading.value = false;
    }
  }
}
