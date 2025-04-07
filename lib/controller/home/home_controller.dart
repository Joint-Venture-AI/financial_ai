import 'dart:convert';
import 'dart:math';
import 'package:financial_ai_mobile/core/services/api_services.dart';
import 'package:financial_ai_mobile/core/utils/api_endpoint.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  var availableBalancePer = 0.0.obs; // Changed to RxDouble
  var espenseBalancePer = 0.0.obs; // Changed to RxDouble

  var totalIncome = 0.obs;
  var totalExpense = 0.0.obs;
  var availableMoney = 0.0.obs;
  var todayExpense = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getUserPresentMonthData();
  }

  Future<void> getUserPresentMonthData() async {
    try {
      isLoading.value = true;
      final response = await ApiServices().getUserData(
        ApiEndpoint.getPresentMonth,
      );
      final data = json.decode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        final presentData = data['data'];

        totalIncome.value = presentData['totalIncome'];
        totalExpense.value = presentData['totalExpense'].toDouble();
        availableMoney.value = presentData['availableMoney'].toDouble();
        todayExpense.value = presentData['todayExpense'];
        espenseBalancePer.value = presentData['expensePercentage'].toDouble();
        availableBalancePer.value =
            presentData['availablePercentage'].toDouble();
      } else {
        printError(info: 'Failed to fetch user data: ${response.statusCode}');
      }
    } catch (e) {
      printError(info: 'Error occurred while fetching user data: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
