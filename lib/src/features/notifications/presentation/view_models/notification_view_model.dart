import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transfusio/src/core/ressources/data_state.dart';
import 'package:transfusio/src/core/utils/usecases/usecase.dart';
import 'package:transfusio/src/features/notifications/data/models/notification_model.dart';
import 'package:transfusio/src/features/notifications/data/models/notifications_response.dart';
import 'package:transfusio/src/features/notifications/domain/usecases/edit_notification.dart';
import 'package:transfusio/src/features/notifications/domain/usecases/get_notifications.dart';

class NotificationViewModel extends GetxController {
  // UseCases
  final GetNotificationsUseCase getNotificationsUseCase;
  final EditNotificationUseCase editNotificationUseCase;

  RxBool isLoading = false.obs;
  var notifications = <NotificationModel>[].obs;

  NotificationViewModel({
    required this.getNotificationsUseCase,
    required this.editNotificationUseCase,
  });

  void setIsLoading(bool value) => isLoading.value = value;

  Future<void> getNotifications() async {
    try {
      setIsLoading(true);
      final response = await getNotificationsUseCase.call(NoParams());

      if (response is DataSuccess<NotificationsResponse>) {
        debugPrint("Good response => ${response.data!.toJson()}");
        notifications.assignAll(response.data!.notifications ?? []);
        setIsLoading(false);
      } else if (response is DataFailed) {}
    } catch (error, stackTrace) {
      debugPrint("Error loading info: $error\nStack Trace: $stackTrace");
    }
  }
}
