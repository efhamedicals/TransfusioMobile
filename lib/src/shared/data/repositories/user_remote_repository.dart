import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:transfusio/src/core/ressources/data_state.dart';
import 'package:transfusio/src/features/auth/data/models/user_model.dart';
import 'package:transfusio/src/shared/data/datasources/remote/user_api.dart';
import 'package:transfusio/src/shared/domain/repositories/user_repository.dart';

class UserRemoteRepository implements UserRepository {
  UserRemoteRepository({required this.userApi});

  final UserApi userApi;

  @override
  Future<DataState<UserModel>> getUserInfos() async {
    try {
      final httpResponse = await userApi.getUserInfos();

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return handleError<UserModel>(httpResponse.response);
      }
    } on DioException catch (e) {
      return handleDioException<UserModel>(e);
    } catch (e, stackTrace) {
      debugPrint(
        'Unexpected error during getting user infos : $e\nStack Trace: $stackTrace',
      );
      return DataFailed(SimpleAppError(e.toString()));
    }
  }
}
