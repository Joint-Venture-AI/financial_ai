import 'package:financial_ai_mobile/core/models/user_model.dart';
import 'package:financial_ai_mobile/core/services/api_services.dart';
import 'package:financial_ai_mobile/core/services/pref_helper.dart';
import 'package:financial_ai_mobile/core/utils/api_endpoint.dart';
import 'package:financial_ai_mobile/core/utils/global_base.dart';
import 'package:financial_ai_mobile/core/utils/utils.dart';
import 'package:financial_ai_mobile/views/screens/auth/pass_set_screen.dart';
import 'package:financial_ai_mobile/views/screens/auth/sign_in_screen.dart';
import 'package:financial_ai_mobile/views/screens/auth/verify_otp_screen.dart';
import 'package:financial_ai_mobile/views/screens/bottom_nav/tab_screen.dart';
import 'package:financial_ai_mobile/views/screens/on_boarding/user_info/user_chose_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'dart:convert';

class AuthController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  final newPassController = TextEditingController();
  final rePassController = TextEditingController();

  var isLoading = false.obs;
  var isChecked = false.obs;
  var otpController = TextEditingController();
  var selectedCountry = 'NONE'.obs;

  final List<Map<String, dynamic>> countries = [
    {"value": "NONE", "label": "Choose your country"},
    {"value": "AT", "label": "Austria"},
    {"value": "BE", "label": "Belgium"},
    {"value": "DK", "label": "Denmark"},
    {"value": "EE", "label": "Estonia"},
    {"value": "FI", "label": "Finland"},
    {"value": "FR", "label": "France"},
    {"value": "DE", "label": "Germany"},
    {"value": "IE", "label": "Ireland"},
    {"value": "IT", "label": "Italy"},
    {"value": "LV", "label": "Latvia"},
    {"value": "LT", "label": "Lithuania"},
    {"value": "NL", "label": "Netherlands"},
    {"value": "NO", "label": "Norway"},
    {"value": "PL", "label": "Poland"},
    {"value": "PT", "label": "Portugal"},
    {"value": "ES", "label": "Spain"},
    {"value": "SE", "label": "Sweden"},
    {"value": "GB", "label": "United Kingdom"},
  ];

  @override
  onInit() {
    super.onInit();
    nameController.clear();
    emailController.clear();
    passController.clear();
    newPassController.clear();
    rePassController.clear();
    otpController.clear();
  }

  onDispose() {
    nameController.dispose();
    emailController.dispose();
    passController.dispose();
    newPassController.dispose();
    rePassController.dispose();
    otpController.dispose();
  }

  @override
  void onClose() {
    nameController.clear();
    emailController.clear();
    passController.clear();
    newPassController.clear();
    rePassController.clear();
    otpController.clear();
    super.onClose();
  }

  Future<void> createUser(UserModel user) async {
    try {
      isLoading.value = true;
      final response = await ApiServices().postData(
        ApiEndpoint.register,
        user.toJson(),
      );
      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        if (data["success"] == true) {
          ///saving user email for further uses
          await PrefHelper.setString(Utils.EMAIL, user.email);
          GlobalBase.showToast('User Created Successfully', false);
          Get.to(
            VerifyOtpScreen(
              email: emailController.text.trim(),
              isForgetPass: false,
            ),
          );
        }
      }
      // throw Exception(data['message']);
    } catch (e) {
      // throw Exception('Error creating user: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInUser(Map<String, dynamic> user) async {
    try {
      isLoading.value = true;
      final response = await ApiServices().postData(ApiEndpoint.login, user);
      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        if (data["success"] == true) {
          await PrefHelper.setString(Utils.TOKEN, data['data']['accessToken']);
          Get.offAll(MainScreen());

          GlobalBase.showToast('Login Successfully', false);
        } else {
          GlobalBase.showToast(data['message'], true);
        }
      }
    } catch (e) {
      print('Error signing in user: $e');
      // throw Exception('Error signing in user: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> forgetPassword(String email) async {
    try {
      isLoading.value = true;
      final repsonse = await ApiServices().updateUser(
        ApiEndpoint.forgotPassword,
        {"email": email},
        null,
      );
      final data = json.decode(repsonse.body);
      if (repsonse.statusCode == 200) {
        if (data["success"] == true) {
          GlobalBase.showToast('Check your email for OTP', false);
          Get.to(VerifyOtpScreen(email: email, isForgetPass: true));
        } else {
          GlobalBase.showToast(data['message'], true);
        }
      } else {
        GlobalBase.showToast(data['message'], true);
      }
    } catch (e) {
      // throw Exception('Error sending forgot password request: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyOtp(String email, String otp, bool isForget) async {
    try {
      final response = await ApiServices().updateUser(ApiEndpoint.verifyOtp, {
        "email": email,
        "otp": otp,
      }, null);
      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        if (data["success"] == true) {
          await PrefHelper.setString(Utils.EMAIL, email);
          final token = data['data']['token'];
          if (token != null) {
            printInfo(info: '>>>>>>>----Token--->>>>>>$token');
            await PrefHelper.setString(Utils.TOKEN, token);
          }

          GlobalBase.showToast('OTP verified successfully', false);
          Get.to(isForget ? PassSetScreen() : UserChoseScreen());
        } else {
          GlobalBase.showToast(data['message'], true);
        }
      } else {
        GlobalBase.showToast(data['message'], true);
      }
    } catch (e) {
      // throw Exception('Error verifying OTP: $e');
    }
  }

  Future<void> resetPassword(Map<String, dynamic> passwords) async {
    try {
      final response = await ApiServices().updateUser(
        ApiEndpoint.resetPassword,
        passwords,
        {'Authorization': 'Bearer ${await PrefHelper.getString(Utils.TOKEN)}'},
      );
      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        if (data["success"] == true) {
          GlobalBase.showToast('Password reset successfully', false);
          Get.offAll(SignInScreen());
        } else {
          GlobalBase.showToast(data['message'], true);
        }
      } else {
        GlobalBase.showToast(data['message'], true);
      }
    } catch (e) {
      // throw Exception('Error resetting password: $e');
    }
  }
}
