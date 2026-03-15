import 'package:get_it/get_it.dart';
import 'package:yt_ecommerce_admin_panel/features/auth/data/datasources/admin_auth_data_source.dart';
import 'package:yt_ecommerce_admin_panel/features/auth/data/datasources/base_admin_auth_data_source.dart';
import 'package:yt_ecommerce_admin_panel/features/auth/data/repositories/admin_auth_repository.dart';
import 'package:yt_ecommerce_admin_panel/features/auth/domain/repositories/base_admin_auth_repository.dart';
import 'package:yt_ecommerce_admin_panel/features/auth/domain/usecases/admin_login_usecase.dart';
import 'package:yt_ecommerce_admin_panel/features/auth/domain/usecases/admin_logout_usecase.dart';
import 'package:yt_ecommerce_admin_panel/features/auth/domain/usecases/admin_send_password_reset_usecase.dart';
import 'package:yt_ecommerce_admin_panel/features/auth/domain/usecases/admin_signup_usecase.dart';
import 'package:yt_ecommerce_admin_panel/features/auth/domain/usecases/fetch_admin_role_usecase.dart';
import 'package:yt_ecommerce_admin_panel/features/auth/modules/forget_password/controller/cubit/forget_password_cubit.dart';
import 'package:yt_ecommerce_admin_panel/features/auth/modules/login/controller/cubit/login_cubit.dart';
import 'package:yt_ecommerce_admin_panel/features/personalization/controller/user_cubit.dart';
import 'package:yt_ecommerce_admin_panel/features/personalization/data/datasources/base_user_data_source.dart';
import 'package:yt_ecommerce_admin_panel/features/personalization/data/datasources/user_data_source.dart';
import 'package:yt_ecommerce_admin_panel/features/personalization/data/repositories/user_repository_impl.dart';
import 'package:yt_ecommerce_admin_panel/features/personalization/domain/repositories/base_user_repository.dart';
import 'package:yt_ecommerce_admin_panel/features/personalization/domain/usecases/fetch_user_details_usecase.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // ========== Data Sources ==========
  getIt.registerLazySingleton<BaseAdminAuthDataSource>(
    () => AdminAuthDataSource(),
  );

  getIt.registerLazySingleton<BaseUserDataSource>(
    () => UserDataSource(),
  );

  // ========== Repositories ==========
  getIt.registerLazySingleton<BaseAdminAuthRepository>(
    () => AdminAuthRepository(dataSource: getIt<BaseAdminAuthDataSource>()),
  );

  getIt.registerLazySingleton<BaseUserRepository>(
    () => UserRepository(getIt<BaseUserDataSource>()),
  );

  // ========== Use Cases ==========
  getIt.registerLazySingleton<AdminLoginUseCase>(
    () => AdminLoginUseCase(getIt<BaseAdminAuthRepository>()),
  );

  getIt.registerLazySingleton<AdminSignupUseCase>(
    () => AdminSignupUseCase(repository: getIt<BaseAdminAuthRepository>()),
  );

  getIt.registerLazySingleton<AdminLogoutUseCase>(
    () => AdminLogoutUseCase(getIt<BaseAdminAuthRepository>()),
  );

  getIt.registerLazySingleton<AdminSendPasswordResetUseCase>(
    () => AdminSendPasswordResetUseCase(getIt<BaseAdminAuthRepository>()),
  );

  getIt.registerLazySingleton<FetchAdminRoleUseCase>(
    () => FetchAdminRoleUseCase(getIt<BaseAdminAuthRepository>()),
  );

  getIt.registerLazySingleton<FetchUserDetailsUseCase>(
    () => FetchUserDetailsUseCase(getIt<BaseUserRepository>()),
  );

  // ========== Cubits ==========
  getIt.registerFactory<LoginCubit>(
    () => LoginCubit(
      adminLoginUseCase: getIt<AdminLoginUseCase>(),
      fetchAdminRoleUseCase: getIt<FetchAdminRoleUseCase>(),
    ),
  );

  getIt.registerFactory<ForgetPasswordCubit>(
    () => ForgetPasswordCubit(
      sendPasswordResetUseCase: getIt<AdminSendPasswordResetUseCase>(),
    ),
  );

  getIt.registerFactory<UserCubit>(
    () => UserCubit(getIt<FetchUserDetailsUseCase>()),
  );
}
