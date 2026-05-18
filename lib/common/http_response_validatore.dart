import 'package:app/common/exceptins.dart';
import 'package:dio/dio.dart';

mixin HttpResponseValidatore {
  // Helper method to validate HTTP response
  // Throws AppExceptions if status code is not 200 (OK)
  validateRespone(Response response) {
    if (response.statusCode != 200) {
      throw AppExceotions();
    }
  }
}