import 'dart:convert';
import 'package:financial_ai_mobile/views/screens/auth/sign_in_screen.dart';
import 'package:http/http.dart' as http;
import 'package:financial_ai_mobile/core/services/api_services.dart';
import 'package:financial_ai_mobile/core/services/pref_helper.dart';
import 'package:financial_ai_mobile/core/utils/api_endpoint.dart';
import 'package:financial_ai_mobile/core/utils/app_icons.dart';
import 'package:financial_ai_mobile/core/utils/global_base.dart';
import 'package:financial_ai_mobile/core/utils/utils.dart';
import 'package:financial_ai_mobile/views/screens/on_boarding/components/board_1.dart';
import 'package:financial_ai_mobile/views/screens/on_boarding/components/board_2.dart';
import 'package:financial_ai_mobile/views/screens/on_boarding/components/board_3.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeController extends GetxController {
  RxInt currentIndex = 0.obs;
  final PageController pageController = PageController();
  var selectedUser = 'Job Holder'.obs;

  final monthlyIncomeController = TextEditingController();
  // final monthlyExpenseController = TextEditingController();
  // final currentBlanceController = TextEditingController();

  final isLoading = false.obs;

  RxList<Map<String, dynamic>> fixedMonthAmounts = RxList([]);

  RxList<Widget> boadring_views = RxList<Widget>([
    BoardOneView(),
    BoardTwoView(),
    BoardThreeView(),
  ]);

  RxList<Map<String, dynamic>> userList = RxList([
    {'icon': AppIcons.shopingBag, 'title': 'Job Holder'},
    {'icon': AppIcons.marketIcon, 'title': 'Business Man'},
  ]);

  void changeIndex(int index) {
    currentIndex.value = index;
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  Future<void> saveUserFixedData() async {
    try {
      // Build expense map only if items exist
      final expenseMap = {
        for (var item in fixedMonthAmounts)
          item['category']: int.tryParse(item['amount'].toString().trim()) ?? 0,
      };

      // // ⚠️ Safety check: don't send empty expenseLimit
      // if (expenseMap.isEmpty) {
      //   GlobalBase.showToast(
      //     "Please enter at least one expense category",
      //     true,
      //   );
      //   return;
      // }

      final userData = {
        "userEmail": await PrefHelper.getString(Utils.EMAIL),
        "data": {
          "balance": {
            "avgIncome": int.tryParse(monthlyIncomeController.text.trim()) ?? 0,
          },
          "expenseLimit": expenseMap,
        },
      };

      printInfo(info: 'Sending: $userData');

      final response = await http.post(
        Uri.parse(ApiEndpoint.saveFixedData),
        headers: {
          'Content-Type': 'application/json', // 🔥 THIS IS THE FIX
          'Accept': 'application/json',
        },
        body: jsonEncode(userData),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['success'] == true) {
        GlobalBase.showToast('Data saved successfully', false);
        Get.offAll(() => SignInScreen(), transition: Transition.leftToRight);
      } else {
        GlobalBase.showToast(data['message'] ?? 'Server error', true);
      }
    } catch (e) {
      printError(info: e.toString());
      GlobalBase.showToast('Something went wrong', true);
    } finally {
      monthlyIncomeController.clear();

      fixedMonthAmounts.clear();
    }
  }
}
