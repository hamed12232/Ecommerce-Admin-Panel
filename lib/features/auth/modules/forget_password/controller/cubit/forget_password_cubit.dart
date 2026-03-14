import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yt_ecommerce_admin_panel/features/auth/domain/usecases/admin_send_password_reset_usecase.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  final AdminSendPasswordResetUseCase sendPasswordResetUseCase;

  ForgetPasswordCubit({required this.sendPasswordResetUseCase})
      : super(const ForgetPasswordState());

  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> sendPasswordResetEmail() async {
    if (!formKey.currentState!.validate()) return;

    emit(state.copyWith(status: ForgetPasswordStatus.loading));

    final result = await sendPasswordResetUseCase.call(
      emailController.text.trim(),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: ForgetPasswordStatus.error,
          error: failure.message,
        ),
      ),
      (_) => emit(state.copyWith(status: ForgetPasswordStatus.success)),
    );
  }

  @override
  Future<void> close() {
    emailController.dispose();
    return super.close();
  }
}
