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
    // Optionally, you can start listening automatically when the controller is ready
    // startListening();
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
