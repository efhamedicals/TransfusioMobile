import 'package:json_annotation/json_annotation.dart';
import 'package:transfusio/src/features/notifications/domain/entities/notification.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel extends Notification {
  @override
  @JsonKey(name: 'id')
  int? get id => super.id;

  @override
  @JsonKey(name: 'title')
  String? get title => super.title;

  @override
  @JsonKey(name: 'content')
  String? get content => super.content;

  @override
  @JsonKey(name: 'is_read')
  bool? get isRead => super.isRead;

  @override
  @JsonKey(name: 'created_at')
  String? get createdAt => super.createdAt;

  @override
  @JsonKey(name: 'status')
  int? get status => super.status;

  const NotificationModel({
    super.id,
    super.title,
    super.content,
    super.isRead,
    super.status,
    super.createdAt,
  });

  /// Factory method for deserializing JSON
  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  /// Method for serializing to JSON
  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
