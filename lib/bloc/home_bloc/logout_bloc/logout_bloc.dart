import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_pal_guardians/bloc/home_bloc/logout_bloc/logout_event.dart';
import 'package:online_pal_guardians/bloc/home_bloc/logout_bloc/logout_state.dart';
import 'package:online_pal_guardians/repositories/home_repository.dart';
import 'package:online_pal_guardians/utils/session_helper.dart';


class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final HomeRepository homeRepository;

  LogoutBloc({required this.homeRepository}) : super(LogoutInitial()) {
    on<LogoutButtonPressed>(_onLogoutButtonPressed);
    on<LogoutInitialized>(_onLogoutInitialized);
  }

  Future<void> _onLogoutButtonPressed(
      LogoutButtonPressed event, Emitter<LogoutState> emit) async {
    emit(LogoutLoading());
    try {
      final logoutResponse = await homeRepository.logout();
      await SessionHelper().deleteToken();

      emit(LogoutSuccess(logoutResponse: logoutResponse));
    } catch (e) {
      emit(LogoutError(message: e.toString()));
    }
  }

  void _onLogoutInitialized(LogoutInitialized event, Emitter<LogoutState> emit) {
    emit(LogoutInitial());
  }
}
