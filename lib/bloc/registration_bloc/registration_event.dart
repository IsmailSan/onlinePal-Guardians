import 'package:equatable/equatable.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();
}

class RegistrationInitialized extends RegistrationEvent {
  @override
  List<Object> get props => [];
}

class RegistrationButtonPressed extends RegistrationEvent {
  final String userName;
  final String password;
  final String passwordConfirmation;
  const RegistrationButtonPressed({required this.userName, required this.password, required this.passwordConfirmation});
  @override
  List<Object> get props => [];
}


