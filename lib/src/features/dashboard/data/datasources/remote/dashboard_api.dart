import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:transfusio/src/features/dashboard/data/models/data_response.dart';

part 'dashboard_api.g.dart';

@RestApi()
abstract class DashboardApi {
  factory DashboardApi(Dio dio, {String baseUrl}) = _DashboardApi;

  @GET("api/transfusio/stats")
  Future<HttpResponse<DataResponse>> getStatsInfos();
}
