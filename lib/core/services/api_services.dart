import 'package:financial_ai_mobile/core/utils/global_base.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  Future<http.Response> postData(String url, Map<String, dynamic>? body) async {
    try {
      final request = await http.post(Uri.parse(url), body: body);
      if (request.statusCode == 200) {
        return request;
      } else if (request.statusCode == 400) {
        GlobalBase.showToast('Bad Request', true);
        throw Exception('Bad request: ${request.body}');
      } else if (request.statusCode == 401) {
        GlobalBase.showToast('Unauthorized', true);

        throw Exception('Unauthorized: ${request.body}');
      } else if (request.statusCode == 500) {
        GlobalBase.showToast('Server error', true);

        throw Exception('Server error: ${request.body}');
      } else {
        GlobalBase.showToast('Unexpected error', true);

        throw Exception('Unexpected error: ${request.body}');
      }
    } catch (e) {
      GlobalBase.showToast('Error occurred while making request', true);

      Exception('Error occurred while making POST request: $e');
      rethrow;
    }
  }
}
