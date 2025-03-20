import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ChatController extends GetxController {
  Rx<File?> selectedImage = Rx<File?>(null); // Holds the selected image file

  /// Function to pick an image from the gallery
  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  /// Function to remove the selected image
  void removeImage() {
    selectedImage.value = null; // Clears the selected image
  }
}
