import 'dart:convert';

// Ensure your models (ApiResponse, Data, BankDataModel, etc.) are correctly defined
// and apiResponseFromJson is available.
import 'package:financial_ai_mobile/core/models/bank_data_model.dart';
import 'package:financial_ai_mobile/core/services/api_services.dart';
import 'package:financial_ai_mobile/core/utils/api_endpoint.dart';
import 'package:flutter/material.dart'; // For Color, etc. in bottom sheet
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class BankController extends GetxController {
  // For bankAuthentication
  var message = ''.obs;
  var bankUrl = ''.obs;

  // For fetchBankTransactions
  var isLoading = false.obs;
  var transactions = <BankDataModel>[].obs;
  var errorMessage = ''.obs;

  // It's good practice to have a single instance of ApiServices
  // You might provide this via Get.put in your app's bindings or main.dart
  final ApiServices _apiServices = ApiServices();

  @override
  void onInit() {
    super.onInit();
    // Initialize your controller here if needed
  }

  Future<void> bankAuthentication() async {
    // Reset state for a new authentication attempt
    bankUrl.value = '';
    message.value = 'Authenticating...';
    _showAuthBottomSheet(); // Show bottom sheet with loading state

    try {
      // Assuming ApiServices().getUserData returns an object similar to http.Response
      // with 'body' (String) and 'statusCode' (int) properties.
      final responseFromApiService = await _apiServices.getUserData(
        '${ApiEndpoint.baseUrl}/bank/get-bank-list-transection',
        // Note: This endpoint name suggests it's for transactions,
        // ensure it's also the correct one for getting an auth URL.
      );

      final dynamic decodedBody = jsonDecode(responseFromApiService.body);

      if (decodedBody is! Map<String, dynamic>) {
        message.value = 'Bank authentication failed: Invalid response format.';
        return; // The bottom sheet will update via Obx
      }
      final Map<String, dynamic> bodyMap = decodedBody;

      if (responseFromApiService.statusCode == 200 &&
          bodyMap['success'] == true) {
        final dynamic dataField = bodyMap['data'];
        // For authentication, we expect the 'data' field to be a URL string
        if (dataField is String) {
          bankUrl.value = dataField;
          message.value =
              bodyMap['message'] as String? ??
              'Authentication URL ready. Click to open.';
        } else {
          message.value =
              'Bank authentication failed: Expected a URL string in "data", but received different format.';
          print('DEBUG (BankAuth): "data" field was not a String: $dataField');
        }
      } else {
        String apiMsg =
            bodyMap['message'] as String? ?? 'Unknown authentication error';
        message.value =
            'Bank authentication failed (Status ${responseFromApiService.statusCode}): $apiMsg';
      }
    } catch (e, s) {
      print("Error in bankAuthentication: $e\n$s");
      if (e is FormatException) {
        message.value =
            'Bank authentication failed: Could not parse server response.';
      } else {
        message.value = 'Bank authentication failed: ${e.toString()}';
      }
    }
    // The Obx in _showAuthBottomSheet will update with the final message/URL
  }

  Future<void> fetchBankTransactions() async {
    try {
      isLoading(true);
      errorMessage('');
      transactions.clear();

      final String url =
          '${ApiEndpoint.baseUrl}/bank/get-bank-list-transection';
      // Assuming ApiServices().getUserData() returns an object with .body (String) and .statusCode (int)
      final responseFromApiService = await _apiServices.getUserData(url);

      // Use your ApiResponse.fromJson for robust parsing
      // This assumes apiResponseFromJson is correctly defined in your bank_data_model.dart
      final ApiResponse parsedResponse = apiResponseFromJson(
        responseFromApiService.body,
      );

      if (parsedResponse.success && parsedResponse.statusCode == 200) {
        transactions.assignAll(parsedResponse.data.nonCategorised);
        if (transactions.isEmpty &&
            parsedResponse.data.nonCategorised.isNotEmpty) {
          // This indicates that data was present but parsing to BankDataModel might have failed for all items.
          // Check BankDataModel.fromJson and its sub-models if this occurs.
          errorMessage(
            'Transaction data found, but failed to parse items correctly.',
          );
        } else if (transactions.isEmpty) {
          errorMessage('No transactions found.');
        }
        // If transactions are successfully populated, errorMessage remains empty.
      } else {
        errorMessage(
          'API Error (Status ${parsedResponse.statusCode}): ${parsedResponse.message}',
        );
      }
    } catch (e, s) {
      print("Error in fetchBankTransactions: $e\n$s");
      if (e is FormatException || e.toString().toLowerCase().contains('json')) {
        // This catches errors from jsonDecode or issues within your fromJson factories if the JSON is malformed
        errorMessage(
          'Failed to parse server response. Please check API output or model structure.',
        );
      } else {
        errorMessage('An unexpected error occurred: ${e.toString()}');
      }
    } finally {
      isLoading(false);
    }
  }

  void _showAuthBottomSheet() {
    Get.bottomSheet(
      Container(
        height: 160.h, // Adjusted height slightly for padding and content
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Obx(() {
          bool isLoadingUrl =
              message.value == 'Authenticating...' && bankUrl.value.isEmpty;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (isLoadingUrl)
                const CircularProgressIndicator()
              else if (bankUrl.value.isNotEmpty)
                ElevatedButton(
                  onPressed: () async {
                    if (bankUrl.value.isNotEmpty) {
                      await _launchUrl(bankUrl.value);
                      Get.back(); // Close bottom sheet after attempting to launch
                    }
                  },
                  child: const Text('Open Bank URL'),
                )
              else
                const SizedBox(
                  height: 40,
                ), // Placeholder if no button and not loading to keep text centered

              SizedBox(height: 15.h),
              Expanded(
                child: SingleChildScrollView(
                  // In case message is long
                  child: Text(
                    message.value,
                    style: TextStyle(fontSize: 16.sp, color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          );
        }),
      ),
      isDismissible: true,
      enableDrag: true,
    );
  }

  Future<void> _launchUrl(String urlValue) async {
    final Uri uri = Uri.parse(urlValue);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      // Update message or show a snackbar if launch fails
      message.value =
          'Could not launch $urlValue. Please check the URL or browser settings.';
      Get.snackbar(
        "Launch Error",
        "Could not open the URL. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      // throw Exception('Could not launch $urlValue'); // Throwing might be too disruptive for UX
    }
  }

  // Placeholder methods from your original code
  void fetchBankDetails() {
    // Logic to fetch bank details
    Get.snackbar("Info", "fetchBankDetails called");
  }

  void updateBankDetails() {
    // Logic to update bank details
    Get.snackbar("Info", "updateBankDetails called");
  }
}
