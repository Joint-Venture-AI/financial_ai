import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

AppBar profileAppBar(title) => AppBar(
  backgroundColor: AppStyles.bgColor,
  leading: GestureDetector(
    onTap: () {
      Get.back();
    },
    child: Icon(Icons.chevron_left),
  ),
  title: Text(title, style: AppStyles.mediumText),
  actions: [Icon(Icons.more_vert)],
);
