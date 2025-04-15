import 'dart:convert';
import 'dart:io';
import 'package:financial_ai_mobile/core/models/chat_model.dart';
import 'package:financial_ai_mobile/core/services/api_services.dart';
import 'package:financial_ai_mobile/core/utils/api_endpoint.dart';
import 'package:financial_ai_mobile/core/utils/global_base.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ChatController extends GetxController {
  // Reactive variables
  Rx<File?> selectedImage = Rx<File?>(null); // Holds the selected image file
  RxList<ChatModel> chatData = RxList<ChatModel>([]); // Holds chat data
  final chatController = TextEditingController();
  final isLoading = false.obs;

  // Function to pick an image from the gallery
  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  // Function to remove the selected image
  void removeImage() {
    selectedImage.value = null; // Clears the selected image
  }

  // Function to send message
  Future<void> sendMessage() async {
    try {
      isLoading.value = true;

      if (chatController.text.isEmpty) {
        GlobalBase.showToast('Please write some message...', true);
        return;
      }

      // **Add User's Message First** - This will display the user's message immediately
      final userMessage = ChatModel(
        message: chatController.text,
        isSender: true, // The message is from the user
      );
      chatData.add(userMessage);
      chatController.clear(); // Clear the input after adding

      // **API Request to Get AI Response**
      final body = {
        'data': {'text': chatController.text},
      };

      final request = await ApiServices().post(ApiEndpoint.chat, body);
      final responseBody = jsonDecode(request.body);

      if (request.statusCode == 200) {
        printInfo(info: '===>>>>>> $responseBody');

        // **Add AI Response After Getting the Response**
        final aiMessage = ChatModel.fromJson(responseBody);
        aiMessage.isSender = false; // The message is from the AI
        chatData.add(aiMessage);
      }

      // GlobalBase.showToast(responseBody['message'], true);
    } catch (e) {
      throw Exception('error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
