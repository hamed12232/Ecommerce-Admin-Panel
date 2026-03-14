import 'package:dartz/dartz.dart';
import 'package:yt_ecommerce_admin_panel/features/auth/data/models/admin_model.dart';
import 'package:yt_ecommerce_admin_panel/features/auth/domain/repositories/base_admin_auth_repository.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/exceptions/exceptions.dart';

/// Use case for fetching admin details from Firestore to verify role.
class FetchAdminRoleUseCase {
  final BaseAdminAuthRepository repository;

  FetchAdminRoleUseCase(this.repository);

  Future<Either<TExceptions, AdminModel>> call(String uid) async {
    return await repository.fetchAdminDetails(uid);
  }
}
