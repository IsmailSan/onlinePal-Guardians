import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_pal_guardians/bloc/login_bloc/login_event.dart';
import 'package:online_pal_guardians/bloc/login_bloc/login_state.dart';
import 'package:online_pal_guardians/repositories/login_repository.dart';
import 'package:online_pal_guardians/utils/session_helper.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;

  LoginBloc({required this.loginRepository}) : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<LoginInitialized>(_onLoginInitialized);
  }

  Future<void> _onLoginButtonPressed(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      final loginResponse = await loginRepository.login(event.username, event.password, event.role);
      await SessionHelper().saveToken(loginResponse.data.token ?? "");

      emit(LoginSuccess(loginResponse: loginResponse));
    } catch (e) {
      emit(LoginError(message: e.toString()));
    }
  }

  void _onLoginInitialized(LoginInitialized event, Emitter<LoginState> emit) {
    emit(LoginInitial());
  }
}
