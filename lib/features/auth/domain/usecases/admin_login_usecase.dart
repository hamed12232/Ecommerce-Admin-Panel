import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yt_ecommerce_admin_panel/features/auth/domain/repositories/base_admin_auth_repository.dart';
import 'package:yt_ecommerce_admin_panel/utils/exceptions/exceptions.dart';

/// Use case for admin login with email and password.
class AdminLoginUseCase {
  final BaseAdminAuthRepository repository;

  AdminLoginUseCase(this.repository);

  Future<Either<TExceptions, UserCredential>> call(
    String email,
    String password,
  ) async {
    return await repository.loginWithEmailAndPassword(email, password);
  }
}
