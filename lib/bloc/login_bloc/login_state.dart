import 'package:online_pal_guardians/models/login/login_response.dart';
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginResponse loginResponse;
  LoginSuccess({required this.loginResponse});

  @override
  List<Object> get props => [];
}

class LoginError extends LoginState {
  final String message;
  LoginError({required this.message});

  @override
  List<Object> get props => [];
}
