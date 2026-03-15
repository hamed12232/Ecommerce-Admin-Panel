import 'package:dartz/dartz.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/exceptions/exceptions.dart';
import 'package:yt_ecommerce_admin_panel/features/auth/data/models/admin_model.dart';
import 'package:yt_ecommerce_admin_panel/features/personalization/data/datasources/base_user_data_source.dart';
import 'package:yt_ecommerce_admin_panel/features/personalization/domain/repositories/base_user_repository.dart';

class UserRepository implements BaseUserRepository {
  final BaseUserDataSource dataSource;

  UserRepository(this.dataSource);

  @override
  Future<Either<TExceptions, AdminModel>> fetchUserDetails(String uid) async {
    try {
      final user = await dataSource.fetchUserDetails(uid);
      return Right(user);
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }
}
