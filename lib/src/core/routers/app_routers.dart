import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:transfusio/src/core/routers/logging_observer_route.dart';
import 'package:transfusio/src/features/auth/presentation/pages/login_screen.dart';
import 'package:transfusio/src/features/auth/presentation/pages/new_password_screen.dart';
import 'package:transfusio/src/features/auth/presentation/pages/otp_screen.dart';
import 'package:transfusio/src/features/auth/presentation/pages/password_screen.dart';
import 'package:transfusio/src/features/auth/presentation/pages/register_screen.dart';
import 'package:transfusio/src/features/dashboard/presentation/pages/dashboard_screen.dart';
import 'package:transfusio/src/features/notifications/presentation/pages/notifications_screen.dart';
import 'package:transfusio/src/features/onboarding/presentation/pages/onboarding_screen.dart';
import 'package:transfusio/src/features/profile/presentation/pages/edit_password_screen.dart';
import 'package:transfusio/src/features/profile/presentation/pages/edit_profile_screen.dart';
import 'package:transfusio/src/features/profile/presentation/pages/legal_app_screen.dart';
import 'package:transfusio/src/features/profile/presentation/pages/legal_content_screen.dart';
import 'package:transfusio/src/features/profile/presentation/pages/report_bug_screen.dart';
import 'package:transfusio/src/features/profile/presentation/pages/update_email_or_phone_screen.dart';
import 'package:transfusio/src/features/psl_requests/presentation/pages/add_psl_request_screen.dart';
import 'package:transfusio/src/features/psl_requests/presentation/pages/details_psl_request_screen.dart';
import 'package:transfusio/src/features/psl_requests/presentation/pages/edit_psl_request_screen.dart';
import 'package:transfusio/src/shared/data/models/psl_request_model.dart';
import 'package:transfusio/src/shared/presentation/pages/splash_screen.dart';

class AppRouter {
  static const String splashPage = "/splash";
  static const String onBoardingPage = "/onboarding";
  static const String loginPage = "/auth/login";
  static const String otpPage = "/auth/otp";
  static const String passwordPage = "/auth/password";
  static const String registerPage = "/auth/register";
  static const String setNewPasswordPage = "/auth/set-password";

  static const String dashboardPage = "/dashboard";
  static const String addPSLRequest = "/add-psl-request";
  static const String editPSLRequest = "/edit-psl-request";
  static const String detailsPSLRequest = "/details-psl-request";

  static const String editProfile = "/edit-profile";
  static const String editPassword = "/edit-password";
  static const String updatePhoneOrEmail = "/update-phone-or-email";
  static const String legalApp = "/legal-app";
  static const String legalContent = "/legal-content";
  static const String reportBug = "/report-bug";
  static const String notifications = "/notifications";

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    observers: [LoggingGoRouterObserver()],
    routes: [
      GoRoute(
        path: '/',
        builder:
            (BuildContext context, GoRouterState state) => const SplashScreen(),
      ),
      GoRoute(
        path: onBoardingPage,
        builder:
            (BuildContext context, GoRouterState state) =>
                const OnBoardingScreen(),
      ),
      GoRoute(
        path: loginPage,
        builder:
            (BuildContext context, GoRouterState state) => const LoginScreen(),
      ),
      GoRoute(
        path: otpPage,
        builder: (BuildContext context, GoRouterState state) {
          final bool isLogin = state.extra as bool;

          return OtpScreen(isLogin: isLogin);
        },
      ),
      GoRoute(
        path: passwordPage,
        builder:
            (BuildContext context, GoRouterState state) =>
                const PasswordScreen(),
      ),
      GoRoute(
        path: setNewPasswordPage,
        builder:
            (BuildContext context, GoRouterState state) =>
                const NewPasswordScreen(),
      ),

      GoRoute(
        path: registerPage,
        builder:
            (BuildContext context, GoRouterState state) =>
                const RegisterScreen(),
      ),
      GoRoute(
        path: dashboardPage,
        builder:
            (BuildContext context, GoRouterState state) =>
                const DashboardScreen(),
      ),

      GoRoute(
        path: addPSLRequest,
        builder: (BuildContext context, GoRouterState state) {
          return const AddPSLRequestScreen();
        },
      ),
      /* GoRoute(
        path: detailsPslRequest,
        builder: (BuildContext context, GoRouterState state) {
          final PslRequestModel pslRequestModel = state.extra as PslRequestModel;

          return AppServices.instance.currentUser.value!.role!.label ==
                  "Particulier"
              ? DetailsPslRequestScreen(pslRequestModel: pslRequestModel)
              : CompanyDetailsPslRequestScreen(pslRequestModel: pslRequestModel);
        },
      ),*/
      GoRoute(
        path: editPSLRequest,
        builder: (BuildContext context, GoRouterState state) {
          final PslRequestModel pslRequestModel =
              state.extra as PslRequestModel;

          return EditPslRequestScreen(pslRequestModel: pslRequestModel);
        },
      ),

      GoRoute(
        path: detailsPSLRequest,
        builder: (BuildContext context, GoRouterState state) {
          final PslRequestModel pslRequestModel =
              state.extra as PslRequestModel;

          return DetailsPslRequestScreen(pslRequestModel: pslRequestModel);
        },
      ),
      GoRoute(
        path: editProfile,
        builder:
            (BuildContext context, GoRouterState state) =>
                const EditProfileScreen(),
      ),
      GoRoute(
        path: editPassword,
        builder:
            (BuildContext context, GoRouterState state) =>
                const EditPasswordScreen(),
      ),
      GoRoute(
        path: legalApp,
        builder:
            (BuildContext context, GoRouterState state) =>
                const LegalAppScreen(),
      ),
      GoRoute(
        path: legalContent,
        builder: (BuildContext context, GoRouterState state) {
          final int type = state.extra as int;

          return LegalContentScreen(type: type);
        },
      ),
      GoRoute(
        path: reportBug,
        builder:
            (BuildContext context, GoRouterState state) =>
                const ReportBugScreen(),
      ),
      GoRoute(
        path: notifications,
        builder:
            (BuildContext context, GoRouterState state) =>
                const NotificationsScreen(),
      ),
      GoRoute(
        path: updatePhoneOrEmail,
        builder: (BuildContext context, GoRouterState state) {
          final List<bool> extras = state.extra as List<bool>;
          bool isEmail = extras[0];
          bool isFirst = extras[1];

          return UpdateEmailOrPhoneScreen(isEmail: isEmail, isFirst: isFirst);
        },
      ),
    ],
  );
}
