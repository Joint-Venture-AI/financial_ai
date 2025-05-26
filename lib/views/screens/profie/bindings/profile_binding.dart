import 'package:financial_ai_mobile/views/screens/profie/controller/bank_controller.dart';
import 'package:get/get.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BankController());
  }
}
