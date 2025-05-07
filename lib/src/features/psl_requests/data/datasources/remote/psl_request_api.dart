import 'package:dio/dio.dart';
import 'package:transfusio/src/features/psl_requests/data/models/add_psl_request_response.dart';
import 'package:transfusio/src/features/psl_requests/data/models/psl_requests_response.dart';
import 'package:transfusio/src/shared/data/models/basic_response.dart';
import 'package:retrofit/retrofit.dart';

part 'psl_request_api.g.dart';

@RestApi()
abstract class PslRequestApi {
  factory PslRequestApi(Dio dio, {String baseUrl}) = _PslRequestApi;

  @GET("api/transfusio/psl-requests")
  Future<HttpResponse<PslRequestsResponse>> getPslRequests();

  @POST("api/transfusio/psl-requests")
  Future<HttpResponse<AddPslRequestResponse>> addPslRequest(
    @Body() FormData formData,
  );

  @GET("api/transfusio/psl-requests/{id}")
  Future<HttpResponse<BasicResponse>> getSinglePslRequest();

  @POST("api/transfusio/psl-requests/{id}/check")
  Future<HttpResponse<AddPslRequestResponse>> checkPslRequest(
    @Path("id") int id,
  );

  @POST("api/transfusio/psl-requests/{id}/recheck")
  Future<HttpResponse<AddPslRequestResponse>> recheckPslRequest(
    @Path("id") int id,
  );

  @POST("api/transfusio/psl-requests/{id}/pay")
  Future<HttpResponse<BasicResponse>> payPslRequest(
    @Body() Map<String, dynamic> params,
    @Path("id") int id,
  );

  @DELETE("api/transfusio/psl-requests/{id}")
  Future<HttpResponse<BasicResponse>> deletePslRequest(@Path("id") int id);
}
