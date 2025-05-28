import 'dart:convert';
import 'package:financial_ai_mobile/controller/home/home_controller.dart';
import 'package:financial_ai_mobile/core/models/bank_data_model.dart'; // Ensure BankDataModel has a toJson() as expected by the API
import 'package:financial_ai_mobile/core/services/api_services.dart';
import 'package:financial_ai_mobile/core/services/pref_helper.dart';
import 'package:financial_ai_mobile/core/utils/api_endpoint.dart';
import 'package:financial_ai_mobile/core/utils/global_base.dart';
import 'package:financial_ai_mobile/core/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart' as get_http;
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

// Assume these are defined globally or in a helper file
void printInfo({required String info}) {
  Get.log("INFO: $info"); // Using Get.log for consistency if preferred
}

void printError({required String info}) {
  Get.log("ERROR: $info", isError: true); // Using Get.log for consistency
}

// Placeholder for your ApiResponse structure, ensure it matches your actual model
// This is used by apiResponseFromJson in fetchBankTransactions
class ApiResponse {
  final bool success;
  final int
  statusCode; // Assuming statusCode is part of the JSON body for ApiResponse
  final String message;
  final Data data;

  ApiResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      success: json["success"] ?? false,
      statusCode: json["statusCode"] ?? 0, // Provide default or handle null
      message: json["message"] ?? '',
      data: Data.fromJson(json["data"] ?? {}), // Provide default or handle null
    );
  }
}

class Data {
  final List<BankDataModel> categorised;
  final List<BankDataModel> nonCategorised;

  Data({required this.categorised, required this.nonCategorised});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      categorised:
          (json["categorised"] as List?)
              ?.map((x) => BankDataModel.fromJson(x))
              .toList() ??
          [],
      nonCategorised:
          (json["nonCategorised"] as List?)
              ?.map((x) => BankDataModel.fromJson(x))
              .toList() ??
          [],
    );
  }
}

// Utility function to parse ApiResponse from JSON string
ApiResponse apiResponseFromJson(String str) =>
    ApiResponse.fromJson(json.decode(str));

