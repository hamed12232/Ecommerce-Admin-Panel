import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yt_ecommerce_admin_panel/features/auth/data/models/admin_model.dart';

/// Abstract data source for admin authentication operations.
abstract class BaseAdminAuthDataSource {
  Future<UserCredential> loginWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<UserCredential> signup({
    required String email,
    required String password,
  });
  Future<void> saveUserRecord(AdminModel adminModel);

  Future<void> logout();

  Future<void> sendPasswordResetEmail(String email);

  Future<DocumentSnapshot<Map<String, dynamic>>> fetchAdminDetails(String uid);
}
