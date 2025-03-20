import 'package:get/get.dart';

class PaymentController extends GetxController {
  RxInt selectedCardIndex = 0.obs; // Default selected card
  RxBool isCardSelected = true.obs; // Default: Card selected

  final List<Map<String, String>> cards = [
    {"type": "mastercard", "last4": "2541"},
    {"type": "visa", "last4": "2029"},
    {"type": "mastercard", "last4": "2645"},
  ];

  void selectCard(int index) {
    selectedCardIndex.value = index;
  }

  void togglePaymentMethod(bool isCard) {
    isCardSelected.value = isCard;
  }
}
