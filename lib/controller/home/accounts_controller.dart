import 'dart:convert';

import 'package:financial_ai_mobile/core/models/income_expense_model.dart';
import 'package:financial_ai_mobile/core/services/api_services.dart';
import 'package:financial_ai_mobile/core/utils/api_endpoint.dart';
// Remove unused imports if ExpenseSection/IncomeSection are not directly used here
// import 'package:financial_ai_mobile/views/screens/home/subs_screen/accounts/components/expense_section.dart';
// import 'package:financial_ai_mobile/views/screens/home/subs_screen/accounts/components/income_section.dart';
import 'package:get/get.dart';

class AccountsController extends GetxController {
  var accountTab = ['Income', 'Expense'].obs;
  var selectedTab = 'Income'.obs;
  // Removed selectedIndexTab and tabListWidget as they weren't used effectively
  // var selectedIndexTab = 0.obs;
  // var tabListWidget = [IncomeSection(), ExpenseSection()].obs; // Better to render conditionally in UI

  var todayDate =
      DateTime.now().toString(); // Consider formatting this if needed for API
  RxList<IncomeExpenseModel> incomeData = <IncomeExpenseModel>[].obs;
  RxList<IncomeExpenseModel> expenseData = <IncomeExpenseModel>[].obs;
  var isLoadingIncome = false.obs; // Add loading state for income
  var isLoadingExpense = false.obs; // Add loading state for expense
  var incomeError = ''.obs; // Add error message state
  var expenseError = ''.obs; // Add error message state

  @override
  void onInit() {
    super.onInit();
    // Fetch initial data when the controller is initialized
    fetchDataForSelectedTab();

    // Listen to tab changes to fetch data accordingly
    ever(selectedTab, (_) => fetchDataForSelectedTab());
  }

  // Helper to fetch data based on the currently selected tab
  void fetchDataForSelectedTab() {
    if (selectedTab.value == 'Income') {
      getTodayUserData(true);
    } else {
      getTodayUserData(false);
    }
  }

  Future<void> getTodayUserData(bool isIncome) async {
    // Set loading state and clear previous errors/data
    if (isIncome) {
      isLoadingIncome.value = true;
      incomeError.value = '';
      // Optional: Clear data immediately or only on success
      // incomeData.clear();
    } else {
      isLoadingExpense.value = true;
      expenseError.value = '';
      // Optional: Clear data immediately or only on success
      // expenseData.clear();
    }
    update(); // Notify GetBuilder/Obx if needed immediately

    try {
      final response = await ApiServices().getUserData(
        isIncome ? ApiEndpoint.getDailyIncome : ApiEndpoint.getDailyExpense,
        // Pass any necessary parameters like date or token if ApiServices requires them
      );
      final body = jsonDecode(response.body);

      printInfo(
        info:
            'API Response for ${isIncome ? 'Income' : 'Expense'}: ${response.statusCode} \nBody: ${response.body}',
      ); // Log the full response

      if (response.statusCode == 200 && body['success'] == true) {
        // Check if 'data' array exists and is not empty
        if (body['data'] != null &&
            body['data'] is List &&
            body['data'].isNotEmpty) {
          // Determine the correct key for details based on isIncome
          String detailsKey =
              isIncome
                  ? 'incomeDetails'
                  : 'expenseDetails'; // Adjust 'expenseDetails' if needed

          // Access the first element of the 'data' array
          var dailyData = body['data'][0];

          // Check if the details key exists and the list is not null/empty
          if (dailyData[detailsKey] != null &&
              dailyData[detailsKey] is List &&
              dailyData[detailsKey].isNotEmpty) {
            var detailsList = dailyData[detailsKey] as List; // Cast to List

            // Map the details to your IncomeExpenseModel
            List<IncomeExpenseModel> tempData =
                detailsList.map<IncomeExpenseModel>((item) {
                  // The fromJson factory already handles String/int conversion for amount
                  return IncomeExpenseModel.fromJson(item);
                }).toList();

            // Save data into the appropriate list
            if (isIncome) {
              incomeData.value = tempData;
              printInfo(
                info: 'Successfully parsed ${tempData.length} income items.',
              );
            } else {
              expenseData.value = tempData;
              printInfo(
                info: 'Successfully parsed ${tempData.length} expense items.',
              );
            }
          } else {
            // Handle case where details list is empty or missing
            if (isIncome) {
              incomeData.clear(); // Clear existing data
              incomeError.value = 'No income details found for today.';
              printError(
                info:
                    'No income details found in the response data for key "$detailsKey".',
              );
            } else {
              expenseData.clear(); // Clear existing data
              expenseError.value = 'No expense details found for today.';
              printError(
                info:
                    'No expense details found in the response data for key "$detailsKey".',
              );
            }
          }
        } else {
          // Handle case where 'data' array is empty or null
          if (isIncome) {
            incomeData.clear();
            incomeError.value = 'No income data available for today.';
            printError(
              info: 'API returned empty or null "data" array for income.',
            );
          } else {
            expenseData.clear();
            expenseError.value = 'No expense data available for today.';
            printError(
              info: 'API returned empty or null "data" array for expense.',
            );
          }
        }
      } else {
        // Handle non-200 status code or success: false
        String errorMessage =
            body['message'] ??
            'Failed to fetch data. Status code: ${response.statusCode}';
        if (isIncome) {
          incomeData.clear();
          incomeError.value = errorMessage;
          printError(info: 'Income API Error: $errorMessage');
        } else {
          expenseData.clear();
          expenseError.value = errorMessage;
          printError(info: 'Expense API Error: $errorMessage');
        }
      }
    } catch (e, stackTrace) {
      String errorMsg = 'An unexpected error occurred: $e';
      if (isIncome) {
        incomeData.clear();
        incomeError.value = errorMsg;
      } else {
        expenseData.clear();
        expenseError.value = errorMsg;
      }
      printError(
        info:
            'Error fetching ${isIncome ? 'income' : 'expense'} data: $e\nStackTrace: $stackTrace',
      );
    } finally {
      // Reset loading state
      if (isIncome) {
        isLoadingIncome.value = false;
      } else {
        isLoadingExpense.value = false;
      }
      update(); // Notify GetBuilder/Obx
    }
  }
}
