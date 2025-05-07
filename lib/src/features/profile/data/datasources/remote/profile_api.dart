import 'package:dio/dio.dart';
import 'package:transfusio/src/features/auth/data/models/login_response.dart';
import 'package:transfusio/src/shared/data/models/basic_response.dart';
import 'package:retrofit/retrofit.dart';
part 'profile_api.g.dart';

@RestApi()
abstract class ProfileApi {
  factory ProfileApi(Dio dio, {String baseUrl}) = _ProfileApi;

  @PUT("api/transfusio/user/{id}")
  Future<HttpResponse<LoginResponse>> updateUser(
    @Body() FormData formData,
    @Path("id") int id,
  );

  @PUT("api/transfusio/user/update-password/{id}")
  Future<HttpResponse<BasicResponse>> updatePassword(
    @Body() Map<String, dynamic> params,
    @Path("id") int id,
  );

  @DELETE("api/transfusio/user/delete-account")
  Future<HttpResponse<BasicResponse>> deleteAccount(
    @Body() Map<String, dynamic> params,
  );
}
