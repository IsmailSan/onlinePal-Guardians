import 'package:equatable/equatable.dart';
import 'package:online_pal_guardians/models/mission/create_mission_from_suggestion_response.dart';
import 'package:online_pal_guardians/models/mission/create_new_mission_response.dart';
import 'package:online_pal_guardians/models/mission/delete_mission_response.dart';
import 'package:online_pal_guardians/models/mission/mission_list_response.dart';
import 'package:online_pal_guardians/models/mission/suggested_mission_list_response.dart';
import 'package:online_pal_guardians/models/mission/update_mission_response.dart';
import 'package:online_pal_guardians/models/mission/app_list_response.dart';
import 'package:online_pal_guardians/models/mission/app_category_list_response.dart';

abstract class MissionState extends Equatable {
  const MissionState();

  @override
  List<Object?> get props => [];
}

class MissionInitial extends MissionState {}

class MissionLoading extends MissionState {}

class ActiveMissionLoading extends MissionState {}

class WaitingMissionLoading extends MissionState {}

class MissionHistoryLoading extends MissionState {}

class DeleteMissionLoading extends MissionState {}

class CreateMissionLoading extends MissionState {}

class SuggestedMissionSuccess extends MissionState {
  final SuggestedMissionListResponse response;

  const SuggestedMissionSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class AppListSuccess extends MissionState {
  final AppListResponse response;

  const AppListSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class AppCategoryListSuccess extends MissionState {
  final AppCategoryListResponse response;

  const AppCategoryListSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class MissionListSuccess extends MissionState {
  final Map<String, MissionListResponse> missionsByStatus;

  const MissionListSuccess(this.missionsByStatus);

  @override
  List<Object?> get props => [missionsByStatus];
}

class MissionHistoryListSuccess extends MissionState {
  final MissionListResponse response;

  const MissionHistoryListSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class CreateMissionFromSuggestionSuccess extends MissionState {
  final CreateMissionFromSuggestionResponse response;

  const CreateMissionFromSuggestionSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class CreateAllMissionFromSuggestionSuccess extends MissionState {
  final CreateMissionFromSuggestionResponse response;

  const CreateAllMissionFromSuggestionSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class CreateNewMissionSuccess extends MissionState {
  final CreateNewMissionResponse response;

  const CreateNewMissionSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class DeleteMissionSuccess extends MissionState {
  final DeleteMissionResponse response;

  const DeleteMissionSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class UpdateMissionSuccess extends MissionState {
  final UpdateMissionResponse response;

  const UpdateMissionSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class MissionError extends MissionState {
  final String message;

  const MissionError(this.message);

  @override
  List<Object?> get props => [message];
}

class CreateMissionError extends MissionState {
  final String message;

  const CreateMissionError(this.message);

  @override
  List<Object?> get props => [message];
}
