import 'dart:convert';
import 'package:financial_ai_mobile/core/models/accounts_model.dart';
import 'package:financial_ai_mobile/core/services/api_services.dart';
import 'package:financial_ai_mobile/core/utils/api_endpoint.dart';
import 'package:get/get.dart';

class AccountsTabController extends GetxController {
  var accountTab = ['All', 'Cash', 'Card'].obs;
  var timeSchedule = ['Daily', 'Weekly'].obs;

  var selectedAccountTab = 'All'.obs;
  var selectedTimeScheduleTab = 'Daily'.obs;

  // Renamed for clarity, still holds AccountsModel instances
  RxList<AccountsModel> accountsDisplayModel = <AccountsModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Initial data load
    fetchData();

    // Listen to changes in selectedTimeScheduleTab
    ever(selectedTimeScheduleTab, (_) {
      printInfo(
        info: 'Time schedule changed to: ${selectedTimeScheduleTab.value}',
      );
      fetchData();
    });

    // Listen to changes in selectedAccountTab
    ever(selectedAccountTab, (_) {
      printInfo(info: 'Account tab changed to: ${selectedAccountTab.value}');
      fetchData();
    });
  }

  String _buildEndpoint() {
    String baseEndpoint;
    if (selectedTimeScheduleTab.value == 'Daily') {
      baseEndpoint = ApiEndpoint.getDaily;
    } else if (selectedTimeScheduleTab.value == 'Weekly') {
      baseEndpoint = ApiEndpoint.getWeek;
    } else {
      // Fallback or error
      printError(
        info: 'Unknown time schedule: ${selectedTimeScheduleTab.value}',
      );
      baseEndpoint = ApiEndpoint.getDaily; // Defaulting to daily
    }

    // Append query parameters if 'Cash' or 'Card' tab is selected
    // The user specified the query string starts with "/?"
    // This assumes baseEndpoint is like "path/to/resource"
    // and the result should be "path/to/resource/?page=1&method=cash"
    if (selectedAccountTab.value == 'Cash') {
      return "$baseEndpoint/?page=1&method=cash";
    } else if (selectedAccountTab.value == 'Card') {
      return "$baseEndpoint/?page=1&method=card";
    }

    // For 'All' tab, use the base endpoint without additional method filters
    return baseEndpoint;
  }

  /// Fetches data based on current selections
  Future<void> fetchData() async {
    final String endpoint = _buildEndpoint();
    try {
      isLoading.value = true;
      printInfo(info: 'Fetching accounts data from endpoint: $endpoint');
      final response = await ApiServices().getUserData(endpoint);
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        printInfo(info: 'API Response (200) for $endpoint: ${body['data']}');
        accountsDisplayModel.clear(); // Clear previous data
        if (body['data'] != null && body['data'] is List) {
          for (var data in body['data']) {
            // This assumes that ALL endpoints (daily, weekly, all, cash, card)
            // return data that can be parsed into AccountsModel.
            accountsDisplayModel.add(AccountsModel.fromJson(data));
          }
        } else {
          printError(
            info:
                'Data field is null or not a list in API response for $endpoint',
          );
          accountsDisplayModel
              .clear(); // Ensure list is empty if data is not as expected
        }
      } else {
        printError(
          info:
              'API Error for $endpoint: ${response.statusCode} - ${response.body}',
        );
        accountsDisplayModel.clear(); // Clear on error
      }
    } catch (e) {
      printError(info: 'Exception during fetchData for $endpoint: $e');
      accountsDisplayModel.clear(); // Clear on exception
    } finally {
      isLoading.value = false;
    }
  }
}
