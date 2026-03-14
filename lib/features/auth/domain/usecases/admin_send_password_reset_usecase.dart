import 'package:dartz/dartz.dart';
import 'package:yt_ecommerce_admin_panel/features/auth/domain/repositories/base_admin_auth_repository.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/exceptions/exceptions.dart';

/// Use case for sending a password reset email.
class AdminSendPasswordResetUseCase {
  final BaseAdminAuthRepository repository;

  AdminSendPasswordResetUseCase(this.repository);

  Future<Either<TExceptions, void>> call(String email) async {
    return await repository.sendPasswordResetEmail(email);
  }
}
