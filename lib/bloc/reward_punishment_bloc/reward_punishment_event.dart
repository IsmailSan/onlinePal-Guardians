part of 'reward_punishment_bloc.dart';

@immutable
abstract class RewardPunishmentEvent extends Equatable {
  const RewardPunishmentEvent();
}

// Event untuk inisialisasi
class RewardPunishmentInitialized extends RewardPunishmentEvent {
  const RewardPunishmentInitialized();

  @override
  List<Object> get props => [];
}

class CreateReward extends RewardPunishmentEvent {
  final int? missionId;
  final int? pointsNeeded;
  final String? frequencyCount;
  final String? condition;
  final int childrenId;
  final String type;
  final String name;
  final String description;
  final String periodStartDate;
  final String periodEndDate;

  const CreateReward({
    this.missionId,
    this.pointsNeeded,
    this.frequencyCount,
    this.condition,
    required this.childrenId,
    required this.type,
    required this.name,
    required this.description,
    required this.periodStartDate,
    required this.periodEndDate,
  });

  @override
  List<Object?> get props => [
    missionId,
    pointsNeeded,
    frequencyCount,
    condition,
    childrenId,
    type,
    name,
    description,
    periodStartDate,
    periodEndDate,
  ];
}

class UpdateReward extends RewardPunishmentEvent {
  final int rewardId;
  final int? missionId;
  final int? pointsNeeded;
  final String? frequencyCount;
  final String? condition;
  final int childrenId;
  final String type;
  final String name;
  final String description;
  final String periodStartDate;
  final String periodEndDate;

  const UpdateReward({
    required this.rewardId,
    this.missionId,
    this.pointsNeeded,
    this.frequencyCount,
    this.condition,
    required this.childrenId,
    required this.type,
    required this.name,
    required this.description,
    required this.periodStartDate,
    required this.periodEndDate,
  });

  @override
  List<Object?> get props => [
    rewardId,
    missionId,
    pointsNeeded,
    frequencyCount,
    condition,
    childrenId,
    type,
    name,
    description,
    periodStartDate,
    periodEndDate,
  ];
}

class DeleteReward extends RewardPunishmentEvent {
  final int rewardId;

  const DeleteReward({
    required this.rewardId,
  });

  @override
  List<Object?> get props => [
    rewardId,
  ];
}

class ConfirmReward extends RewardPunishmentEvent {
  final int rewardId;

  const ConfirmReward({
    required this.rewardId,
  });

  @override
  List<Object?> get props => [
    rewardId,
  ];
}

class UpdateRewardStatus extends RewardPunishmentEvent {
  final int rewardId;

  const UpdateRewardStatus({
    required this.rewardId,
  });

  @override
  List<Object?> get props => [
    rewardId,
  ];
}

class UpdatePunishmentStatus extends RewardPunishmentEvent {
  final int rewardId;

  const UpdatePunishmentStatus({
    required this.rewardId,
  });

  @override
  List<Object?> get props => [
    rewardId,
  ];
}


class CreatePunishment extends RewardPunishmentEvent {
  final int missionId;
  final int childrenId;
  final String name;
  final String? description;
  final String? pointReduction;
  final String periodStartDate;
  final String periodEndDate;
  final String condition;
  final String? frequencyCount;

  const CreatePunishment({
    required this.missionId,
    required this.childrenId,
    required this.name,
    this.description,
    this.pointReduction,
    required this.periodStartDate,
    required this.periodEndDate,
    required this.condition,
    this.frequencyCount,
  });

  @override
  List<Object?> get props => [
    missionId,
    childrenId,
    name,
    description,
    pointReduction,
    periodStartDate,
    periodEndDate,
    condition,
    frequencyCount,
  ];
}

class UpdatePunishment extends RewardPunishmentEvent {
  final int punishmentId;
  final int missionId;
  final int childrenId;
  final String name;
  final String? description;
  final String? pointReduction;
  final String periodStartDate;
  final String periodEndDate;
  final String condition;
  final String? frequencyCount;

  const UpdatePunishment({
    required this.punishmentId,
    required this.missionId,
    required this.childrenId,
    required this.name,
    this.description,
    this.pointReduction,
    required this.periodStartDate,
    required this.periodEndDate,
    required this.condition,
    this.frequencyCount,
  });

  @override
  List<Object?> get props => [
    punishmentId,
    missionId,
    childrenId,
    name,
    description,
    pointReduction,
    periodStartDate,
    periodEndDate,
    condition,
    frequencyCount,
  ];
}

class DeletePunishment extends RewardPunishmentEvent {
  final int punishmentId;

  const DeletePunishment({
    required this.punishmentId,
  });

  @override
  List<Object?> get props => [
    punishmentId,
  ];
}

class ConfirmPunishment extends RewardPunishmentEvent {
  final int punishmentId;

  const ConfirmPunishment({
    required this.punishmentId,
  });

  @override
  List<Object?> get props => [
    punishmentId,
  ];
}

class GetActiveRewardList extends RewardPunishmentEvent {
  final int childrenId;
  final int limit;
  final int cursor;

  const GetActiveRewardList({
    required this.childrenId,
    this.limit = 10,
    this.cursor = 0,
  });

  @override
  List<Object?> get props => [childrenId, limit, cursor];
}

class GetRewardHistoryList extends RewardPunishmentEvent {
  final int childrenId;
  final int limit;
  final int cursor;

  const GetRewardHistoryList({
    required this.childrenId,
    this.limit = 10,
    this.cursor = 0,
  });

  @override
  List<Object?> get props => [childrenId, limit, cursor];
}

// Event ambil punishment aktif
class GetActivePunishmentList extends RewardPunishmentEvent {
  final int childrenId;
  final int limit;
  final int cursor;

  const GetActivePunishmentList({
    required this.childrenId,
    this.limit = 10,
    this.cursor = 0,
  });

  @override
  List<Object?> get props => [childrenId, limit, cursor];
}

// Event ambil punishment history
class GetPunishmentHistoryList extends RewardPunishmentEvent {
  final int childrenId;
  final int limit;
  final int cursor;

  const GetPunishmentHistoryList({
    required this.childrenId,
    this.limit = 10,
    this.cursor = 0,
  });

  @override
  List<Object?> get props => [childrenId, limit, cursor];
}

