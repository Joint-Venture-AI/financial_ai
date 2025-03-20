import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddDataController extends GetxController {
  var selectedTab = 'Income'.obs;

  var selectedIncomeCategory = 'Add your purpose'.obs;
  var selectedExpenseCategory = 'Add your purpose'.obs;
  var selectedPayMethod = 'Pay method'.obs;
  final ImagePicker picker = ImagePicker();
  RxList<XFile> images = <XFile>[].obs; // Use RxList for reactivity
  // Reactive date-time variable
  final Rx<DateTime> selectedDateTime = DateTime.now().obs;

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

  /// Function to pick date and time
  Future<void> pickDateTime(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime.value),
      );

      if (pickedTime != null) {
        selectedDateTime.value = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      }
    }
  }

  /// Formatted Date-Time String
  String get formattedDateTime =>
      DateFormat('MMM dd, yyyy  hh:mm a').format(selectedDateTime.value);
}
