import 'package:equatable/equatable.dart';
import 'package:online_pal_guardians/models/avatar/avatar_list_response.dart';
import 'package:online_pal_guardians/models/profile/child_profile/child_preference_response.dart';
import 'package:online_pal_guardians/models/profile/child_profile/create_child_profile_response.dart';
import 'package:online_pal_guardians/models/profile/child_profile/get_child_profile_response.dart';
import 'package:online_pal_guardians/models/profile/child_profile/get_children_profile_response.dart';
import 'package:online_pal_guardians/models/profile/child_profile/update_child_avatar_response.dart';
import 'package:online_pal_guardians/models/profile/child_profile/update_child_profile_response.dart';

abstract class ChildProfileState extends Equatable {
  @override
  List<Object> get props => [];
}

class ChildProfileInitial extends ChildProfileState {}

class ChildProfileLoading extends ChildProfileState {}

class GetChildProfileSuccess extends ChildProfileState {
  final GetChildProfileResponse response;

  GetChildProfileSuccess({required this.response});

  @override
  List<Object> get props => [response];
}

class GetChildrenProfileSuccess extends ChildProfileState {
  final GetChildrenProfileResponse response;

  GetChildrenProfileSuccess({required this.response});

  @override
  List<Object> get props => [response];
}

class CreateChildProfileSuccess extends ChildProfileState {
  final CreateChildProfileResponse response;

  CreateChildProfileSuccess({required this.response});

  @override
  List<Object> get props => [response];
}

class UpdateChildProfileSuccess extends ChildProfileState {
  final UpdateChildProfileResponse response;

  UpdateChildProfileSuccess({required this.response});

  @override
  List<Object> get props => [response];
}

class AddChildPreferenceSuccess extends ChildProfileState {
  final ChildPreferenceResponse response;

  AddChildPreferenceSuccess({required this.response});

  @override
  List<Object> get props => [response];
}

class ChildAvatarUpdateSuccess extends ChildProfileState {
  final UpdateChildAvatarResponse response;

  ChildAvatarUpdateSuccess({required this.response});

  @override
  List<Object> get props => [response];
}

class ChildAvatarListSuccess extends ChildProfileState {
  final AvatarListResponse response;

  ChildAvatarListSuccess({required this.response});

  @override
  List<Object> get props => [response];
}

class ChildAvatarError extends ChildProfileState {
  final String message;

  ChildAvatarError({required this.message});

  @override
  List<Object> get props => [message];
}

class ChildProfileError extends ChildProfileState {
  final String message;

  ChildProfileError({required this.message});

  @override
  List<Object> get props => [message];
}

class GetChildProfileError extends ChildProfileState {
  final String message;

  GetChildProfileError({required this.message});

  @override
  List<Object> get props => [message];
}

class GetChildrenProfileError extends ChildProfileState {
  final String message;

  GetChildrenProfileError({required this.message});

  @override
  List<Object> get props => [message];
}

class AddChildrenProfileError extends ChildProfileState {
  final String message;

  AddChildrenProfileError({required this.message});

  @override
  List<Object> get props => [message];
}
