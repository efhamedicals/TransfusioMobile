import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class AppError {
  final String message;
  AppError(this.message);
}

// Specific error for Dio exceptions
class DioAppError extends AppError {
  final DioException dioException;

  DioAppError(this.dioException) : super(_extractMessage(dioException)) {
    debugPrint("Complete error: ${dioException.response}");
    debugPrint("Error data: ${dioException.response?.data}");
  }

  static String _extractMessage(DioException dioException) {
    final response = dioException.response;
    if (response?.data is Map<String, dynamic>) {
      final data = response?.data as Map<String, dynamic>;
      final message = data["message"] ??
          dioException.message ??
          "Error when processing, status code : ${response?.statusCode}";
      final errors = data["errors"];
      if (errors != null) {
        final errorMessages = <String>[];
        errors.forEach((key, value) {
          errorMessages.addAll(value.map<String>((msg) => "$msg"));
        });
        return errorMessages.join('\n');
      }
      return message;
    }
    return dioException.message ?? "Error when processing";
  }
}

// Simple error for generic error cases
class SimpleAppError extends AppError {
  SimpleAppError(super.message);
}

// Basic data status, including possibility of data or error
abstract class DataState<T> {
  final T? data;
  final AppError? error;

  const DataState({this.data, this.error});
}

// Success status, containing data
class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

// Failed state, containing an error
class DataFailed<T> extends DataState<T> {
  const DataFailed(AppError error) : super(error: error);
}

// State representing a situation where data is not yet defined or loaded
class DataNotSet<T> extends DataState<T> {
  const DataNotSet();
}

// Generic function to handle errors
DataState<T> handleError<T>(Response response) {
  var errorMessage = response.data["message"] ??
      "Error when processing, status code : ${response.statusCode}";
  final errors = response.data["errors"];

  if (errors != null) {
    final errorMessages = <String>[];
    errors.forEach((key, value) {
      errorMessages.addAll(value.map<String>((msg) => "$msg"));
    });
    errorMessage = errorMessages.join('\n');
  }

  return DataFailed<T>(DioAppError(DioException(
    response: response,
    error: errorMessage,
    requestOptions: response.requestOptions,
  )));
}

// Generic function to handle Dio exceptions
DataState<T> handleDioException<T>(DioException e) {
  if (e.response?.statusCode == 500) {
    return DataFailed<T>(DioAppError(e));
  }
  final errors = e.response?.data["errors"];

  if (errors != null) {
    final errorMessages = <String>[];
    errors.forEach((key, value) {
      errorMessages.addAll(value.map<String>((msg) => "$msg"));
    });
  }

  return DataFailed<T>(DioAppError(e));
}
