import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:transfusio/src/core/routers/app_routers.dart';
import 'package:transfusio/src/core/services/app_services.dart';
import 'package:transfusio/src/core/utils/constants/app_strings.dart';
import 'package:transfusio/src/features/auth/data/datasources/remote/auth_api.dart';
import 'package:transfusio/src/features/dashboard/data/datasources/remote/dashboard_api.dart';
import 'package:transfusio/src/features/notifications/data/datasources/remote/notification_api.dart';
import 'package:transfusio/src/features/profile/data/datasources/remote/profile_api.dart';
import 'package:transfusio/src/features/psl_requests/data/datasources/remote/psl_request_api.dart';
import 'package:transfusio/src/shared/data/datasources/remote/user_api.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../services/storage/app_storage.dart';

class AppDioService {
  DioException? dioError;
  static AppDioService? appDioService;
  static AuthApi? authApi;
  static DashboardApi? dashboardApi;
  static PslRequestApi? pslRequestApi;
  static ProfileApi? profileApi;
  static UserApi? userApi;
  static NotificationApi? notificationApi;

  static Dio dio = Dio(BaseOptions(baseUrl: baseUrl));

  AppDioService._() {
    addInterceptor();
  }

  static AppDioService getInstance() {
    appDioService ??= AppDioService._();
    return appDioService!;
  }

  static AuthApi getAuthApi() {
    if (authApi == null) {
      AppDioService.getInstance();
      authApi = AuthApi(dio, baseUrl: baseUrl);
    }
    return authApi!;
  }

  static DashboardApi getDashboardApi() {
    if (dashboardApi == null) {
      AppDioService.getInstance();
      dashboardApi = DashboardApi(dio, baseUrl: baseUrl);
    }
    return dashboardApi!;
  }

  static PslRequestApi getPslRequestApi() {
    if (pslRequestApi == null) {
      AppDioService.getInstance();
      pslRequestApi = PslRequestApi(dio, baseUrl: baseUrl);
    }
    return pslRequestApi!;
  }

  static ProfileApi getProfileApi() {
    if (profileApi == null) {
      AppDioService.getInstance();
      profileApi = ProfileApi(dio, baseUrl: baseUrl);
    }
    return profileApi!;
  }

  static UserApi getUserApi() {
    if (userApi == null) {
      AppDioService.getInstance();
      userApi = UserApi(dio, baseUrl: baseUrl);
    }
    return userApi!;
  }

  static NotificationApi getNotificationApi() {
    if (notificationApi == null) {
      AppDioService.getInstance();
      notificationApi = NotificationApi(dio, baseUrl: baseUrl);
    }
    return notificationApi!;
  }

  void addInterceptor() {
    dio.interceptors.clear();

    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          compact: true,
          error: true,
          maxWidth: 100,
        ),
      );
    }

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (
          RequestOptions options,
          RequestInterceptorHandler handlerRequest,
        ) async {
          options.headers.addAll({
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Cache-Control': 'no-cache',
            'Accept-language': AppServices.instance.codeLang,
          });

          final authToken = AppServices.instance.authTokenUser;
          if (authToken!.isNotEmpty) {
            options.headers['Authorization'] = "Bearer $authToken";
          }
          debugPrint("Token user : $authToken");

          return handlerRequest.next(options);
        },
        onResponse: (
          Response response,
          ResponseInterceptorHandler handlerResponse,
        ) {
          return handlerResponse.next(response);
        },
        onError: (DioException e, ErrorInterceptorHandler handlerError) async {
          debugPrint("Error interceptor webservice : ${e.error}");
          if (e.response?.statusCode == 401) {
            debugPrint("Logout user");
            await AppStorage.instance.deleteDataLocal();
            await AppServices.instance.checkUser();
            AppRouter.router.go(AppRouter.loginPage);
          } else if (e.response?.statusCode == 404) {
            debugPrint("Invalid route");
          } else if (e.response?.statusCode == 500) {
            debugPrint("Server error");
          }
          return handlerError.next(e);
        },
      ),
    );
  }
}
