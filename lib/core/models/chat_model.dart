// core/models/chat_model.dart
import 'dart:io'; // Import for File

class ChatModel {
  String message;
  bool isSender;
  File? imageFile; // Add this to hold the image sent by the user

  ChatModel({
    required this.message,
    this.isSender = false,
    this.imageFile, // Initialize in constructor
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    // Assuming the API response for AI message does not include an imageFile
    return ChatModel(
      message:
          json['message'] ??
          json['parts']?[0]?['text'] ??
          'No response', // Adjust based on actual API response structure for AI message
      isSender: false, // AI responses are not from the sender
    );
  }
}
