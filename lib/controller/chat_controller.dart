// core/controllers/chat_controller.dart
import 'dart:convert';
import 'dart:io';
import 'package:financial_ai_mobile/core/models/chat_model.dart';
import 'package:financial_ai_mobile/core/services/api_services.dart';
import 'package:financial_ai_mobile/core/utils/api_endpoint.dart';
import 'package:financial_ai_mobile/core/utils/global_base.dart'; // Assuming sId might come from here or be generated
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
// You might need a UUID generator if 'sId' needs to be unique per message
// import 'package:uuid/uuid.dart';

class ChatController extends GetxController {
  Rx<File?> selectedImage = Rx<File?>(null);
  RxList<ChatModel> chatData = RxList<ChatModel>([]);
  final chatTextController = TextEditingController();
  final isLoading = false.obs;
  final ApiServices _apiServices = ApiServices();
  // final Uuid _uuid = Uuid(); // If you need to generate unique IDs like sId

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  void removeImage() {
    selectedImage.value = null;
  }

  Future<void> sendMessage() async {
    final String messageText = chatTextController.text.trim();
    final File? imageToSend = selectedImage.value;

    if (messageText.isEmpty && imageToSend == null) {
      GlobalBase.showToast('Please write a message or select an image.', true);
      return;
    }

    isLoading.value = true;

    final userMessage = ChatModel(
      message: messageText,
      isSender: true,
      imageFile: imageToSend,
    );
    chatData.add(userMessage);

    chatTextController.clear();
    // Keep selectedImage.value as is for now, postMultipartRequest will use it
    // Then clear it after the API call or if the call is successful.

    try {
      // 1. Prepare the JSON object for the 'data' field
      Map<String, dynamic> dataPayload = {
        'text': messageText,
        // 'sId': _uuid.v4(), // Example: Generate a unique session/message ID if needed
        // Add any other fields your 'data' object requires
      };
      if (messageText.isEmpty && imageToSend != null) {
        // If only an image is sent, your API might still expect a 'text' field,
        // or you might send an empty 'text' or omit it based on API requirements.
        // For now, we'll send 'text': ''
        dataPayload['text'] =
            ""; // Or remove if API handles missing text with image
      }

      // 2. Convert the dataPayload to a JSON string
      String jsonDataString = jsonEncode(dataPayload);

      // 3. Prepare the textFields map for postMultipartRequest
      final Map<String, String> textFields = {
        'data': jsonDataString, // The key is 'data', value is the JSON string
      };

      final httpResponse = await _apiServices.postMultipartRequest(
        ApiEndpoint.chat,
        textFields,
        imageFile: imageToSend,
        imageFieldKey: 'image', // This matches your Postman setup
      );

      // Clear the selected image from UI *after* attempting to send it
      if (imageToSend != null) {
        removeImage(); // Clears selectedImage.value
      }

      final responseBody = jsonDecode(httpResponse.body);

      if (httpResponse.statusCode == 200) {
        printInfo(info: 'AI Response: $responseBody');

        // --- IMPORTANT: PARSE GEMINI RESPONSE ---
        // This parsing is highly dependent on the exact structure returned by YOUR API
        // which then gets it from Gemini.
        // A common Gemini Vision model response structure is:
        // {
        //   "candidates": [
        //     {
        //       "content": {
        //         "parts": [
        //           { "text": "The AI's response text." }
        //         ],
        //         "role": "model"
        //       }, ...
        //     }
        //   ], ...
        // }
        //
        // Adjust ChatModel.fromJson or parse directly here.
        // For simplicity, let's assume your ChatModel.fromJson expects a map like {'message': 'text'}

        String aiMessageText =
            "Sorry, I couldn't understand the response."; // Default
        if (responseBody['candidates'] != null &&
            (responseBody['candidates'] as List).isNotEmpty) {
          var firstCandidate = responseBody['candidates'][0];
          if (firstCandidate['content'] != null &&
              firstCandidate['content']['parts'] != null &&
              (firstCandidate['content']['parts'] as List).isNotEmpty) {
            var firstPart = firstCandidate['content']['parts'][0];
            if (firstPart['text'] != null) {
              aiMessageText = firstPart['text'];
            }
          }
        } else if (responseBody['message'] != null) {
          // Fallback if 'candidates' structure is not found
          aiMessageText = responseBody['data'];
        }

        final aiMessage = ChatModel(message: aiMessageText, isSender: false);
        chatData.add(aiMessage);
      } else {
        printError(
          info: 'API Error: ${httpResponse.statusCode} - $responseBody',
        );
        chatData.add(
          ChatModel(
            message:
                "Error: ${responseBody['message'] ?? 'Could not get response from AI.'}",
            isSender: false,
          ),
        );
        GlobalBase.showToast(
          responseBody['message'] ?? 'Failed to send message.',
          true,
        );
      }
    } catch (e) {
      printError(info: 'Error sending message: $e');
      chatData.add(
        ChatModel(
          message: "Error: An unexpected error occurred.",
          isSender: false,
        ),
      );
      GlobalBase.showToast('An error occurred. Please try again.', true);
      // Clear the selected image from UI if an error occurs before/during send
      if (imageToSend != null) {
        removeImage();
      }
    } finally {
      isLoading.value = false;
    }
  }
}
