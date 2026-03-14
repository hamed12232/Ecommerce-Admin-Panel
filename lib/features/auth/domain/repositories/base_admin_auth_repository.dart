import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yt_ecommerce_admin_panel/features/auth/data/models/admin_model.dart';
import 'package:yt_ecommerce_admin_panel/utils/exceptions/exceptions.dart';

/// Abstract repository defining the contract for admin auth operations.
/// Returns [Either] types for functional error handling.
abstract class BaseAdminAuthRepository {
  Future<Either<TExceptions, UserCredential>> loginWithEmailAndPassword(
    String email,
    String password,
  );

  Future<Either<TExceptions, UserCredential>> signup(
    String email,
    String password,
  );

  Future<Either<TExceptions, void>> logout();

  Future<Either<TExceptions, void>> sendPasswordResetEmail(String email);

  Future<Either<TExceptions, AdminModel>> fetchAdminDetails(String uid);
}
