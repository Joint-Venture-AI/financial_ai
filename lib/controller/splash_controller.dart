import 'package:financial_ai_mobile/core/services/pref_helper.dart';
import 'package:financial_ai_mobile/core/utils/app_routes.dart';
import 'package:financial_ai_mobile/core/utils/utils.dart';
import 'package:financial_ai_mobile/views/screens/bottom_nav/tab_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    // Add any initialization logic here if needed
    initUser();
  }

  Future<void> initUser() async {
    try {
      final isNewUser = await getUser();
      if (isNewUser) {
        // Navigate to onboarding screen
        Get.offNamed(AppRoutes.onBoarding);
      } else {
        // Navigate to home screen
        Get.offAll(() => MainScreen());
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  Future<bool> getUser() async {
    try {
      final token = await PrefHelper.getString(Utils.TOKEN);
      if (token == null || token.isEmpty) {
        return true;
      }
      // Perform your logic here
    } catch (e) {
      print('Error occurred: $e');
    }
    return false;
  }

  @override
  void onReady() {
    super.onReady();
    // Add any logic that should run when the controller is ready
  }

  @override
  void onClose() {
    super.onClose();
    // Add any cleanup logic here if needed
  }
}
