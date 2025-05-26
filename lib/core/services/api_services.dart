import 'dart:convert';
import 'dart:io';
import 'package:financial_ai_mobile/core/services/pref_helper.dart';
import 'package:financial_ai_mobile/core/utils/global_base.dart';
import 'package:financial_ai_mobile/core/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

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
      print('=======>>>>>>> $e');
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
        GlobalBase.showToast('${data['message']}', false);

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
      print('=======>>>>>>> $e');
      Exception('Error occurred while making POST request: $e');
      print('=======>>>>>>> $e');

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
        headers: {'Authorization': 'Bearer $token'},
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
      print('=======>>>>>>> $e');
      Exception('Error occurred while getting user data: $e');
      print('=======>>>>>>> $e');

      rethrow;
    } finally {
      // Perform any cleanup or finalization here if needed
      // For example, you can clear the user data from local storage
    }
  }

  Future<http.Response> saveUserData(
    String url,
    Map<String, dynamic> body,
  ) async {
    try {
      final token = await PrefHelper.getString(Utils.TOKEN);
      if (token == null || token.isEmpty) {
        GlobalBase.showToast('Invalid User', true);
        throw Exception('Token is null or empty');
      }
      final request = await http.get(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $token'},
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
      print('=======>>>>>>> $e');
      Exception('Error occurred while saving user data: $e');

      rethrow;
    }
  }

  Future<http.Response> post(String url, Map<String, dynamic> body) async {
    try {
      final token = await PrefHelper.getString(Utils.TOKEN);
      if (token == null || token.isEmpty) {
        GlobalBase.showToast('Invalid User', true);
        // throw Exception('Token is null or empty');
      }
      final request = await http.post(
        Uri.parse(url),
        headers: {'Authorization': 'Bearer $token'},
        body: body,
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
      print('=======>>>>>>> $e');

      Exception('Error occurred while saving user data: $e');

      rethrow;
    }
  }

  // New method for multipart requests (text and optional file)
  Future<http.Response> postMultipartRequest(
    String endpoint,
    Map<String, String> textFields, {
    File? imageFile,
    String imageFieldKey = 'image',
  }) async {
    final String? token = await PrefHelper.getString(Utils.TOKEN);
    final url = Uri.parse(endpoint);
    print('Multipart POST Request URL: $url');
    print('Multipart POST Text Fields: $textFields');
    if (imageFile != null) {
      print('Multipart POST Image File: ${imageFile.path}');
    }

    var request = http.MultipartRequest('POST', url);

    request.headers.addAll({
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    });

    textFields.forEach((key, value) {
      request.fields[key] = value;
    });

    if (imageFile != null) {
      try {
        var stream = http.ByteStream(imageFile.openRead());
        var length = await imageFile.length();
        String? mimeType = lookupMimeType(imageFile.path); // Lookup MIME type

        MediaType? contentType;
        if (mimeType != null) {
          var typeParts = mimeType.split('/');
          contentType = MediaType(typeParts[0], typeParts[1]);
        } else {
          print(
            'Warning: Could not determine MIME type for ${imageFile.path}.',
          );
        }

        print('Determined MIME type: $mimeType, ContentType: $contentType');

        var multipartFile = http.MultipartFile(
          imageFieldKey,
          stream,
          length,
          filename: imageFile.path.split('/').last,
          contentType: contentType, // <<< SET THE CONTENT TYPE HERE
        );
        request.files.add(multipartFile);
      } catch (e) {
        print("Error adding image to multipart request: $e");
      }
    }

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      return response;
    } catch (e) {
      print('Error in Multipart POST request: $e');
      rethrow;
    }
  }
}
