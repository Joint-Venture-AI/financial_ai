import 'package:financial_ai_mobile/core/services/api_services.dart';
import 'package:financial_ai_mobile/core/utils/api_endpoint.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;

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
      final data = response.body;
      printInfo(info: data);
    } catch (e) {
      printError(info: 'Error occurred while fetching user data: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
