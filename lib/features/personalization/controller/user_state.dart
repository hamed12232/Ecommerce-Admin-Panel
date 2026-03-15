import 'package:yt_ecommerce_admin_panel/features/auth/data/models/admin_model.dart';

enum UserStatus { initial, loading, success, error }

class UserState {
  final UserStatus status;
  final String error;
  final AdminModel? user;

  const UserState({
    this.status = UserStatus.initial,
    this.error = '',
    this.user,
  });

  UserState copyWith({
    UserStatus? status,
    String? error,
    AdminModel? user,
  }) {
    return UserState(
      status: status ?? this.status,
      error: error ?? this.error,
      user: user ?? this.user,
    );
  }
}
