import 'package:equatable/equatable.dart';
import 'package:online_pal_guardians/models/logout/logout_response.dart';

abstract class LogoutState extends Equatable {
  @override
  List<Object> get props => [];
}

class LogoutInitial extends LogoutState {}

class LogoutLoading extends LogoutState {}

class LogoutSuccess extends LogoutState {
  final LogoutResponse logoutResponse;
  LogoutSuccess({required this.logoutResponse});

  @override
  List<Object> get props => [];
}

class LogoutError extends LogoutState {
  final String message;
  LogoutError({required this.message});

  @override
  List<Object> get props => [];
}
