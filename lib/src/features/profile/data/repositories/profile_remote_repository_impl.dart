import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:transfusio/src/core/ressources/data_state.dart';
import 'package:transfusio/src/core/services/app_services.dart';
import 'package:transfusio/src/features/auth/data/models/login_response.dart';
import 'package:transfusio/src/features/profile/data/datasources/remote/profile_api.dart';
import 'package:transfusio/src/features/profile/domain/repositories/profile_repository.dart';
import 'package:transfusio/src/shared/data/models/basic_response.dart';

class ProfileRemoteRepository implements ProfileRepository {
  ProfileRemoteRepository({required this.profileApi});

  final ProfileApi profileApi;

  @override
  Future<DataState<LoginResponse>> updateUser({
    required FormData formData,
  }) async {
    try {
      var httpResponse = await profileApi.updateUser(
        formData,
        AppServices.instance.currentUser.value!.id!,
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
        'Unexpected error during update user : $e\nStack Trace: $stackTrace',
      );
      return DataFailed(SimpleAppError(e.toString()));
    }
  }

  @override
  Future<DataState<BasicResponse>> updatePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      var httpResponse = await profileApi.updatePassword({
        "old_password": oldPassword,
        "new_password": newPassword,
      }, AppServices.instance.currentUser.value!.id!);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return handleError<BasicResponse>(httpResponse.response);
      }
    } on DioException catch (e) {
      return handleDioException<BasicResponse>(e);
    } catch (e, stackTrace) {
      debugPrint(
        'Unexpected error during update user password : $e\nStack Trace: $stackTrace',
      );
      return DataFailed(SimpleAppError(e.toString()));
    }
  }

  @override
  Future<DataState<BasicResponse>> deleteAccount() async {
    try {
      var httpResponse = await profileApi.deleteAccount({});

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return handleError<BasicResponse>(httpResponse.response);
      }
    } on DioException catch (e) {
      return handleDioException<BasicResponse>(e);
    } catch (e, stackTrace) {
      debugPrint(
        'Unexpected error during deleting user : $e\nStack Trace: $stackTrace',
      );
      return DataFailed(SimpleAppError(e.toString()));
    }
  }
}
