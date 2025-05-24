// lib/services/speech_service.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

class SpeechService extends GetxService {
  final SpeechToText _speechToText = SpeechToText();
  final RxBool isSpeechEnabled = false.obs;
  final RxBool isListening = false.obs;
  final RxString lastWords = ''.obs;

  Future<SpeechService> init() async {
    await _requestPermission();
    bool available = await _speechToText.initialize(
      onStatus: (status) {
        isListening.value = _speechToText.isListening;
        debugPrint('Speech Status: $status');
      },
      onError: (error) {
        debugPrint('Speech Error: $error');
      },
    );

    isSpeechEnabled.value = available;
    return this;
  }

  Future<void> _requestPermission() async {
    final status = await Permission.microphone.request();
    if (!status.isGranted) {
      Get.snackbar(
        "Permission",
        "Microphone permission is required",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    isListening.value = true;
  }

  void stopListening() async {
    await _speechToText.stop();
    isListening.value = false;
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    lastWords.value = result.recognizedWords;
  }
}
