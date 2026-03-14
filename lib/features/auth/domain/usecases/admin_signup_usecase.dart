import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yt_ecommerce_admin_panel/features/auth/domain/repositories/base_admin_auth_repository.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/exceptions/exceptions.dart';

class AdminSignupUseCase {
  final BaseAdminAuthRepository repository;

  AdminSignupUseCase({required this.repository});

  Future<Either<TExceptions, UserCredential>> call(String email, String password) async {
    return await repository.signup(email, password);
  }
}
