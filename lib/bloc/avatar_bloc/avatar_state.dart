import 'package:equatable/equatable.dart';
import 'package:online_pal_guardians/models/avatar/avatar_list_response.dart';
import 'package:online_pal_guardians/models/avatar/update_avatar_response.dart';

abstract class AvatarState extends Equatable {
  @override
  List<Object> get props => [];
}

class AvatarInitial extends AvatarState {}

class AvatarLoading extends AvatarState {}

class AvatarUpdateSuccess extends AvatarState {
  final UpdateAvatarResponse response;

  AvatarUpdateSuccess({required this.response});

  @override
  List<Object> get props => [response];
}

class AvatarListSuccess extends AvatarState {
  final AvatarListResponse response;

  AvatarListSuccess({required this.response});

  @override
  List<Object> get props => [response];
}

class AvatarError extends AvatarState {
  final String message;

  AvatarError({required this.message});

  @override
  List<Object> get props => [message];
}
