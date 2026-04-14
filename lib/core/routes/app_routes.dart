import 'package:flutter/material.dart';

import '../../features/auth/modules/forget_password/view/forget_password_screen.dart';
import '../../features/auth/modules/login/view/login_screen.dart';
import '../../features/auth/modules/reset_password/view/reset_password_screen.dart';
import '../../features/banner/data/models/banner_model.dart';
import '../../features/banner/presentation/screens/banner_screen.dart';
import '../../features/banner/presentation/screens/create_banner_screen.dart';
import '../../features/brand/data/models/brand_model.dart';
import '../../features/brand/presentation/screens/brand_screen.dart';
import '../../features/brand/presentation/screens/create_brand_screen.dart';
import '../../features/category/data/models/category_model.dart';
import '../../features/category/presentation/screens/category_screen.dart';
import '../../features/category/presentation/screens/create_category_screen.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/media/presentation/screens/media_screen.dart';

class AppRoutes {
  // ── Auth route names ──────────────────────────────────────────
  static const String login = '/login';
  static const String forgetPassword = '/forget-password';
  static const String resetPassword = '/reset-password';

  static const String dashboard = '/dashboard';
  static const String media = '/media';
  static const String categories = '/categories';
  static const String createCategory = '/categories/create';
  static const String editCategory = '/categories/edit';
  static const String brands = '/brands';
  static const String createBrand = '/brands/create';
  static const String editBrand = '/brands/edit';
  static const String banners = '/banners';
  static const String createBanner = '/banners/create';
  static const String editBanner = '/banners/edit';

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
      case '/':
        return _page(const DashboardScreen(), settings);
      case media:
        return _page(const MediaScreen(), settings);
      case categories:
        return _page(const CategoryScreen(), settings);
      case createCategory:
        return _page(const CreateCategoryScreen(), settings);
      case editCategory:
        final category = settings.arguments as CategoryModel;
        return _page(CreateCategoryScreen(category: category), settings);
      case brands:
        return _page(const BrandScreen(), settings);
      case createBrand:
        return _page(const CreateBrandScreen(), settings);
      case editBrand:
        final brand = settings.arguments as BrandModel;
        return _page(CreateBrandScreen(brand: brand), settings);
      case banners:
        return _page(const BannerScreen(), settings);
      case createBanner:
        return _page(const CreateBannerScreen(), settings);
      case editBanner:
        final banner = settings.arguments as BannerModel;
        return _page(CreateBannerScreen(banner: banner), settings);
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
