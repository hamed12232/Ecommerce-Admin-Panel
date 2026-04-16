import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/di/service_locator.dart';

import '../../features/auth/modules/forget_password/view/forget_password_screen.dart';
import '../../features/auth/modules/login/view/login_screen.dart';
import '../../features/auth/modules/reset_password/view/reset_password_screen.dart';
import '../../features/banner/data/models/banner_model.dart';
import '../../features/banner/presentation/screens/banner_screen.dart';
import '../../features/banner/presentation/screens/create_banner_screen.dart';
import '../../features/banner/presentation/cubit/banner_cubit.dart';
import '../../features/brand/data/models/brand_model.dart';
import '../../features/brand/presentation/screens/brand_screen.dart';
import '../../features/brand/presentation/screens/create_brand_screen.dart';
import '../../features/brand/presentation/cubit/brand_cubit.dart';
import '../../features/category/data/models/category_model.dart';
import '../../features/category/presentation/screens/category_screen.dart';
import '../../features/category/presentation/screens/create_category_screen.dart';
import '../../features/category/presentation/cubit/category_cubit.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/media/presentation/screens/media_screen.dart';
import '../../features/product/data/models/product_model.dart';
import '../../features/product/presentation/screens/product_screen.dart';
import '../../features/product/presentation/screens/create_product_screen.dart';
import '../../features/product/presentation/cubit/product_cubit.dart';

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
  static const String products = '/products';
  static const String createProduct = '/products/create';
  static const String editProduct = '/products/edit';

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
        return _page(
            BlocProvider(
              create: (_) => getIt<CategoryCubit>(),
              child: const CategoryScreen(),
            ),
            settings);
      case createCategory:
        return _page(
            BlocProvider(
              create: (_) => getIt<CategoryCubit>(),
              child: const CreateCategoryScreen(),
            ),
            settings);
      case editCategory:
        final category = settings.arguments as CategoryModel;
        return _page(
            BlocProvider(
              create: (_) => getIt<CategoryCubit>(),
              child: CreateCategoryScreen(category: category),
            ),
            settings);
      case brands:
        return _page(
            BlocProvider(
              create: (_) => getIt<BrandCubit>(),
              child: const BrandScreen(),
            ),
            settings);
      case createBrand:
        return _page(
            BlocProvider(
              create: (_) => getIt<BrandCubit>(),
              child: const CreateBrandScreen(),
            ),
            settings);
      case editBrand:
        final brand = settings.arguments as BrandModel;
        return _page(
            BlocProvider(
              create: (_) => getIt<BrandCubit>(),
              child: CreateBrandScreen(brand: brand),
            ),
            settings);
      case banners:
        return _page(
            BlocProvider(
              create: (_) => getIt<BannerCubit>(),
              child: const BannerScreen(),
            ),
            settings);
      case createBanner:
        return _page(
            BlocProvider(
              create: (_) => getIt<BannerCubit>(),
              child: const CreateBannerScreen(),
            ),
            settings);
      case editBanner:
        final banner = settings.arguments as BannerModel;
        return _page(
            BlocProvider(
              create: (_) => getIt<BannerCubit>(),
              child: CreateBannerScreen(banner: banner),
            ),
            settings);
      case products:
        return _page(
            BlocProvider(
              create: (_) => getIt<ProductCubit>(),
              child: const ProductScreen(),
            ),
            settings);
      case createProduct:
        return _page(
            BlocProvider(
              create: (_) => getIt<ProductCubit>(),
              child: const CreateProductScreen(),
            ),
            settings);
      case editProduct:
        final product = settings.arguments as ProductModel;
        return _page(
            BlocProvider(
              create: (_) => getIt<ProductCubit>(),
              child: CreateProductScreen(product: product),
            ),
            settings);
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
