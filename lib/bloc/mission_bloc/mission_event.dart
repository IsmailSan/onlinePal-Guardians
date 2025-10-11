import 'package:equatable/equatable.dart';

abstract class MissionEvent extends Equatable {
  const MissionEvent();
}

class MissionInitialized extends MissionEvent {
  @override
  List<Object> get props => [];
}

class GetSuggestedMissions extends MissionEvent {
  final int limit;
  final int cursor;
  final bool isRefresh;

  const GetSuggestedMissions({
    this.limit = 10,
    this.cursor = 0,
    this.isRefresh = false,
  });

  @override
  List<Object?> get props => [limit, cursor];
}

class GetAppList extends MissionEvent {
  final int limit;
  final int cursor;
  final int appCategoryId;
  final bool isRefresh;

  const GetAppList({
    this.limit = 100,
    this.cursor = 0,
    this.appCategoryId = 0,
    this.isRefresh = false,
  });

  @override
  List<Object?> get props => [limit, cursor, appCategoryId];
}

class GetAppCategoryList extends MissionEvent {
  final int limit;
  final int cursor;
  final bool isRefresh;

  const GetAppCategoryList({
    this.limit = 100,
    this.cursor = 0,
    this.isRefresh = false,
  });

  @override
  List<Object?> get props => [limit, cursor];
}

class GetMissions extends MissionEvent {
  final int childrenId;
  final String status;
  final int limit;
  final String? cursor;
  final bool isRefresh;

  GetMissions({
    required this.childrenId,
    required this.status,
    this.limit = 10,
    this.cursor,
    this.isRefresh = false,
  });

  @override
  List<Object?> get props => [childrenId, status, limit, cursor, isRefresh];
}

class GetMissionsHistory extends MissionEvent {
  final int childrenId;
  final int limit;
  final String? cursor;
  final bool isRefresh;

  GetMissionsHistory({
    required this.childrenId,
    this.limit = 10,
    this.cursor,
    this.isRefresh = false,
  });

  @override
  List<Object?> get props => [childrenId, limit, cursor, isRefresh];
}

class CreateMissionFromSuggestion extends MissionEvent {
  final int missionSuggestionId;
  final int childrenId;

  const CreateMissionFromSuggestion(
      {required this.missionSuggestionId, required this.childrenId});
  @override
  List<Object> get props => [];
}

class CreateAllMissionFromSuggestion extends MissionEvent {
  final String type;
  final int childrenId;

  const CreateAllMissionFromSuggestion(
      {required this.type, required this.childrenId});
  @override
  List<Object> get props => [];
}

class CreateNewMission extends MissionEvent {
  final int childrenId;
  final String name;
  final String description;
  final int reward;
  final int punishment;
  final String periodeTime;
  final String startDate;
  final String endDate;
  final String type;
  final String condition;
  final int categoryAppsId;
  final int appsId;
  final String? directReward;
  final String? directPunishment;
  final int? pointAddition;
  final int? pointDeduction;

  const CreateNewMission({
    required this.childrenId,
    required this.name,
    required this.description,
    required this.reward,
    required this.punishment,
    required this.periodeTime,
    required this.startDate,
    required this.endDate,
    required this.type,
    required this.condition,
    required this.categoryAppsId,
    required this.appsId,
    this.directReward,
    this.directPunishment,
    this.pointAddition,
    this.pointDeduction,
  });

  @override
  List<Object?> get props => [
        childrenId,
        name,
        description,
        reward,
        punishment,
        periodeTime,
        startDate,
        endDate,
        type,
        condition,
        categoryAppsId,
        appsId,
        directReward,
        directPunishment,
        pointAddition,
        pointDeduction,
      ];
}

class DeleteMission extends MissionEvent {
  final int missionId;

  const DeleteMission({required this.missionId});
  @override
  List<Object> get props => [];
}

class UpdateMission extends MissionEvent {
  final int missionId;
  final int childrenId;
  final String name;
  final String description;
  final int reward;
  final int punishment;
  final String periodeTime;
  final String startDate;
  final String endDate;
  final String type;
  final String condition;
  final String appCategory;
  final String appName;
  final String? directReward;
  final String? directPunishment;
  final int? pointAddition;
  final int? pointDeduction;

  const UpdateMission({
    required this.missionId,
    required this.childrenId,
    required this.name,
    required this.description,
    required this.reward,
    required this.punishment,
    required this.periodeTime,
    required this.startDate,
    required this.endDate,
    required this.type,
    required this.condition,
    required this.appCategory,
    required this.appName,
    this.directReward,
    this.directPunishment,
    this.pointAddition,
    this.pointDeduction,
  });

  @override
  List<Object?> get props => [
        missionId,
        childrenId,
        name,
        description,
        reward,
        punishment,
        periodeTime,
        startDate,
        endDate,
        type,
        condition,
        appCategory,
        appName,
        directReward,
        directPunishment,
        pointAddition,
        pointDeduction,
      ];
}

class LoadAllMissions extends MissionEvent {
  final int childrenId;
  final int limit;

  LoadAllMissions({required this.childrenId, this.limit = 10});

  @override
  List<Object> get props => [childrenId, limit];
}
