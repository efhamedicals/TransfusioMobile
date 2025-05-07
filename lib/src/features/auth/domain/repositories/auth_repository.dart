import 'package:dio/dio.dart';
import 'package:transfusio/src/core/ressources/data_state.dart';
import 'package:transfusio/src/features/auth/data/models/login_response.dart';
import 'package:transfusio/src/shared/data/models/basic_response.dart';

abstract interface class AuthRepository {
  Future<DataState<LoginResponse>> login({String? email, String? phone});

  Future<DataState<BasicResponse>> setNewPassword({
    String? email,
    String? phone,
    String? password,
  });

  Future<DataState<LoginResponse>> verifyPassword({int? id, String? password});

  Future<DataState<BasicResponse>> setFcmDeviceToken({String? deviceToken});

  Future<DataState<LoginResponse>> sendOtp({
    String? email,
    String? phone,
    bool? isNew,
    int? userId,
  });

  Future<DataState<LoginResponse>> register({required FormData formData});
}
