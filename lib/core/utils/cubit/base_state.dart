enum ApiStatus { initial, loading, success, error }

class ApiState<T> {
  final ApiStatus status;
  final T? data;
  final String? error;

  const ApiState({
    this.status = ApiStatus.initial,
    this.data,
    this.error,
  });

  bool get isInitial => status == ApiStatus.initial;
  bool get isLoading => status == ApiStatus.loading;
  bool get isSuccess => status == ApiStatus.success;
  bool get isError => status == ApiStatus.error;

  ApiState<T> copyWith({
    ApiStatus? status,
    T? data,
    String? error,
  }) {
    return ApiState<T>(
      status: status ?? this.status,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }
}

class LoadingState extends ApiState<void> {
  const LoadingState() : super(status: ApiStatus.loading);
}

class SuccessState<T> extends ApiState<T> {
  const SuccessState(T data) : super(status: ApiStatus.success, data: data);
}

class ErrorState extends ApiState<void> {
  const ErrorState(String message)
      : super(status: ApiStatus.error, error: message);
}
