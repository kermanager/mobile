import 'package:kermanager/api/api_constants.dart';

class ApiResponse<T> {
  final T? data;
  final String? error;

  ApiResponse({
    this.data,
    this.error,
  });

  String get errorMessage => ApiConstants.getMessage(error);
}
