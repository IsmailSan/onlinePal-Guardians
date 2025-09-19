part of 'home_bloc.dart';

@immutable
abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class HomeEventInitialized extends HomeEvent {
  const HomeEventInitialized();

  @override
  List<Object> get props => [];
}


class GetHome extends HomeEvent {

  const GetHome();

  @override
  List<Object?> get props => [];
}


