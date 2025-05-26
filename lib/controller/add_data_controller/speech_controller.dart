import 'dart:convert';

import 'package:financial_ai_mobile/controller/home/home_controller.dart';
import 'package:financial_ai_mobile/core/helper/widget_helper.dart';
import 'package:financial_ai_mobile/core/services/api_services.dart';
import 'package:financial_ai_mobile/core/utils/api_endpoint.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechController extends GetxController {
  final stt.SpeechToText _speech = stt.SpeechToText();
  var isListening = false.obs;
  var lastWords = ''.obs;
  var isSpeechEnabled = false.obs;
  var lastError = ''.obs;
  var fullMessage = ''.obs;

  var speechConroller = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    initializeSpeech();
  }

  @override
  void onClose() {
    _speech.stop();
    super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> saveExpense() async {
    if (fullMessage.value.isEmpty) {
      lastError.value = 'Please speak something to save.';
      return;
    }
    final body = {'promt': fullMessage.value};
    final response = await ApiServices().post(
      ApiEndpoint.addExpenseVoice,
      body,
    );
    final responseBody = jsonDecode(response.body);
    if (response.statusCode == 200) {
      WidgetHelper.showToast(
        isSuccess: true,
        message: 'Successfully saved expense',
      );
      Get.find<HomeController>().getUserPresentMonthData();
      lastWords.value = 'Expense saved successfully!';
      speechConroller.text = 'Expense Saved';
      lastError.value = '';
    } else {
      lastWords.value = 'Failed to save expense: ${responseBody['message']}';
      lastError.value = responseBody['message'];
    }

    lastWords.value = 'Expense saved: ${fullMessage.value}';
    fullMessage.value = '';
    speechConroller.clear();
    update();
  }

  @override
  Future<void> initializeSpeech() async {
    try {
      bool available = await _speech.initialize(
        onStatus: (status) {
          isListening.value = _speech.isListening;
          update();
        },
        onError: (error) {
          isListening.value = false;
          if (error.errorMsg == 'error_no_match') {
            lastWords.value =
                'No speech recognized. Please try speaking clearly.';
            lastError.value = 'No match detected. Try again.';
          } else {
            lastWords.value = 'Error: ${error.errorMsg}';
            lastError.value = error.errorMsg;
          }
          update();
        },
      );
      isSpeechEnabled.value = available;
      if (!available) {
        lastWords.value = 'Speech recognition not available';
        lastError.value = 'Speech service unavailable';
      }
    } catch (e) {
      isSpeechEnabled.value = false;
      lastWords.value = 'Speech initialization failed: $e';
      lastError.value = 'Initialization failed: $e';
    }
    update();
  }

  void startListening() {
    if (isSpeechEnabled.value && !isListening.value) {
      // Reset error and last words before starting
      lastError.value = '';
      lastWords.value = 'Listening...';

      _speech.listen(
        onResult: (result) {
          lastWords.value = result.recognizedWords;
          if (result.finalResult) {
            fullMessage.value = result.recognizedWords;
            speechConroller.text = fullMessage.value;
            isListening.value = false;
          }
          update();
        },
        listenFor: const Duration(seconds: 30),
        pauseFor: const Duration(seconds: 5),
        partialResults: true,
        cancelOnError: true,
        listenMode: stt.ListenMode.dictation,
        localeId: 'en-US', // Specify locale for better recognition
      );
      isListening.value = true;
      update();
    } else if (!isSpeechEnabled.value) {
      lastWords.value =
          'Speech recognition not available. Please check permissions.';
      lastError.value = 'Speech not initialized';
      update();
    }
  }

  void stopListening() {
    if (isListening.value) {
      _speech.stop();
      isListening.value = false;
      update();
    }
  }

  void retryListening() {
    stopListening();
    Future.delayed(const Duration(milliseconds: 500), () {
      startListening();
    });
  }
}
