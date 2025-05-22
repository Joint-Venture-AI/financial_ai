import 'dart:convert';

import 'package:financial_ai_mobile/core/models/expense_category_model.dart';
import 'package:financial_ai_mobile/core/services/api_services.dart';
import 'package:financial_ai_mobile/core/utils/api_endpoint.dart';
import 'package:financial_ai_mobile/views/screens/analyze/components/analyze_expense_section.dart';
import 'package:get/get.dart';

class AnalyzeController extends GetxController {
  var accountTab = ['Income', 'Expense'].obs;

  RxList<ExpenseCategory> expenseCategoryList =
      <ExpenseCategory>[].obs; // List of ExpenseCategoryModel

  ///add balance
  var selectedTab = 'Income'.obs;

  ///tab selected value
  var selectedIndexTab = 0.obs;

  ///selected index of tab
  var tabListWidget = [AnalyzeExpenseSection(), AnalyzeExpenseSection()].obs;

  var showHousingDetails = false.obs;
  var showTransportationDetails = false.obs;
  var showFoodDetails = false.obs;

  Future<void> getReportCategory() async {
    try {
      final response = await ApiServices().getUserData(
        ApiEndpoint.getReportCategory,
      );
      var body = jsonDecode(response.body);
      var data = body['data'] as List<dynamic>;
      if (response.statusCode == 200) {
        // Handle the response data
        // Process the data as needed
        print('===========>>>>>>>>Data: $data');
        expenseCategoryList.value =
            data
                .map((item) => ExpenseCategory.fromJson(item))
                .toList()
                .cast<ExpenseCategory>();
      } else {
        // Handle error response
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any exceptions that occur during the API call
      printError(info: 'Error: $e');
    }
  }
}
