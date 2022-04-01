import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shopping_app/models/Product.dart';
import 'package:shopping_app/models/api_response.dart';
import 'package:shopping_app/services/user_services.dart';

import '../constant.dart';

// Get post comments
Future<ApiResponse> getProducts(int cateId) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse('$categorysURL/$cateId/products'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });

    switch (response.statusCode) {
      case 200:
        print(response.body);

        // map each comments to comment model
        apiResponse.data = jsonDecode(response.body)['products']
            .map((p) => Product.fromJson(p))
            .toList();
        apiResponse.data as List<dynamic>;
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];

        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = e.toString();
  }
  return apiResponse;
}
