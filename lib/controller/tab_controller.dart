import 'package:financial_ai_mobile/views/screens/accounts/account_screen.dart';
import 'package:financial_ai_mobile/views/screens/add/add_screen.dart';
import 'package:financial_ai_mobile/views/screens/ai_chat/ai_chat_screen.dart';
import 'package:financial_ai_mobile/views/screens/analyze/analyze_screen.dart';
import 'package:financial_ai_mobile/views/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyTabController extends GetxController {
  var currentIndex = 0.obs;

  RxList<Widget> tabScreens = RxList([
    HomeScreen(),
    AnalyzeScreen(),
    AddScreen(),
    AccountScreen(),
    AiChatScreen(),
  ]);

  void changeTabIndex(int index) {
    currentIndex.value = index;
  }
}
