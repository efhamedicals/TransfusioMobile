import 'package:json_annotation/json_annotation.dart';
import 'package:transfusio/src/features/notifications/data/models/notification_model.dart';

part 'notifications_response.g.dart';

@JsonSerializable(explicitToJson: true)
class NotificationsResponse {
  @JsonKey(name: 'items')
  List<NotificationModel>? notifications;

  NotificationsResponse({this.notifications});

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationsResponseToJson(this);
}
