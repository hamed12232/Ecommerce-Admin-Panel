part of 'login_cubit.dart';

enum LoginStatus { initial, loading, success, error }

class LoginState {
  final LoginStatus status;
  final String error;
  final bool isPasswordVisible;
  final bool isRememberMe;
  final String email;
  final String password;

  const LoginState({
    this.status = LoginStatus.initial,
    this.error = '',
    this.isPasswordVisible = false,
    this.isRememberMe = false,
      this.email = '',
    this.password = '',
  });

  LoginState copyWith({
    LoginStatus? status,
    String? error,
    bool? isPasswordVisible,
    bool? isRememberMe,
      String? email,
    String? password,
  }) {
    return LoginState(
      status: status ?? this.status,
      error: error ?? this.error,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isRememberMe: isRememberMe ?? this.isRememberMe,
        email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
