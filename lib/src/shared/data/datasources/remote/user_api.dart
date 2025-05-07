import 'package:dio/dio.dart';
import 'package:transfusio/src/features/auth/data/models/user_model.dart';
import 'package:retrofit/retrofit.dart';

part 'user_api.g.dart';

@RestApi()
abstract class UserApi {
  factory UserApi(Dio dio, {String baseUrl}) = _UserApi;

  @GET("api/users/show")
  Future<HttpResponse<UserModel>> getUserInfos();
}
