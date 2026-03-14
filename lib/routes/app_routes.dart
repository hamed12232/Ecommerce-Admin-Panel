import 'package:flutter/material.dart';

import '../features/auth/modules/forget_password/view/forget_password_screen.dart';
import '../features/auth/modules/login/view/login_screen.dart';
import '../features/auth/modules/reset_password/view/reset_password_screen.dart';
import '../features/dashboard/screens/dashboard_screen.dart';

class AppRoutes {
  // ── Auth route names ──────────────────────────────────────────
  static const String login = '/login';
  static const String forgetPassword = '/forget-password';
  static const String resetPassword = '/reset-password';

  static const String dashboard = '/dashboard';
  static const String authInitialRoute = login;
  static const String appInitialRoute = dashboard;

  static Route<dynamic> onGenerateAuthRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return _page(const LoginScreen(), settings);

      case forgetPassword:
        return _page(const ForgetPasswordScreen(), settings);

      case resetPassword:
        final email = settings.arguments as String;
        return _page(ResetPasswordScreen(email: email), settings);

      default:
        return _page(const LoginScreen(), settings);
    }
  }

  static Route<dynamic> onGenerateAppRoute(RouteSettings settings) {
    switch (settings.name) {
      case dashboard:
        return _page(const DashboardScreen(), settings);
      default:
        return _page(const DashboardScreen(), settings);
    }
  }

  static MaterialPageRoute<dynamic> _page(Widget page, RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => page,
    );
  }
}
