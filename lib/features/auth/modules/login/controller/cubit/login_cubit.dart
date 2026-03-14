import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yt_ecommerce_admin_panel/features/auth/data/models/admin_model.dart';
import 'package:yt_ecommerce_admin_panel/features/auth/domain/usecases/admin_login_usecase.dart';
import 'package:yt_ecommerce_admin_panel/features/auth/domain/usecases/fetch_admin_role_usecase.dart';
import 'package:yt_ecommerce_admin_panel/utils/helpers/network_manager.dart';
import 'package:yt_ecommerce_admin_panel/utils/local_storage/shared_pref.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
//  final AdminSignupUseCase adminSignupUseCase;
  final AdminLoginUseCase adminLoginUseCase;
  final FetchAdminRoleUseCase fetchAdminRoleUseCase;

  LoginCubit({
    required this.adminLoginUseCase,
    required this.fetchAdminRoleUseCase,
  }) : super(const LoginState()) {
    _loadSavedCredentials();
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void _loadSavedCredentials() {
    if (SharedPrefServices.isRememberMe()) {
      final email = SharedPrefServices.getEmail();
      final password = SharedPrefServices.getPassword();
      emailController.text = email;
      passwordController.text = password;
      emit(
        state.copyWith(isRememberMe: true, email: email, password: password),
      );
    }
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void toggleRememberMe() {
    emit(state.copyWith(isRememberMe: !state.isRememberMe));
  }

  /// Login with email and password, then verify admin role.
  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;
    if (!await NetworkManager().isConnected()) {
      emit(state.copyWith(
          status: LoginStatus.error, error: 'No internet connection'));
      return;
    }

    emit(state.copyWith(status: LoginStatus.loading));

    final loginResult = await adminLoginUseCase.call(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    await loginResult.fold(
      (failure) async {
        emit(
          state.copyWith(status: LoginStatus.error, error: failure.message),
        );
      },
      (userCredential) async {
        final uid = userCredential.user!.uid;
        final roleResult = await fetchAdminRoleUseCase.call(uid);

        await roleResult.fold(
          (failure) async {
          },
          (adminModel) async {
            if (adminModel.role != AppRole.admin) {
              await FirebaseAuth.instance.signOut();
              emit(
                state.copyWith(
                  status: LoginStatus.error,
                  error: 'Access denied. Admin privileges required.',
                ),
              );
            } else {
              if (state.isRememberMe) {
                SharedPrefServices.saveRemeberMe(
                  emailController.text.trim(),
                  passwordController.text.trim(),
                );
              } else {
                SharedPrefServices.removeRememberMe();
              }
              emit(state.copyWith(status: LoginStatus.success));
            }
          },
        );
      },
    );
  }

  /// Signup for admin account (One-time only).
  // Future<void> signup() async {
  //   if (!formKey.currentState!.validate()) return;
  //   if (!await NetworkManager().isConnected()) {
  //     emit(state.copyWith(
  //         status: LoginStatus.error, error: 'No internet connection'));
  //     return;
  //   }

  //   emit(state.copyWith(status: LoginStatus.loading));

  //   final signupResult = await adminSignupUseCase.call(
  //     emailController.text.trim(),
  //     passwordController.text.trim(),
  //   );

  //   signupResult.fold(
  //     (failure) {
  //       emit(
  //         state.copyWith(status: LoginStatus.error, error: failure.message),
  //       );
  //     },
  //     (userCredential) {
  //       emit(state.copyWith(status: LoginStatus.success));
  //     },
  //   );
  // }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
