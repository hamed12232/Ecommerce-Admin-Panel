import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yt_ecommerce_admin_panel/features/personalization/controller/user_state.dart';
import 'package:yt_ecommerce_admin_panel/features/personalization/domain/usecases/fetch_user_details_usecase.dart';

class UserCubit extends Cubit<UserState> {
  final FetchUserDetailsUseCase _fetchUserDetailsUseCase;

  UserCubit(this._fetchUserDetailsUseCase) : super(const UserState()) {
    fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    try {
      emit(state.copyWith(status: UserStatus.loading));
      
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        emit(state.copyWith(
          status: UserStatus.error,
          error: 'No authenticated user found.',
        ));
        return;
      }

      final result = await _fetchUserDetailsUseCase(currentUser.uid);

      result.fold(
        (failure) {
          emit(state.copyWith(
            status: UserStatus.error,
            error: failure.message,
          ));
        },
        (user) {
          emit(state.copyWith(
            status: UserStatus.success,
            user: user,
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        status: UserStatus.error,
        error: e.toString(),
      ));
    }
  }
}
