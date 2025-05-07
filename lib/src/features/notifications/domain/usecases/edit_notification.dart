import 'package:transfusio/src/core/ressources/data_state.dart';
import 'package:transfusio/src/core/utils/usecases/usecase.dart';
import 'package:transfusio/src/features/notifications/domain/repositories/notification_repository.dart';
import 'package:transfusio/src/shared/data/models/basic_response.dart';

class EditNotificationUseCase
    implements UseCase<BasicResponse, EditNotificationParam> {
  final NotificationRepository notificationRepository;
  const EditNotificationUseCase(this.notificationRepository);

  @override
  Future<DataState<BasicResponse>> call(EditNotificationParam params) async {
    return await notificationRepository.editNotification(
      isRead: params.isRead!,
      notificationId: params.notificationId!,
    );
  }
}

class EditNotificationParam {
  final bool? isRead;

  final int? notificationId;

  EditNotificationParam({this.isRead, this.notificationId});
}
