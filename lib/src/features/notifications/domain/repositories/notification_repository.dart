import 'package:transfusio/src/core/ressources/data_state.dart';
import 'package:transfusio/src/features/notifications/data/models/notifications_response.dart';
import 'package:transfusio/src/shared/data/models/basic_response.dart';

abstract interface class NotificationRepository {
  Future<DataState<NotificationsResponse>> getMyNotifications();

  Future<DataState<BasicResponse>> editNotification({
    required bool isRead,
    required int notificationId,
  });
}
