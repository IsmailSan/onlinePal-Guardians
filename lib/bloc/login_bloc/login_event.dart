import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginInitialized extends LoginEvent {
  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  final String username;
  final String password;
  final String role;
  const LoginButtonPressed({required this.username, required this.password, required this.role});
  @override
  List<Object> get props => [];
}


