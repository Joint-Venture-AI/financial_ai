import 'dart:convert';
import 'dart:math';
import 'package:financial_ai_mobile/core/models/courses_model.dart';
import 'package:financial_ai_mobile/core/models/notifications_model.dart';
import 'package:financial_ai_mobile/core/services/api_services.dart';
import 'package:financial_ai_mobile/core/utils/api_endpoint.dart';
import 'package:financial_ai_mobile/core/utils/global_base.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  var availableBalancePer = 0.0.obs; // Changed to RxDouble
  var espenseBalancePer = 0.0.obs; // Changed to RxDouble

  var totalIncome = 0.obs;
  var totalExpense = 0.0.obs;
  var availableMoney = 0.0.obs;
  var todayExpense = 0.obs;

  RxList<Course> coursesModel = <Course>[].obs;

  RxList<NotificationModel> notifications = <NotificationModel>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await getUserPresentMonthData();
    await getCourses();
    await getAllNotification();
  }

  Future<void> getUserPresentMonthData() async {
    try {
      isLoading.value = true;
      final response = await ApiServices().getUserData(
        ApiEndpoint.getPresentMonth,
      );
      final data = json.decode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        final presentData = data['data'];

        totalIncome.value = presentData['totalIncome'];
        totalExpense.value = presentData['totalExpense'].toDouble();
        availableMoney.value = presentData['availableMoney'].toDouble();
        todayExpense.value = presentData['todayExpense'];
        espenseBalancePer.value = presentData['expensePercentage'].toDouble();
        availableBalancePer.value =
            presentData['availablePercentage'].toDouble();
      } else {
        printError(info: 'Failed to fetch user data: ${response.statusCode}');
      }
    } catch (e) {
      printError(info: 'Error occurred while fetching user data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getCourses() async {
    try {
      isLoading.value = true;
      final response = await ApiServices().getUserData(
        ApiEndpoint.getCoursesList,
      );
      final data = json.decode(response.body);
      if (response.statusCode == 200 && data['success'] == true) {
        final courses = data['data'];
        print(courses);
        // coursesModel.add(Course.fromJson(courses));
        // // Process the courses data as needed
        for (var course in courses) {
          coursesModel.add(Course.fromJson(course));
        }
        // Example: Print the courses to the console
        print(courses);
      } else {
        throw Exception('Failed to fetch courses: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error occurred while fetching courses: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> launchCourseUrl(lunchUrl) async {
    if (!await launchUrl(Uri.parse(lunchUrl))) {
      throw Exception('Could not launch $lunchUrl');
    }
  }

  Future<void> getAllNotification() async {
    try {
      isLoading.value = true;
      final request = await ApiServices().getUserData(
        ApiEndpoint.getNotification,
      );
      final data = jsonDecode(request.body);
      for (var notification in data['data']) {
        notifications.add(NotificationModel.fromJson(notification));
      }

      if (request.statusCode == 200 && data['message']) {
        printInfo(info: 'Got all the notification');
      }
    } catch (e) {
      printInfo(info: 'failed to get the notification');

      printError(info: 'error $e');
    } finally {
      isLoading.value = false;
    }
  }
}
