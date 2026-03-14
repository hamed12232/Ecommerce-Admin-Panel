import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yt_ecommerce_admin_panel/features/auth/data/datasources/base_admin_auth_data_source.dart';
import 'package:yt_ecommerce_admin_panel/features/auth/data/models/admin_model.dart';
import 'package:yt_ecommerce_admin_panel/features/auth/domain/repositories/base_admin_auth_repository.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/text_strings.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/exceptions/exceptions.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/exceptions/firebase_exceptions.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/exceptions/platform_exceptions.dart';

/// Concrete implementation of [BaseAdminAuthRepository].
class AdminAuthRepository implements BaseAdminAuthRepository {
  final BaseAdminAuthDataSource dataSource;

  AdminAuthRepository({required this.dataSource});

  @override
  Future<Either<TExceptions, UserCredential>> loginWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final userCredential = await dataSource.loginWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(userCredential);
    } on TFirebaseAuthException catch (e) {
      return Left(TExceptions(e.message));
    } on TFirebaseException catch (e) {
      return Left(TExceptions(e.message));
    } on TPlatformException catch (e) {
      return Left(TExceptions(e.message));
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }

  @override
  Future<Either<TExceptions, UserCredential>> signup(
    String email,
    String password,
  ) async {
    try {
      final userCredential = await dataSource.signup(
        email: email,
        password: password,
      );
      await dataSource.saveUserRecord(
        AdminModel(
          id: userCredential.user!.uid,
          email: email,
          userName: TTexts.adminEmail,
          role: AppRole.admin,
        ),
      );
      return Right(userCredential);
    } on TFirebaseAuthException catch (e) {
      return Left(TExceptions(e.message));
    } on TFirebaseException catch (e) {
      return Left(TExceptions(e.message));
    } on TPlatformException catch (e) {
      return Left(TExceptions(e.message));
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }

  @override
  Future<Either<TExceptions, void>> logout() async {
    try {
      await dataSource.logout();
      return const Right(null);
    } on TFirebaseAuthException catch (e) {
      return Left(TExceptions(e.message));
    } on TFirebaseException catch (e) {
      return Left(TExceptions(e.message));
    } on TPlatformException catch (e) {
      return Left(TExceptions(e.message));
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }

  @override
  Future<Either<TExceptions, void>> sendPasswordResetEmail(
    String email,
  ) async {
    try {
      await dataSource.sendPasswordResetEmail(email);
      return const Right(null);
    } on TFirebaseAuthException catch (e) {
      return Left(TExceptions(e.message));
    } on TFirebaseException catch (e) {
      return Left(TExceptions(e.message));
    } on TPlatformException catch (e) {
      return Left(TExceptions(e.message));
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }

  @override
  Future<Either<TExceptions, AdminModel>> fetchAdminDetails(String uid) async {
    try {
      final snapshot = await dataSource.fetchAdminDetails(uid);
      if (!snapshot.exists) {
        return const Left(
          TExceptions('Admin record not found. Access denied.'),
        );
      }
      final adminModel = AdminModel.fromSnapshot(snapshot);
      return Right(adminModel);
    } on TFirebaseAuthException catch (e) {
      return Left(TExceptions(e.message));
    } on TFirebaseException catch (e) {
      return Left(TExceptions(e.message));
    } on TPlatformException catch (e) {
      return Left(TExceptions(e.message));
    } catch (e) {
      return Left(TExceptions(e.toString()));
    }
  }
}
