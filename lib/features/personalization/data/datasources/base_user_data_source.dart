import 'package:yt_ecommerce_admin_panel/features/auth/data/models/admin_model.dart';

abstract class BaseUserDataSource {
  /// Fetches the details of an admin user by their [uid].
  Future<AdminModel> fetchUserDetails(String uid);
}
