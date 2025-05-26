import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTabController extends GetxController with GetTickerProviderStateMixin {
  late TabController tabController;

  final selectedTab = 'Income'.obs;
  final List<String> tabTitles = ['Income', 'Expense'];

  @override
  void onInit() {
    super.onInit();

    tabController = TabController(length: tabTitles.length, vsync: this);

    // Initialize selectedTab value
    selectedTab.value = tabTitles[tabController.index];

    tabController.addListener(() {
      // Use indexIsChanging to avoid multiple rebuilds on swipe
      if (tabController.indexIsChanging) {
        selectedTab.value = tabTitles[tabController.index];
      }
    });
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
