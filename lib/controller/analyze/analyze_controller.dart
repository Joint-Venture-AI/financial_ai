import 'dart:convert';

import 'package:financial_ai_mobile/core/models/expense_category_model.dart';
import 'package:financial_ai_mobile/core/services/api_services.dart';
import 'package:financial_ai_mobile/core/utils/api_endpoint.dart';
// Ensure this import points to your AnalyzeExpenseSection if it's in a different directory structure than assumed.
// Typically, a controller wouldn't directly import a View like this, but it's used for tabListWidget.
// For this specific case of tabListWidget, it might be okay, but generally, Views depend on Controllers, not the other way.
import 'package:financial_ai_mobile/views/screens/analyze/components/analyze_expense_section.dart';
import 'package:get/get.dart';

class AnalyzeController extends GetxController {
  var accountTab = ['Income', 'Expense'].obs;

  RxList<ExpenseCategory> expenseCategoryList = <ExpenseCategory>[].obs;

  ///add balance
  var selectedTab = 'Income'.obs;

  ///tab selected value
  var selectedIndexTab = 0.obs;

  ///selected index of tab
  // Consider if AnalyzeIncomeSection() should be different for 'Income'
  var tabListWidget = [AnalyzeExpenseSection(), AnalyzeExpenseSection()].obs;

  // Added for loading state
  var isLoading = false.obs;

  // These seem specific to UI toggles, which is fine in GetX controller
  var showHousingDetails = false.obs;
  var showTransportationDetails = false.obs;
  var showFoodDetails = false.obs;

  @override
  void onInit() {
    super.onInit();
    // No need to 'await' here as onInit is synchronous.
    // getReportCategory is async, its execution will continue.
    getReportCategory();
  }

  Future<void> getReportCategory() async {
    try {
      isLoading.value = true; // Set loading to true
      final response = await ApiServices().getUserData(
        ApiEndpoint.getReportCategory,
      );
      var body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        var data =
            body['data'] as List<dynamic>?; // Make data potentially nullable
        if (data != null) {
          print('===========>>>>>>>>expenseCategoryList (raw data): $data');
          // The .cast<ExpenseCategory>() is redundant if .map already produces List<ExpenseCategory>
          expenseCategoryList.assignAll(
            data.map((item) => ExpenseCategory.fromJson(item)).toList(),
          );
          print(
            '===========>>>>>>>>expenseCategoryList (parsed): ${expenseCategoryList.length} items',
          );
        } else {
          expenseCategoryList.clear(); // Clear list if data is null
          print('Error: Data from API was null.');
          // Optionally, show a user-friendly error message via a snackbar or another observable state
        }
      } else {
        // Handle error response
        expenseCategoryList.clear(); // Clear list on error
        print(
          'Error fetching report categories: ${response.statusCode}, Body: ${response.body}',
        );
        // Optionally, show a user-friendly error message
      }
    } catch (e) {
      expenseCategoryList.clear(); // Clear list on exception
      // Handle any exceptions that occur during the API call
      printError(info: 'Exception in getReportCategory: $e');
      // Optionally, show a user-friendly error message
    } finally {
      isLoading.value = false; // Set loading to false in finally block
    }
  }
}
