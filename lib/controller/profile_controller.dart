import 'dart:convert';
import 'dart:io';
import 'package:financial_ai_mobile/core/models/profile_model.dart';
import 'package:financial_ai_mobile/core/services/api_services.dart';
import 'package:financial_ai_mobile/core/services/pref_helper.dart';
import 'package:financial_ai_mobile/core/utils/api_endpoint.dart';
import 'package:financial_ai_mobile/core/utils/global_base.dart';
import 'package:financial_ai_mobile/core/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  Rx<File?> pickedImage = Rx<File?>(null);
  late Rx<ProfileModel> profileModel;
  final isLoading = false.obs;

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController nickNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  DateTime dateTime = DateTime.now();
  @override
  void onInit() async {
    super.onInit();
    await getProfileInfo();
  }

  Future pickImage() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image.
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      pickedImage.value = File(image.path);
    }
  }

  Future<void> getProfileInfo() async {
    try {
      isLoading.value = true;
      final response = await ApiServices().getUserData(ApiEndpoint.getProfile);
      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        printInfo(info: 'Success got all the data=========>>>>>');
        profileModel = ProfileModel.fromJson(data['data']).obs;
        GlobalBase.showToast(data['data'], false);
      }
    } catch (e) {
      throw Exception('error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProfile(ProfileModel profileModelData) async {
    try {
      isLoading.value = true;

      final token = await PrefHelper.getString(Utils.TOKEN);
      if (token == null) {
        GlobalBase.showToast('Invalid user', true);
        return;
      }
      printError(info: '====>>> ${profileModelData.toUpdateJson()}');
      final response = await ApiServices().updateUser(
        ApiEndpoint.updateProfile,
        profileModelData.toUpdateJson(),
        {'Authorization': 'Bearer $token'},
      );
      // if (response.statusCode == 200) {
      //   Get.back();
      //   await getProfileInfo();
      // }
    } catch (e) {
      throw Exception('error:======>>> $e');
    } finally {
      isLoading.value = false;
    }
  }
}
