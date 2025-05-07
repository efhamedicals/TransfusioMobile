import 'package:dio/dio.dart';

import 'app_log.dart';

class DioLogger {
  static void onSend(String tag, RequestOptions options) {
    AppLog.info(
        '$tag - Request Path : [${options.method}] ${options.baseUrl}${options.path}');
    AppLog.info('$tag - Request Headers : [${options.headers}]');
    AppLog.info('$tag - Request Data : ${options.queryParameters.toString()}');
    AppLog.info('$tag - Request Data : ${options.data.toString()}');
  }

  static void onSuccess(String tag, Response response) {
    AppLog.info(
        '$tag - Response Path : [${response.requestOptions.method}] ${response.requestOptions.baseUrl}${response.requestOptions.path} Request Data : ${response.requestOptions.data.toString()}');
    AppLog.info('$tag - Response statusCode : ${response.statusCode}');
    AppLog.info('$tag - Response data : ${response.data.toString()}');
  }

  static void onError(String tag, DioException error) {
    if (null != error.response) {
      AppLog.info(
          '$tag - Error Path : [${error.response!.requestOptions.method}] ${error.response!.requestOptions.baseUrl}${error.response!.requestOptions.path} Request Data : ${error.response!.requestOptions.data.toString()}');
      AppLog.info('$tag - Error statusCode : ${error.response!.statusCode}');
      AppLog.info(
          '$tag - Error data : ${null != error.response!.data ? error.response!.data.toString() : ''}');
    }
    AppLog.info('$tag - Error Message : ${error.message}');
  }
}
