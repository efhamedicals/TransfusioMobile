import 'package:transfusio/src/core/ressources/data_state.dart';
import 'package:transfusio/src/core/utils/usecases/usecase.dart';
import 'package:transfusio/src/features/notifications/data/models/notifications_response.dart';
import 'package:transfusio/src/features/notifications/domain/repositories/notification_repository.dart';

class GetNotificationsUseCase
    implements UseCase<NotificationsResponse, NoParams> {
  final NotificationRepository notificationRepository;
  const GetNotificationsUseCase(this.notificationRepository);

  @override
  Future<DataState<NotificationsResponse>> call(NoParams params) async {
    return await notificationRepository.getMyNotifications();
  }
}
