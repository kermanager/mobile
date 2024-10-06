import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:kermanager/api/api_constants.dart';
import 'package:kermanager/api/api_response.dart';

class ApiService {
  Future<ApiResponse<T>> get<T>(
    String url,
    Map<String, String>? queryParams,
    T Function(dynamic) fromJson,
  ) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString(ApiConstants.tokenKey);

      Map<String, String> headers = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      };

      http.Response response = await http.get(
        Uri.https(ApiConstants.apiBaseUrl, url, queryParams),
        headers: headers,
      );

      // Success case
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return ApiResponse<T>(data: fromJson(response.body));
      }
      // Failure case
      return ApiResponse(error: response.body);
    } catch (error) {
      // Failure case
      return ApiResponse(error: 'INTERNAL_SERVER_ERROR');
    }
  }

  Future<ApiResponse<T>> post<T>(
    String url,
    String body,
    T Function(dynamic) fromJson,
  ) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString(ApiConstants.tokenKey);

      Map<String, String> headers = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      };

      http.Response response = await http.post(
        Uri.https(ApiConstants.apiBaseUrl, url),
        headers: headers,
        body: body,
      );

      // Success case
      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (response.body.isEmpty) {
          return ApiResponse<T>(data: null);
        }
        return ApiResponse<T>(data: fromJson(response.body));
      }
      // Failure case
      return ApiResponse(error: response.body);
    } catch (error) {
      // Failure case
      return ApiResponse(error: 'INTERNAL_SERVER_ERROR');
    }
  }

  Future<ApiResponse<T>> patch<T>(
    String url,
    String body,
    T Function(dynamic) fromJson,
  ) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString(ApiConstants.tokenKey);

      Map<String, String> headers = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      };

      http.Response response = await http.patch(
        Uri.https(ApiConstants.apiBaseUrl, url),
        headers: headers,
        body: body,
      );

      // Success case
      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (response.body.isEmpty) {
          return ApiResponse<T>(data: null);
        }
        return ApiResponse<T>(data: fromJson(response.body));
      }
      // Failure case
      return ApiResponse(error: response.body);
    } catch (error) {
      // Failure case
      return ApiResponse(error: 'INTERNAL_SERVER_ERROR');
    }
  }

  Future<ApiResponse<T>> delete<T>(
    String url,
    T Function(dynamic) fromJson,
  ) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? token = preferences.getString(ApiConstants.tokenKey);

      Map<String, String> headers = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      };

      http.Response response = await http.delete(
        Uri.https(ApiConstants.apiBaseUrl, url),
        headers: headers,
      );

      // Success case
      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (response.body.isEmpty) {
          return ApiResponse<T>(data: null);
        }
        return ApiResponse<T>(data: fromJson(response.body));
      }
      // Failure case
      return ApiResponse(error: response.body);
    } catch (error) {
      // Failure case
      return ApiResponse(error: 'INTERNAL_SERVER_ERROR');
    }
  }
}
