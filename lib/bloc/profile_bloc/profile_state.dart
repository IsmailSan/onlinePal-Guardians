import 'package:equatable/equatable.dart';
import 'package:online_pal_guardians/models/profile/get_profile_response.dart';
import 'package:online_pal_guardians/models/profile/update_profile_response.dart';

abstract class ProfileState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class UpdateProfileSuccess extends ProfileState {
  final UpdateProfileResponse profileResponse;

  UpdateProfileSuccess({required this.profileResponse});

  @override
  List<Object> get props => [profileResponse];
}

class GetProfileSuccess extends ProfileState {
  final GetProfileResponse getProfileResponse;

  GetProfileSuccess({required this.getProfileResponse});

  @override
  List<Object> get props => [getProfileResponse];
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError({required this.message});

  @override
  List<Object> get props => [message];
}

class GetProfileError extends ProfileState {
  final String message;

  GetProfileError({required this.message});

  @override
  List<Object> get props => [message];
}
