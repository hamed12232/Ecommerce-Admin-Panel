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
import 'package:yt_ecommerce_admin_panel/features/banner/data/datasources/banner_data_source.dart';
import 'package:yt_ecommerce_admin_panel/features/banner/data/repositories/banner_repository.dart';
import 'package:yt_ecommerce_admin_panel/features/banner/presentation/cubit/banner_cubit.dart';
import 'package:yt_ecommerce_admin_panel/features/brand/data/datasources/brand_data_source.dart';
import 'package:yt_ecommerce_admin_panel/features/brand/data/repositories/brand_repository.dart';
import 'package:yt_ecommerce_admin_panel/features/brand/presentation/cubit/brand_cubit.dart';
import 'package:yt_ecommerce_admin_panel/features/category/data/datasources/category_data_source.dart';
import 'package:yt_ecommerce_admin_panel/features/category/data/repositories/category_repository.dart';
import 'package:yt_ecommerce_admin_panel/features/category/presentation/cubit/category_cubit.dart';
import 'package:yt_ecommerce_admin_panel/features/media/presentation/controller/media_cubit.dart';
import 'package:yt_ecommerce_admin_panel/features/media/data/data_sources/media_data_source.dart';
import 'package:yt_ecommerce_admin_panel/features/media/data/repositories/media_repository.dart';
import 'package:yt_ecommerce_admin_panel/features/media/domain/repositories/base_media_repository.dart';
import 'package:yt_ecommerce_admin_panel/features/media/domain/usecases/delete_media_image_usecase.dart';
import 'package:yt_ecommerce_admin_panel/features/media/domain/usecases/fetch_media_images_usecase.dart';
import 'package:yt_ecommerce_admin_panel/features/media/domain/usecases/upload_media_images_usecase.dart';
import 'package:yt_ecommerce_admin_panel/features/personalization/controller/user_cubit.dart';
import 'package:yt_ecommerce_admin_panel/features/personalization/data/datasources/base_user_data_source.dart';
import 'package:yt_ecommerce_admin_panel/features/personalization/data/datasources/user_data_source.dart';
import 'package:yt_ecommerce_admin_panel/features/personalization/data/repositories/user_repository_impl.dart';
import 'package:yt_ecommerce_admin_panel/features/personalization/domain/repositories/base_user_repository.dart';
import 'package:yt_ecommerce_admin_panel/features/personalization/domain/usecases/fetch_user_details_usecase.dart';
import 'package:yt_ecommerce_admin_panel/features/product/data/datasources/product_data_source.dart';
import 'package:yt_ecommerce_admin_panel/features/product/data/repositories/product_repository.dart';
import 'package:yt_ecommerce_admin_panel/features/product/presentation/cubit/product_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // ========== Data Sources ==========
  getIt.registerLazySingleton<BaseAdminAuthDataSource>(
    () => AdminAuthDataSource(),
  );

  getIt.registerLazySingleton<BaseUserDataSource>(
    () => UserDataSource(),
  );

  getIt.registerLazySingleton<MediaDataSource>(
    () => MediaDataSource(),
  );

  // ========== Category ==========
  getIt.registerLazySingleton<CategoryDataSource>(
    () => CategoryDataSource(),
  );
  getIt.registerLazySingleton<CategoryRepository>(
    () => CategoryRepository(dataSource: getIt<CategoryDataSource>()),
  );

  // ========== Banner ==========
  getIt.registerLazySingleton<BannerDataSource>(
    () => BannerDataSource(),
  );
  getIt.registerLazySingleton<BannerRepository>(
    () => BannerRepository(dataSource: getIt<BannerDataSource>()),
  );

  // ========== Brand ==========
  getIt.registerLazySingleton<BrandDataSource>(
    () => BrandDataSource(),
  );
  getIt.registerLazySingleton<BrandRepository>(
    () => BrandRepository(dataSource: getIt<BrandDataSource>()),
  );

  // ========== Product ==========
  getIt.registerLazySingleton<ProductDataSource>(
    () => ProductDataSource(),
  );
  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepository(dataSource: getIt<ProductDataSource>()),
  );

  // ========== Repositories ==========
  getIt.registerLazySingleton<BaseAdminAuthRepository>(
    () => AdminAuthRepository(dataSource: getIt<BaseAdminAuthDataSource>()),
  );

  getIt.registerLazySingleton<BaseUserRepository>(
    () => UserRepository(getIt<BaseUserDataSource>()),
  );

  getIt.registerLazySingleton<BaseMediaRepository>(
    () => MediaRepository(getIt<MediaDataSource>()),
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

  getIt.registerLazySingleton<UploadMediaImagesUseCase>(
    () => UploadMediaImagesUseCase(getIt<BaseMediaRepository>()),
  );

  getIt.registerLazySingleton<FetchMediaImagesUseCase>(
    () => FetchMediaImagesUseCase(getIt<BaseMediaRepository>()),
  );

  getIt.registerLazySingleton<DeleteMediaImageUseCase>(
    () => DeleteMediaImageUseCase(getIt<BaseMediaRepository>()),
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

  getIt.registerFactory<MediaCubit>(
    () => MediaCubit(
      uploadUseCase: getIt<UploadMediaImagesUseCase>(),
      fetchUseCase: getIt<FetchMediaImagesUseCase>(),
      deleteUseCase: getIt<DeleteMediaImageUseCase>(),
    ),
  );

  // ========== Feature Cubits ==========
  getIt.registerFactory<CategoryCubit>(
    () => CategoryCubit(getIt<CategoryRepository>()),
  );

  getIt.registerFactory<BannerCubit>(
    () => BannerCubit(getIt<BannerRepository>()),
  );

  getIt.registerFactory<BrandCubit>(
    () => BrandCubit(getIt<BrandRepository>()),
  );

  getIt.registerFactory<ProductCubit>(
    () => ProductCubit(getIt<ProductRepository>()),
  );
}
