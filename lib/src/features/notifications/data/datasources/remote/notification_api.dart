import 'package:dio/dio.dart';
import 'package:transfusio/src/features/notifications/data/models/notifications_response.dart';
import 'package:transfusio/src/shared/data/models/basic_response.dart';
import 'package:retrofit/retrofit.dart';

part 'notification_api.g.dart';

@RestApi()
abstract class NotificationApi {
  factory NotificationApi(Dio dio, {String baseUrl}) = _NotificationApi;

  @GET("api/notifications")
  Future<HttpResponse<NotificationsResponse>> getMyNotifications();

  @PUT("api/notifications/{id}")
  Future<HttpResponse<BasicResponse>> editNotification(
    @Body() Map<String, dynamic> params,
    @Path("id") int id,
  );
}
