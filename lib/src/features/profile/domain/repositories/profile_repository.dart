import 'package:dio/dio.dart';
import 'package:transfusio/src/core/ressources/data_state.dart';
import 'package:transfusio/src/features/auth/data/models/login_response.dart';
import 'package:transfusio/src/shared/data/models/basic_response.dart';

abstract interface class ProfileRepository {
  Future<DataState<LoginResponse>> updateUser({required FormData formData});
  Future<DataState<BasicResponse>> updatePassword({
    required String oldPassword,
    required String newPassword,
  });

  Future<DataState<BasicResponse>> deleteAccount();
}
