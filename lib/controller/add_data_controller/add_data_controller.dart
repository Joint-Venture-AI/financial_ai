import 'dart:convert';
import 'dart:io';
import 'package:financial_ai_mobile/controller/home/home_controller.dart';
import 'package:financial_ai_mobile/core/services/pref_helper.dart';
import 'package:financial_ai_mobile/core/utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

import 'package:financial_ai_mobile/core/services/api_services.dart';
import 'package:financial_ai_mobile/core/utils/api_endpoint.dart';
import 'package:financial_ai_mobile/core/utils/global_base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart'; // Import MediaType

class AddDataController extends GetxController {
  var selectedTab = 'Income'.obs;
  var isVoiceEnable = false.obs;
  var spechText = 'Listenting...'.obs;
  var selectedIncomeCategory = 'Add your purpose'.obs;
  var selectedExpenseCategory = 'Add your purpose'.obs;
  var selectedPayMethod = 'Pay method'.obs;
  final ImagePicker picker = ImagePicker();
  RxList<XFile> images = <XFile>[].obs; // Use RxList for reactivity

  // Reactive date-time variable
  final Rx<DateTime> selectedDateTime = DateTime.now().obs;

  final isLoading = false.obs;

  final amountController = TextEditingController();
  final noteController = TextEditingController();
  final descriptionController = TextEditingController();

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

  Future<void> addIncomeData(bool isIncome) async {
    if (images.isEmpty) {
      GlobalBase.showToast('Please select at least one image', true);
      return;
    }
    if (amountController.text.isEmpty) {
      GlobalBase.showToast('Please enter an amount', true);
      return;
    }
    if ((isIncome
            ? selectedIncomeCategory.value
            : selectedExpenseCategory.value) ==
        'Add your purpose') {
      GlobalBase.showToast('Please select a category', true);
      return;
    }
    if (selectedPayMethod.value == 'Pay method') {
      GlobalBase.showToast('Please select a payment method', true);
      return;
    }
    if (noteController.text.isEmpty) {
      GlobalBase.showToast('Please enter a note', true);
      return;
    }
    if (descriptionController.text.isEmpty) {
      GlobalBase.showToast('Please enter a description', true);
      return;
    }
    if (selectedDateTime.value == null) {
      GlobalBase.showToast('Please select a date and time', true);
      return;
    }

    final uri = Uri.parse(
      isIncome ? ApiEndpoint.addIncomeData : ApiEndpoint.addExpenseData,
    ); // your endpoint
    final request = http.MultipartRequest('POST', uri);
    final token = await PrefHelper.getString(Utils.TOKEN);

    try {
      isLoading.value = true;
      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Content-Type': 'multipart/form-data', // optional, usually inferred
      });

      for (var image in images) {
        final mimeType = lookupMimeType(image.path); // e.g. image/png
        final file = await http.MultipartFile.fromPath(
          'images',
          image.path,
          contentType: mimeType != null ? MediaType.parse(mimeType) : null,
        );
        request.files.add(file);
      }
      // Add the 'data' as a stringified JSON
      final Map<String, dynamic> dataMap = {
        "amount": int.parse(amountController.text),

        isIncome ? "source" : "category":
            isIncome
                ? selectedIncomeCategory.value
                : selectedExpenseCategory.value,
        "method": selectedPayMethod.value,
        "note": noteController.text,
        "description": {"info": descriptionController.text},
      };

      printError(info: dataMap.toString());

      request.fields['data'] = jsonEncode(dataMap);

      final streamedResponse = await request.send();
      printError(info: request.fields.toString());
      final response = await http.Response.fromStream(streamedResponse);
      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        GlobalBase.showToast('Success : ${data['message']}', false);
        Get.find<HomeController>().getUserPresentMonthData();
        amountController.clear();
        noteController.clear();
        descriptionController.clear();
        selectedIncomeCategory.value = 'Add your purpose';
        selectedPayMethod.value = 'Pay method';
        selectedDateTime.value = DateTime.now();
        images.clear(); // Clear the images after successful upload
        debugPrint('✅ Income data added: ${data['message']}');
      } else if (response.statusCode == 500 &&
          data['message'] == "Update your Expense plan first.") {
        AlertDialog alert = AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          title: const Text('Error'),
          content: const Text('Update your Expense plan first.'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('OK'),
            ),
          ],
        );
        showDialog(
          context: Get.context!,
          builder: (BuildContext context) {
            return alert;
          },
        );
      }
    } catch (e) {
      GlobalBase.showToast('Failed to add income: $e', true);

      debugPrint('🔥 Error sending income data: $e');
    } finally {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Check if the controller is still mounted/initialized before updating state.
        // This is good practice if the screen might be disposed before this callback runs.
        if (!isClosed) {
          isLoading.value = false;
        }
      });
    }
  }
}
