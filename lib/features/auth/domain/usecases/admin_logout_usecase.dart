import 'package:dartz/dartz.dart';
import 'package:yt_ecommerce_admin_panel/features/auth/domain/repositories/base_admin_auth_repository.dart';
import 'package:yt_ecommerce_admin_panel/utils/exceptions/exceptions.dart';

/// Use case for admin logout.
class AdminLogoutUseCase {
  final BaseAdminAuthRepository repository;

  AdminLogoutUseCase(this.repository);

  Future<Either<TExceptions, void>> call() async {
    return await repository.logout();
  }
}
