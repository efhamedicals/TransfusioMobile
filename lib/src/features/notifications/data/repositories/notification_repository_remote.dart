import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:transfusio/src/core/ressources/data_state.dart';
import 'package:transfusio/src/features/notifications/data/datasources/remote/notification_api.dart';
import 'package:transfusio/src/features/notifications/data/models/notifications_response.dart';
import 'package:transfusio/src/features/notifications/domain/repositories/notification_repository.dart';
import 'package:transfusio/src/shared/data/models/basic_response.dart';

class NotificationRemoteRepository implements NotificationRepository {
  NotificationRemoteRepository({required this.notificationApi});

  final NotificationApi notificationApi;

  @override
  Future<DataState<NotificationsResponse>> getMyNotifications() async {
    try {
      final httpResponse = await notificationApi.getMyNotifications();

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return handleError<NotificationsResponse>(httpResponse.response);
      }
    } on DioException catch (e) {
      return handleDioException<NotificationsResponse>(e);
    } catch (e, stackTrace) {
      debugPrint(
        'Unexpected error during getting notifications : $e\nStack Trace: $stackTrace',
      );
      return DataFailed(SimpleAppError(e.toString()));
    }
  }

  @override
  Future<DataState<BasicResponse>> editNotification({
    required bool isRead,
    required int notificationId,
  }) async {
    try {
      final httpResponse = await notificationApi.editNotification({
        "is_read": isRead,
      }, notificationId);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return handleError<BasicResponse>(httpResponse.response);
      }
    } on DioException catch (e) {
      return handleDioException<BasicResponse>(e);
    } catch (e, stackTrace) {
      debugPrint(
        'Unexpected error during editing notification : $e\nStack Trace: $stackTrace',
      );
      return DataFailed(SimpleAppError(e.toString()));
    }
  }
}
