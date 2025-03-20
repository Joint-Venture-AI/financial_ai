import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddDataController extends GetxController {
  var selectedTab = 'Income'.obs;

  var selectedIncomeCategory = 'Add your purpose'.obs;
  var selectedExpenseCategory = 'Add your purpose'.obs;
  var selectedPayMethod = 'Pay method'.obs;
  final ImagePicker picker = ImagePicker();
  RxList<XFile> images = <XFile>[].obs; // Use RxList for reactivity

  Future<void> imageChoser() async {
    try {
      final pickedImages = await picker.pickMultiImage();
      // ignore: unnecessary_null_comparison
      if (pickedImages != null) {
        images.addAll(pickedImages); // Add new images to the list
      }
    } catch (e) {
      debugPrint('==================>>>>>>>>>>>>>>$e');
    }
  }

  void removeImage(int index) {
    images.removeAt(index);
  }

  void updateSelectedIncomeCategory(String category) {
    selectedIncomeCategory.value = category;
  }

  void updateSelectedPayMethod(String method) {
    selectedPayMethod.value = method;
  }
}
