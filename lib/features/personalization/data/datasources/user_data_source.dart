import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/exceptions/firebase_exceptions.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/exceptions/platform_exceptions.dart';
import 'package:yt_ecommerce_admin_panel/features/auth/data/models/admin_model.dart';
import 'package:yt_ecommerce_admin_panel/features/personalization/data/datasources/base_user_data_source.dart';

class UserDataSource implements BaseUserDataSource {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future<AdminModel> fetchUserDetails(String uid) async {
    try {
      final documentSnapshot = await _db.collection('users').doc(uid).get();
      if (documentSnapshot.exists) {
        return AdminModel.fromSnapshot(documentSnapshot);
      } else {
        return AdminModel.empty();
      }
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
