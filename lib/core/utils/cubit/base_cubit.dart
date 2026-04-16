import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/cubit/base_state.dart';

/// Base Cubit for states that contain data
abstract class BaseCubit<T> extends Cubit<ApiState<T>> {
  BaseCubit() : super(ApiState<T>());

  void emitLoading() {
    emit(state.copyWith(status: ApiStatus.loading));
  }

  void emitSuccess(T data) {
    emit(state.copyWith(
      status: ApiStatus.success,
      data: data,
      error: null,
    ));
  }

  void emitError(String message) {
    emit(state.copyWith(
      status: ApiStatus.error,
      error: message,
    ));
  }

  void emitInitial() {
    emit(state.copyWith(
      status: ApiStatus.initial,
      data: null,
      error: null,
    ));
  }
}

/// Base Cubit for states WITHOUT data (only status)
class BaseStateCubit extends Cubit<ApiState<void>> {
  BaseStateCubit() : super(const ApiState<void>());

  void emitLoading() {
    emit(const ApiState<void>(status: ApiStatus.loading));
  }

  void emitSuccess() {
    emit(const ApiState<void>(status: ApiStatus.success));
  }

  void emitError(String message) {
    emit(ApiState<void>(
      status: ApiStatus.error,
      error: message,
    ));
  }

  void emitInitial() {
    emit(const ApiState<void>(status: ApiStatus.initial));
  }
}
