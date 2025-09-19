import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_pal_guardians/bloc/registration_bloc/registration_event.dart';
import 'package:online_pal_guardians/bloc/registration_bloc/registration_state.dart';
import 'package:online_pal_guardians/repositories/registration_repository.dart';
import 'package:online_pal_guardians/utils/session_helper.dart';


class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final RegistrationRepository registrationRepository;

  RegistrationBloc({required this.registrationRepository}) : super(RegistrationInitial()) {
    on<RegistrationButtonPressed>(_onRegistrationButtonPressed);
    on<RegistrationInitialized>(_onRegistrationInitialized);
  }

  Future<void> _onRegistrationButtonPressed(
      RegistrationButtonPressed event, Emitter<RegistrationState> emit) async {
    emit(RegistrationLoading());
    try {
      final registrationResponse = await registrationRepository.register(event.userName, event.password, event.passwordConfirmation);
      await SessionHelper().saveToken(registrationResponse.token ?? "");

      emit(RegistrationSuccess(registrationResponse: registrationResponse));
    } catch (e) {
      emit(RegistrationError(message: e.toString()));
    }
  }

  void _onRegistrationInitialized(RegistrationInitialized event, Emitter<RegistrationState> emit) {
    emit(RegistrationInitial());
  }
}
