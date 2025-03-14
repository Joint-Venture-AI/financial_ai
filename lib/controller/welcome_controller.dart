import 'package:financial_ai_mobile/core/utils/app_icons.dart';
import 'package:financial_ai_mobile/views/screens/on_boarding/components/board_1.dart';
import 'package:financial_ai_mobile/views/screens/on_boarding/components/board_2.dart';
import 'package:financial_ai_mobile/views/screens/on_boarding/components/board_3.dart';
import 'package:financial_ai_mobile/views/screens/on_boarding/on_board_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeController extends GetxController {
  RxInt currentIndex = 0.obs;
  final PageController pageController = PageController();
  var selectedUser = 'Job Holder'.obs;

  final monthlyIncomeController = TextEditingController();
  final monthlyExpenseController = TextEditingController();
  final currentBlanceController = TextEditingController();

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
}
