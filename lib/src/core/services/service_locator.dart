import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:transfusio/src/core/network/dio_service.dart';
import 'package:transfusio/src/core/services/fcm_token_service.dart';
import 'package:transfusio/src/features/auth/data/repositories/auth_remote_repository_impl.dart';
import 'package:transfusio/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:transfusio/src/features/auth/domain/usecases/login_usecase.dart';
import 'package:transfusio/src/features/auth/domain/usecases/register_usecase.dart';
import 'package:transfusio/src/features/auth/domain/usecases/send_otp_usecase.dart';
import 'package:transfusio/src/features/auth/domain/usecases/set_fcm_device_usecase.dart';
import 'package:transfusio/src/features/auth/domain/usecases/set_new_password_usecase.dart';
import 'package:transfusio/src/features/auth/domain/usecases/verify_password_usecase.dart';
import 'package:transfusio/src/features/auth/presentation/view_models/auth_view_model.dart';
import 'package:transfusio/src/features/dashboard/data/repositories/dashboard_remote_repository.dart';
import 'package:transfusio/src/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:transfusio/src/features/dashboard/domain/usecases/get_stats_use_case.dart';
import 'package:transfusio/src/features/dashboard/presentation/view_models/dashboard_view_model.dart';
import 'package:transfusio/src/features/notifications/data/repositories/notification_repository_remote.dart';
import 'package:transfusio/src/features/notifications/domain/repositories/notification_repository.dart';
import 'package:transfusio/src/features/notifications/domain/usecases/edit_notification.dart';
import 'package:transfusio/src/features/notifications/domain/usecases/get_notifications.dart';
import 'package:transfusio/src/features/notifications/presentation/view_models/notification_view_model.dart';
import 'package:transfusio/src/features/onboarding/presentation/view_models/onboarding_view_model.dart';
import 'package:transfusio/src/features/profile/data/repositories/profile_remote_repository_impl.dart';
import 'package:transfusio/src/features/profile/domain/repositories/profile_repository.dart';
import 'package:transfusio/src/features/profile/domain/usecases/delete_account_user_case.dart';
import 'package:transfusio/src/features/profile/domain/usecases/update_password_use_case.dart';
import 'package:transfusio/src/features/profile/domain/usecases/update_user_use_case.dart';
import 'package:transfusio/src/features/profile/presentation/view_models/profile_view_model.dart';
import 'package:transfusio/src/features/psl_requests/data/repositories/psl_request_remote_repository.dart';
import 'package:transfusio/src/features/psl_requests/domain/repositories/psl_request_repository.dart';
import 'package:transfusio/src/features/psl_requests/domain/usecases/add_psl_request.dart';
import 'package:transfusio/src/features/psl_requests/domain/usecases/check_psl_request.dart';
import 'package:transfusio/src/features/psl_requests/domain/usecases/delete_psl_request.dart';
import 'package:transfusio/src/features/psl_requests/domain/usecases/get_psl_requests.dart';
import 'package:transfusio/src/features/psl_requests/domain/usecases/pay_psl_request.dart';
import 'package:transfusio/src/features/psl_requests/domain/usecases/recheck_psl_request.dart';
import 'package:transfusio/src/features/psl_requests/presentation/view_models/psl_request_view_model.dart';
import 'package:transfusio/src/shared/data/repositories/user_remote_repository.dart';
import 'package:transfusio/src/shared/domain/repositories/user_repository.dart';
import 'package:transfusio/src/shared/domain/usecases/get_user_infos.dart';
import 'package:transfusio/src/shared/presentation/view_models/theme_view_model.dart';

final GetIt locator = GetIt.instance;

