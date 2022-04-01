import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shopping_app/models/api_response.dart';
import 'package:shopping_app/models/category.dart';
import 'package:shopping_app/services/user_services.dart';

import '../constant.dart';

// get all posts
Future<ApiResponse> getCategoies() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse(categoryURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['categories']
            .map((p) => Category.fromJson(p))
            .toList();
        // we get list of posts, so we need to map each item to post model
        apiResponse.data as List<dynamic>;
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}
