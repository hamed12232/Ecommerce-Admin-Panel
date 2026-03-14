part of 'forget_password_cubit.dart';

enum ForgetPasswordStatus { initial, loading, success, error }

class ForgetPasswordState {
  final ForgetPasswordStatus status;
  final String error;

  const ForgetPasswordState({
    this.status = ForgetPasswordStatus.initial,
    this.error = '',
  });

  ForgetPasswordState copyWith({
    ForgetPasswordStatus? status,
    String? error,
  }) {
    return ForgetPasswordState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
