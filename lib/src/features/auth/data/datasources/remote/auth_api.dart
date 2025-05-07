import 'package:dio/dio.dart';
import 'package:transfusio/src/features/auth/data/models/login_response.dart';
import 'package:transfusio/src/shared/data/models/basic_response.dart';
import 'package:retrofit/retrofit.dart';
part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @POST("api/transfusio/auth/login")
  Future<HttpResponse<LoginResponse>> userLogin(
    @Body() Map<String, dynamic> params,
  );

  @POST("api/transfusio/auth/check-password")
  Future<HttpResponse<LoginResponse>> userVerifyPassword(
    @Body() Map<String, dynamic> params,
  );

  @PUT("api/transfusio/auth/set-fcm-token")
  Future<HttpResponse<BasicResponse>> userSetFcmToken(
    @Body() Map<String, dynamic> params,
  );

  @POST("api/transfusio/auth/send-otp")
  Future<HttpResponse<LoginResponse>> sendOtp(
    @Body() Map<String, dynamic> params,
  );

  @POST("api/transfusio/auth/register")
  Future<HttpResponse<LoginResponse>> userRegister(@Body() FormData formData);

  @POST("api/transfusio/auth/set-password")
  Future<HttpResponse<BasicResponse>> setNewPassword(
    @Body() Map<String, dynamic> params,
  );
}
