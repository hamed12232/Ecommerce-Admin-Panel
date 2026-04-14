import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/cubit/base_state.dart';

abstract class BaseCubit<T extends Cubit<S>, S extends ApiState>
    extends Cubit<S> {
  BaseCubit(super.initialState);

  void emitLoading() => emit(state.copyWith(status: ApiStatus.loading) as S);

  void emitSuccess(T data) => emit(state.copyWith(
        status: ApiStatus.success,
        data: data,
      ) as S);

  void emitError(String message) => emit(state.copyWith(
        status: ApiStatus.error,
        error: message,
      ) as S);

  void emitInitial() => emit(state.copyWith(status: ApiStatus.initial) as S);
}

class BaseStateCubit extends Cubit<ApiState<void>> {
  BaseStateCubit() : super(const ApiState());

  void emitLoading() => emit(const ApiState(status: ApiStatus.loading));

  void emitSuccess() => emit(const ApiState(status: ApiStatus.success));

  void emitError(String message) => emit(ApiState(
        status: ApiStatus.error,
        error: message,
      ));

  void emitInitial() => emit(const ApiState(status: ApiStatus.initial));
}
