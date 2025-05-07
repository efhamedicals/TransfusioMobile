import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:transfusio/src/core/ressources/data_state.dart';
import 'package:transfusio/src/features/auth/data/datasources/remote/auth_api.dart';
import 'package:transfusio/src/features/auth/data/models/login_response.dart';
import 'package:transfusio/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:transfusio/src/shared/data/models/basic_response.dart';
import 'package:retrofit/dio.dart';

class AuthRemoteRepository implements AuthRepository {
  AuthRemoteRepository({required this.authApi});

  final AuthApi authApi;

  @override
  Future<DataState<LoginResponse>> login({String? email, String? phone}) async {
    try {
      final httpResponse = await authApi.userLogin({
        "email": email,
        "phone": phone,
      });

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return handleError<LoginResponse>(httpResponse.response);
      }
    } on DioException catch (e) {
      return handleDioException<LoginResponse>(e);
    } catch (e, stackTrace) {
      debugPrint(
        'Unexpected error during login : $e\nStack Trace: $stackTrace',
      );
      return DataFailed(SimpleAppError(e.toString()));
    }
  }

  @override
  Future<DataState<LoginResponse>> verifyPassword({
    int? id,
    String? password,
  }) async {
    try {
      final httpResponse = await authApi.userVerifyPassword({
        "id": id,
        "password": password,
      });

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return handleError<LoginResponse>(httpResponse.response);
      }
    } on DioException catch (e) {
      return handleDioException<LoginResponse>(e);
    } catch (e, stackTrace) {
      debugPrint(
        'Unexpected error during verifyPassword : $e\nStack Trace: $stackTrace',
      );
      return DataFailed(SimpleAppError(e.toString()));
    }
  }

  @override
  Future<DataState<BasicResponse>> setFcmDeviceToken({
    String? deviceToken,
  }) async {
    try {
      final httpResponse = await authApi.userSetFcmToken({
        "device_token": deviceToken,
      });

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return handleError<BasicResponse>(httpResponse.response);
      }
    } on DioException catch (e) {
      return handleDioException<BasicResponse>(e);
    } catch (e, stackTrace) {
      debugPrint(
        'Unexpected error during setFcmDeviceToken : $e\nStack Trace: $stackTrace',
      );
      return DataFailed(SimpleAppError(e.toString()));
    }
  }

  @override
  Future<DataState<LoginResponse>> sendOtp({
    String? email,
    String? phone,
    bool? isNew,
    int? userId,
  }) async {
    try {
      final httpResponse = await authApi.sendOtp({
        "email": email,
        "phone": phone,
        "is_new": isNew,
        "user_id": userId,
      });

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return handleError<LoginResponse>(httpResponse.response);
      }
    } on DioException catch (e) {
      return handleDioException<LoginResponse>(e);
    } catch (e, stackTrace) {
      debugPrint(
        'Unexpected error during sendOtp : $e\nStack Trace: $stackTrace',
      );
      return DataFailed(SimpleAppError(e.toString()));
    }
  }

  @override
  Future<DataState<LoginResponse>> register({
    required FormData formData,
  }) async {
    try {
      HttpResponse<LoginResponse> httpResponse = await authApi.userRegister(
        formData,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return handleError<LoginResponse>(httpResponse.response);
      }
    } on DioException catch (e) {
      return handleDioException<LoginResponse>(e);
    } catch (e, stackTrace) {
      debugPrint(
        'Unexpected error during register : $e\nStack Trace: $stackTrace',
      );
      return DataFailed(SimpleAppError(e.toString()));
    }
  }

  @override
  Future<DataState<BasicResponse>> setNewPassword({
    String? email,
    String? phone,
    String? password,
  }) async {
    try {
      final httpResponse = await authApi.setNewPassword({
        "email": email,
        "phone": phone,
        "new_password": password,
      });

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return handleError<BasicResponse>(httpResponse.response);
      }
    } on DioException catch (e) {
      return handleDioException<BasicResponse>(e);
    } catch (e, stackTrace) {
      debugPrint(
        'Unexpected error during setNewPassword : $e\nStack Trace: $stackTrace',
      );
      return DataFailed(SimpleAppError(e.toString()));
    }
  }
}
