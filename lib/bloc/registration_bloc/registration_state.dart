import 'package:equatable/equatable.dart';
import 'package:online_pal_guardians/models/registration/registration_response.dart';

abstract class RegistrationState extends Equatable {
  @override
  List<Object> get props => [];
}

class RegistrationInitial extends RegistrationState {}

class RegistrationLoading extends RegistrationState {}

class RegistrationSuccess extends RegistrationState {
  final RegistrationResponse registrationResponse;
  RegistrationSuccess({required this.registrationResponse});

  @override
  List<Object> get props => [];
}

class RegistrationError extends RegistrationState {
  final String message;
  RegistrationError({required this.message});

  @override
  List<Object> get props => [];
}
