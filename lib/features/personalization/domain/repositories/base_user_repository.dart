import 'package:dartz/dartz.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/exceptions/exceptions.dart';
import 'package:yt_ecommerce_admin_panel/features/auth/data/models/admin_model.dart';

abstract class BaseUserRepository {
  /// Fetches the details of a user (admin) by their unique identifier [uid].
  Future<Either<TExceptions, AdminModel>> fetchUserDetails(String uid);
}