class BankController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var authMessage = ''.obs;
  var bankUrl = ''.obs;

  var isLoadingTransactions = false.obs;
  var categorisedTransactions = <BankDataModel>[].obs;
  var nonCategorisedTransactions = <BankDataModel>[].obs;
  var fetchErrorMessage = ''.obs;

  late TabController tabController;
  var selectedTabIndex = 0.obs;

  final ApiServices _apiServices = ApiServices();

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      selectedTabIndex.value = tabController.index;
    });
    fetchBankTransactions();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  Future<void> bankAuthentication() async {
    bankUrl.value = '';
    authMessage.value = 'Authenticating...';
    _showAuthBottomSheet();

    try {
      // Note: The endpoint name '/bank/get-bank-list-transection' for authentication seems unusual.
      // Typically, auth endpoints might be more specific like '/bank/auth/initiate' or '/bank/auth/url'.
      // Please verify this endpoint is correct for initiating bank authentication.
      final responseFromApiService = await _apiServices.getUserData(
        '${ApiEndpoint.baseUrl}/bank/get-bank-list-transection',
      );
      final dynamic decodedBody = jsonDecode(responseFromApiService.body);

      if (decodedBody is! Map<String, dynamic>) {
        authMessage.value =
            'Bank authentication failed: Invalid response format.';
        return;
      }
      final Map<String, dynamic> bodyMap = decodedBody;

      if (responseFromApiService.statusCode == 200 &&
          bodyMap['success'] == true) {
        final dynamic dataField = bodyMap['data'];
        if (dataField is String) {
          bankUrl.value = dataField;
          authMessage.value =
              bodyMap['message'] as String? ?? 'Authentication URL ready.';
        } else {
          authMessage.value =
              'Bank authentication failed: Expected URL, received different format.';
        }
      } else {
        String apiMsg =
            bodyMap['message'] as String? ?? 'Unknown authentication error';
        authMessage.value =
            'Bank authentication failed (Status ${responseFromApiService.statusCode}): $apiMsg';
      }
    } catch (e) {
      authMessage.value = 'Bank authentication failed: ${e.toString()}';
    }
  }

  Future<void> fetchBankTransactions() async {
    try {
      isLoadingTransactions(true);
      fetchErrorMessage('');
      categorisedTransactions.clear();
      nonCategorisedTransactions.clear();

      final String url = '${ApiEndpoint.baseUrl}/bank/get-transactions-from-db';
      final responseFromApiService = await _apiServices.getUserData(url);

      Get.log(
        'Bank Transactions API Response Body: ${responseFromApiService.body}',
      );

      // Ensure ApiResponse and its nested models (Data, BankDataModel)
      // correctly parse the structure of responseFromApiService.body
      final ApiResponse parsedResponse = apiResponseFromJson(
        responseFromApiService.body,
      );

      // Check based on HTTP status code from the response object itself,
      // and then the 'success' flag from the parsed body.
      if (responseFromApiService.statusCode == 200 && parsedResponse.success) {
        categorisedTransactions.assignAll(parsedResponse.data.categorised);
        nonCategorisedTransactions.assignAll(
          parsedResponse.data.nonCategorised,
        );

        if (parsedResponse.data.categorised.isEmpty &&
            parsedResponse.data.nonCategorised.isEmpty) {
          fetchErrorMessage('No bank transactions found.');
        }
      } else {
        // Use message from parsed response if available, otherwise provide a generic one.
        String message =
            parsedResponse.message.isNotEmpty
                ? parsedResponse.message
                : "Failed to fetch transactions.";
        fetchErrorMessage(
          'API Error (Status ${responseFromApiService.statusCode}): $message',
        );
      }
    } catch (e, s) {
      Get.log("Error in fetchBankTransactions: $e\n$s", isError: true);
      if (e is FormatException || e.toString().toLowerCase().contains('json')) {
        fetchErrorMessage(
          'Failed to parse server response. Check API output or model structure.',
        );
      } else {
        fetchErrorMessage('An unexpected error occurred: ${e.toString()}');
      }
    } finally {
      isLoadingTransactions(false);
    }
  }

  Future<http.Response> _customPostWithAuth(
    String url,
    Map<String, dynamic> requestBodyMap,
  ) async {
    final token = await PrefHelper.getString(Utils.TOKEN);

    if (token == null || token.isEmpty) {
      GlobalBase.showToast(
        'Authentication token is missing. Please log in again.',
        true,
      );
      throw Exception('Authentication token is missing.');
    }

    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };

    final String encodedBody = jsonEncode(requestBodyMap);
    printInfo(info: "Custom POST to URL: $url");
    // printInfo(info: "Custom POST Headers: $headers"); // Optional: for deep debugging
    printInfo(info: "Custom POST Encoded Body: $encodedBody");

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: encodedBody,
    );

    printInfo(info: "Custom POST Response Status: ${response.statusCode}");
    // printInfo(info: "Custom POST Response Body: ${response.body}"); // Optional: for deep debugging
    return response;
  }

  Future<void> makeAllTransactionsCategorized(
    List<BankDataModel> uncategorizedTransactionsList,
  ) async {
    if (uncategorizedTransactionsList.isEmpty) {
      Get.snackbar(
        "Info",
        "No transactions to categorize.",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    Get.dialog(
      const Center(child: CupertinoActivityIndicator()),
      barrierDismissible: false,
    );

    try {
      final List<Map<String, dynamic>> transactionJsonList =
          uncategorizedTransactionsList.map((transaction) {
            // CRITICAL: Ensure transaction.toJson() produces the exact structure
            // for each item as shown in your API example. This means it must output
            // fields like "amount" (not "amountDetails"), "descriptions" (not "description"),
            // and include all required fields like "tId", "accId", "user", "__v",
            // "updatedAt", "isCategorised", and the nested "amount.value".
            //
            // Example structure for ONE item from transaction.toJson():
            // {
            //     "_id": "68317201ca86e787dbdb94b9",
            //     "tId": "2a6a65c4cca149f9b51d565a9936070e",
            //     "accId": "3e7dcabf660948d9bff863148c498a2d",
            //     "amount": {
            //         "value": {"unscaledValue": "-379", "scale": "2"},
            //         "currencyCode": "EUR",
            //         "actualAmount": -3.79
            //     },
            //     "descriptions": {"display": "Cafetería"},
            //     "status": "PENDING",
            //     "user": "6811cbf65b95d49c59b99550",
            //     "__v": 0,
            //     "createdAt": "2025-05-24T07:15:13.187Z",
            //     "updatedAt": "2025-05-24T07:15:13.187Z",
            //     "isCategorised": false
            // }
            return transaction.toJson();
          }).toList();

      // This bodyMap structure matches your API requirement: {"data": [transactions]}
      final bodyMap = {'data': transactionJsonList};

      printInfo(info: 'Request body for categorization (Dart Map): $bodyMap');
      try {
        printInfo(
          info:
              'Request body for categorization (JSON String): ${jsonEncode(bodyMap)}',
        );
      } catch (e) {
        printError(info: 'Error encoding body to JSON for printing: $e');
      }

      final response = await _customPostWithAuth(
        '${ApiEndpoint.baseUrl}/bank/categorise-transection',
        bodyMap,
      );

      Get.back(); // Dismiss dialog

      if (response.statusCode == 200) {
        final responseBodyJson = jsonDecode(response.body);
        if (responseBodyJson['success'] == true) {
          Get.snackbar(
            "Success",
            responseBodyJson['message'] ??
                "All transactions have been categorized successfully.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          await fetchBankTransactions();
          await Get.find<HomeController>().getUserPresentMonthData();
        } else {
          Get.snackbar(
            "Error",
            "Failed to categorize: ${responseBodyJson['message'] ?? 'Unknown error'}",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        String errorMessage = "API Error (${response.statusCode}).";
        try {
          final errorBodyJson = jsonDecode(response.body);
          errorMessage +=
              " Message: ${errorBodyJson['message'] ?? response.body}";
        } catch (e) {
          errorMessage += " Response: ${response.body}";
        }
        Get.snackbar(
          "Error",
          errorMessage,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
      printError(info: 'Error in makeAllTransactionsCategorized: $e');
      String displayError = e.toString();
      Get.snackbar(
        "Error",
        "Operation failed: $displayError",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> categorizeTransaction(
    BankDataModel transaction,
    String category,
  ) async {
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      await Future.delayed(const Duration(seconds: 1));

      Get.back(); // Close loading dialog
      Get.snackbar(
        "Success (Simulated)",
        "Transaction '${transaction}' categorized as '$category'.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      fetchBankTransactions();
    } catch (e) {
      if (Get.isDialogOpen ?? false) {
        Get.back(); // Close loading dialog
      }
      Get.snackbar(
        "Error",
        "Error during categorization: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void _showAuthBottomSheet() {
    Get.bottomSheet(
      Container(
        height: 160.h,
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
              authMessage.value == 'Authenticating...' && bankUrl.value.isEmpty;
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
                      Get.back();
                    }
                  },
                  child: const Text('Open Bank URL'),
                )
              else
                // Show a message or a retry button if authMessage indicates failure but no URL
                Text(
                  authMessage.value.isNotEmpty
                      ? authMessage.value
                      : "Ready to authenticate.",
                  textAlign: TextAlign.center,
                ),
              if (!isLoadingUrl &&
                  bankUrl.value.isEmpty &&
                  authMessage.value != 'Authenticating...')
                SizedBox(height: 15.h), // Spacing if text is shown
              if (isLoadingUrl || bankUrl.value.isNotEmpty)
                SizedBox(height: 15.h),
              if (!isLoadingUrl &&
                  bankUrl
                      .value
                      .isEmpty) // Show auth message only if no URL and not loading
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      authMessage.value,
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
      authMessage.value = 'Could not launch $urlValue.';
      Get.snackbar(
        "Launch Error",
        "Could not open the URL.",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Placeholders - Implement as needed
  void fetchBankDetails() {
    Get.snackbar("Info", "fetchBankDetails called - Not implemented");
  }

  void updateBankDetails() {
    Get.snackbar("Info", "updateBankDetails called - Not implemented");
  }
}