void setupLocator(GoRouter router) {
  //Data Repositories
  final authApi = AppDioService.getAuthApi();
  final dashboardApi = AppDioService.getDashboardApi();
  final pslRequestApi = AppDioService.getPslRequestApi();
  final userApi = AppDioService.getUserApi();
  final profileApi = AppDioService.getProfileApi();
  final notificationApi = AppDioService.getNotificationApi();

  //Services
  locator.registerLazySingleton(() => FcmTokenService());

  // Domain Repositories
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRemoteRepository(authApi: authApi),
  );
  locator.registerLazySingleton<DashboardRepository>(
    () => DashboardRemoteRepository(dashboardApi: dashboardApi),
  );
  locator.registerLazySingleton<PslRequestRepository>(
    () => PslRequestRemoteRepository(pslRequestApi: pslRequestApi),
  );
  locator.registerLazySingleton<UserRepository>(
    () => UserRemoteRepository(userApi: userApi),
  );
  locator.registerLazySingleton<ProfileRepository>(
    () => ProfileRemoteRepository(profileApi: profileApi),
  );
  locator.registerLazySingleton<NotificationRepository>(
    () => NotificationRemoteRepository(notificationApi: notificationApi),
  );

  // UseCases
  locator.registerLazySingleton(() => LoginUseCase(locator()));
  locator.registerLazySingleton(() => VerifyPasswordUseCase(locator()));
  locator.registerLazySingleton(() => SetFcmDeviceUseCase(locator()));
  locator.registerLazySingleton(() => SendOtpUseCase(locator()));
  locator.registerLazySingleton(() => RegisterUseCase(locator()));
  locator.registerLazySingleton(() => SetNewPasswordUseCase(locator()));

  locator.registerLazySingleton(() => GetStatsUseCase(locator()));

  locator.registerLazySingleton(() => GetPslRequestsUseCase(locator()));
  locator.registerLazySingleton(() => AddPslRequestUseCase(locator()));
  locator.registerLazySingleton(() => CheckPslRequestUseCase(locator()));
  locator.registerLazySingleton(() => ReCheckPslRequestUseCase(locator()));
  locator.registerLazySingleton(() => DeletePslRequestUseCase(locator()));
  locator.registerLazySingleton(() => PayPslRequestUseCase(locator()));

  locator.registerLazySingleton(() => GetUserInfosUseCase(locator()));
  locator.registerLazySingleton(() => UpdateUserUseCase(locator()));
  locator.registerLazySingleton(() => UpdatePasswordUseCase(locator()));
  locator.registerLazySingleton(() => DeleteAccountUserCase(locator()));

  locator.registerLazySingleton(() => GetNotificationsUseCase(locator()));
  locator.registerLazySingleton(() => EditNotificationUseCase(locator()));

  // Load ViewModels
  locator.registerSingleton(ThemeViewModel());
  locator.registerSingleton(OnBoardingViewModel());

  locator.registerFactory(
    () => AuthViewModel(
      loginUseCase: locator<LoginUseCase>(),
      verifyPasswordUseCase: locator<VerifyPasswordUseCase>(),
      setFcmDeviceUseCase: locator<SetFcmDeviceUseCase>(),
      sendOtpUseCase: locator<SendOtpUseCase>(),
      registerUseCase: locator<RegisterUseCase>(),
      fcmTokenService: locator<FcmTokenService>(),
      setNewPasswordUseCase: locator<SetNewPasswordUseCase>(),
    ),
  );

  locator.registerFactory(
    () => DashboardViewModel(getStatsUseCase: locator<GetStatsUseCase>()),
  );

  locator.registerFactory(
    () => PslRequestViewModel(
      addPslRequestUseCase: locator<AddPslRequestUseCase>(),
      getPslRequestsUseCase: locator<GetPslRequestsUseCase>(),
      payPslRequestUseCase: locator<PayPslRequestUseCase>(),
      checkPslRequestUseCase: locator<CheckPslRequestUseCase>(),
      recheckPslRequestUseCase: locator<ReCheckPslRequestUseCase>(),
      deletePslRequestUseCase: locator<DeletePslRequestUseCase>(),
    ),
  );

  locator.registerFactory(
    () => ProfileViewModel(
      updateUserUseCase: locator<UpdateUserUseCase>(),
      updatePasswordUseCase: locator<UpdatePasswordUseCase>(),
      sendOtpUseCase: locator<SendOtpUseCase>(),
      deleteAccountUserCase: locator<DeleteAccountUserCase>(),
      verifyPasswordUseCase: locator<VerifyPasswordUseCase>(),
    ),
  );

  locator.registerFactory(
    () => NotificationViewModel(
      getNotificationsUseCase: locator<GetNotificationsUseCase>(),
      editNotificationUseCase: locator<EditNotificationUseCase>(),
    ),
  );
}
