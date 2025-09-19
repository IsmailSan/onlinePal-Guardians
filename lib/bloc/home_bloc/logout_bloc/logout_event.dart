import 'package:equatable/equatable.dart';

abstract class LogoutEvent extends Equatable {
  const LogoutEvent();
}

class LogoutInitialized extends LogoutEvent {
  @override
  List<Object> get props => [];
}


class LogoutButtonPressed extends LogoutEvent {
  const LogoutButtonPressed();
  @override
  List<Object> get props => [];
}


