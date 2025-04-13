import 'dart:io';

class ChatModel {
  final String message;
  final File? image;
  bool isSender;

  ChatModel({required this.message, this.image, required this.isSender});

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(message: json['data'], isSender: false);
  }

  // Map<String, dynamic> sendMessageWithoutImage() {
  //   return {'message': message, 'isSender': isSender};
  // }
}
