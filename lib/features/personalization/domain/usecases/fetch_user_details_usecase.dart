import 'package:dartz/dartz.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/exceptions/exceptions.dart';
import 'package:yt_ecommerce_admin_panel/features/auth/data/models/admin_model.dart';
import 'package:yt_ecommerce_admin_panel/features/personalization/domain/repositories/base_user_repository.dart';

class FetchUserDetailsUseCase {
  final BaseUserRepository repository;

  FetchUserDetailsUseCase(this.repository);

  Future<Either<TExceptions, AdminModel>> call(String uid) {
    return repository.fetchUserDetails(uid);
  }
}
