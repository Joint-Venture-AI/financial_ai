import 'dart:convert';

import 'package:financial_ai_mobile/core/models/income_expense_model.dart'; // Ensure this path is correct
import 'package:financial_ai_mobile/core/services/api_services.dart'; // Ensure this path is correct
import 'package:financial_ai_mobile/core/utils/api_endpoint.dart'; // Ensure this path is correct
import 'package:get/get.dart';

class AccountsController extends GetxController {
  var accountTab = ['Income', 'Expense'].obs;
  var selectedTab = 'Income'.obs;

  // todayDate is declared but not explicitly used in API calls in the provided snippet.
  // If your ApiServices().getUserData needs it, you'll have to pass it.
  var todayDate = DateTime.now().toString();

  RxList<IncomeExpenseModel> incomeData = <IncomeExpenseModel>[].obs;
  RxList<IncomeExpenseModel> expenseData = <IncomeExpenseModel>[].obs;
  var isLoadingIncome = false.obs;
  var isLoadingExpense = false.obs;
  var incomeError = ''.obs;
  var expenseError = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDataForSelectedTab(); // Fetch data for the initial tab

    // Listen to tab changes to fetch data accordingly
    ever(selectedTab, (_) => fetchDataForSelectedTab());
  }

  void fetchDataForSelectedTab() {
    if (selectedTab.value == 'Income') {
      getTodayUserData(isIncome: true);
    } else {
      getTodayUserData(isIncome: false);
    }
  }

  Future<void> getTodayUserData({required bool isIncome}) async {
    if (isIncome) {
      isLoadingIncome.value = true;
      incomeError.value = '';
    } else {
      isLoadingExpense.value = true;
      expenseError.value = '';
    }
    update();

    try {
      final response = await ApiServices().getUserData(
        isIncome ? ApiEndpoint.getDailyIncome : ApiEndpoint.getDailyExpense,
      );
      final body = jsonDecode(response.body);

      Get.log(
        'API Response for ${isIncome ? 'Income' : 'Expense'}: ${response.statusCode}\nBody: ${response.body}',
        isError: response.statusCode != 200 || body['success'] != true,
      );

      if (response.statusCode == 200 && body['success'] == true) {
        // 1. Check if 'data' array exists and is not empty
        if (body['data'] != null &&
            body['data'] is List &&
            (body['data'] as List).isNotEmpty) {
          // 2. Access the first element of the 'data' array, which is a Map
          var dailyDataObject = (body['data'] as List)[0];
          if (dailyDataObject is Map<String, dynamic>) {
            // 3. Determine the key for the details list ('incomeDetails' or 'expenseDetails')
            String detailsKey = isIncome ? 'incomeDetails' : 'expenseDetails';

            // 4. Check if the detailsKey exists and its value is a List
            if (dailyDataObject[detailsKey] != null &&
                dailyDataObject[detailsKey] is List) {
              List<dynamic> rawItemsList =
                  dailyDataObject[detailsKey] as List<dynamic>;
              List<IncomeExpenseModel> tempData = [];
              bool parsingErrorOccurred = false;

              if (rawItemsList.isEmpty) {
                String msg =
                    'No ${isIncome ? 'income' : 'expense'} details found for today.';
                if (isIncome) {
                  incomeData.clear();
                  incomeError.value = msg;
                } else {
                  expenseData.clear();
                  expenseError.value = msg;
                }
                Get.log(msg);
              } else {
                for (var item in rawItemsList) {
                  if (item is Map<String, dynamic>) {
                    try {
                      tempData.add(IncomeExpenseModel.fromJson(item));
                    } catch (e, s) {
                      parsingErrorOccurred = true;
                      Get.log(
                        'Error parsing ${isIncome ? 'income' : 'expense'} item: $item\nError: $e\nStackTrace: $s',
                        isError: true,
                      );
                    }
                  } else {
                    parsingErrorOccurred = true;
                    Get.log(
                      'Skipping invalid ${isIncome ? 'income' : 'expense'} item (not a Map): $item',
                      isError: true,
                    );
                  }
                }

                // Update data and error messages based on parsing results
                if (tempData.isEmpty && rawItemsList.isNotEmpty) {
                  // All items failed parsing
                  String msg =
                      'Could not parse any ${isIncome ? 'income' : 'expense'} items. Check item structure and model.';
                  if (isIncome) {
                    incomeData.clear();
                    incomeError.value = msg;
                  } else {
                    expenseData.clear();
                    expenseError.value = msg;
                  }
                  Get.log(msg, isError: true);
                } else {
                  // Some or all items parsed successfully
                  if (isIncome) {
                    incomeData.value = tempData;
                    if (parsingErrorOccurred && tempData.isNotEmpty) {
                      incomeError.value =
                          'Some income items had parsing issues. Displaying successfully parsed items.';
                    } else {
                      incomeError.value = '';
                    }
                  } else {
                    expenseData.value = tempData;
                    if (parsingErrorOccurred && tempData.isNotEmpty) {
                      expenseError.value =
                          'Some expense items had parsing issues. Displaying successfully parsed items.';
                    } else {
                      expenseError.value = '';
                    }
                  }
                  Get.log(
                    'Successfully processed ${tempData.length} out of ${rawItemsList.length} ${isIncome ? 'income' : 'expense'} items.',
                  );
                }
              }
            } else {
              // The 'expenseDetails' or 'incomeDetails' key is missing or not a list
              String msg =
                  'No "${isIncome ? 'incomeDetails' : 'expenseDetails'}" list found in the API response data.';
              if (isIncome) {
                incomeData.clear();
                incomeError.value = msg;
              } else {
                expenseData.clear();
                expenseError.value = msg;
              }
              Get.log(
                msg + ' Daily Data Object: $dailyDataObject',
                isError: true,
              );
            }
          } else {
            // The first element of 'data' is not a Map
            String msg =
                'API response data item is not in the expected format (should be a Map).';
            if (isIncome) {
              incomeData.clear();
              incomeError.value = msg;
            } else {
              expenseData.clear();
              expenseError.value = msg;
            }
            Get.log(msg + ' First data item: $dailyDataObject', isError: true);
          }
        } else {
          // 'data' array is null, empty, or not a list
          String msg =
              'No ${isIncome ? 'income' : 'expense'} data available or API data structure is unexpected.';
          if (isIncome) {
            incomeData.clear();
            incomeError.value = msg;
          } else {
            expenseData.clear();
            expenseError.value = msg;
          }
          Get.log(msg + ' Body: ${response.body}', isError: true);
        }
      } else {
        // Non-200 status code or success: false
        String errorMessage =
            body['message'] ??
            'Failed to fetch data. Status code: ${response.statusCode}';
        if (isIncome) {
          incomeData.clear();
          incomeError.value = errorMessage;
        } else {
          expenseData.clear();
          expenseError.value = errorMessage;
        }
        Get.log(
          '${isIncome ? 'Income' : 'Expense'} API Error: $errorMessage',
          isError: true,
        );
      }
    } catch (e, stackTrace) {
      String errorMsg = 'An unexpected error occurred: $e';
      if (e is FormatException) {
        errorMsg = 'Error decoding API response. Ensure valid JSON. ($e)';
      }
      if (isIncome) {
        incomeData.clear();
        incomeError.value = errorMsg;
      } else {
        expenseData.clear();
        expenseError.value = errorMsg;
      }
      Get.log(
        'Critical error fetching ${isIncome ? 'income' : 'expense'} data: $e\nStackTrace: $stackTrace',
        isError: true,
      );
    } finally {
      if (isIncome) {
        isLoadingIncome.value = false;
      } else {
        isLoadingExpense.value = false;
      }
      update();
    }
  }
}
