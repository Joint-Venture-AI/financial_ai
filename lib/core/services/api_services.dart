import 'dart:convert';

import 'package:financial_ai_mobile/core/services/pref_helper.dart';
import 'package:financial_ai_mobile/core/utils/global_base.dart';
import 'package:financial_ai_mobile/core/utils/utils.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  Future<http.Response> postData(String url, Map<String, dynamic>? body) async {
    try {
      final request = await http.post(Uri.parse(url), body: body);
      final data = json.decode(request.body);
      if (request.statusCode == 200) {
        return request;
      } else if (request.statusCode == 400) {
        GlobalBase.showToast('Bad request: ${data['message']}', true);
        throw Exception('Bad request: ${request.body}');
      } else if (request.statusCode == 401) {
        GlobalBase.showToast('Bad request: ${data['message']}', true);

        throw Exception('Unauthorized: ${request.body}');
      } else if (request.statusCode == 500) {
        GlobalBase.showToast('Bad request: ${data['message']}', true);

        throw Exception('Server error: ${request.body}');
      } else {
        GlobalBase.showToast('Bad request: ${data['message']}', true);

        throw Exception('Unexpected error: ${request.body}');
      }
    } catch (e) {
      Exception('Error occurred while making POST request: $e');
      rethrow;
    }
  }

  Future<http.Response> updateUser(
    String uri,
    Map<String, dynamic> body,
    Map<String, String>? headers,
  ) async {
    try {
      final request = await http.patch(
        Uri.parse(uri),
        body: body,
        headers: headers,
      );
      final data = json.decode(request.body);
      if (request.statusCode == 200) {
        return request;
      } else if (request.statusCode == 400) {
        GlobalBase.showToast('Bad request: ${data['message']}', true);
        throw Exception('Bad request: ${request.body}');
      } else if (request.statusCode == 401) {
        GlobalBase.showToast('Bad request: ${data['message']}', true);

        throw Exception('Unauthorized: ${request.body}');
      } else if (request.statusCode == 500) {
        GlobalBase.showToast('Bad request: ${data['message']}', true);

        throw Exception('Server error: ${request.body}');
      } else {
        GlobalBase.showToast('Bad request: ${data['message']}', true);

        throw Exception('Unexpected error: ${request.body}');
      }
    } catch (e) {
      Exception('Error occurred while making POST request: $e');
      rethrow;
    }
  }

  Future<http.Response> getUserData(String url) async {
    try {
      final token = await PrefHelper.getString(Utils.TOKEN);

      if (token == null || token.isEmpty) {
        print('====> $token');
        GlobalBase.showToast('Invalid User', true);
        throw Exception('Token is null or empty');
      }

      final request = await http.get(
        Uri.parse(url),
        headers: {'Authorization': token},
      );
      final data = json.decode(request.body);
      if (request.statusCode == 200) {
        return request;
      }
      if (request.statusCode == 400) {
        GlobalBase.showToast('Bad request: ${data['message']}', true);
        throw Exception('Bad request: ${request.body}');
      } else if (request.statusCode == 401) {
        GlobalBase.showToast('Bad request: ${data['message']}', true);

        throw Exception('Unauthorized: ${request.body}');
      } else if (request.statusCode == 500) {
        GlobalBase.showToast('Bad request: ${data['message']}', true);

        throw Exception('Server error: ${request.body}');
      } else {
        GlobalBase.showToast('Bad request: ${data['message']}', true);

        throw Exception('Unexpected error: ${request.body}');
      }
    } catch (e) {
      Exception('Error occurred while getting user data: $e');
      rethrow;
    } finally {
      // Perform any cleanup or finalization here if needed
      // For example, you can clear the user data from local storage
    }
  }
}
