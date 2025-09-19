part of 'reward_punishment_bloc.dart';

@immutable
abstract class RewardPunishmentState extends Equatable {
  const RewardPunishmentState();

  @override
  List<Object?> get props => [];
}

class RewardPunishmentInitial extends RewardPunishmentState {
  const RewardPunishmentInitial();
}

class RewardPunishmentLoading extends RewardPunishmentState {
  const RewardPunishmentLoading();
}

class ActiveRewardLoading extends RewardPunishmentState {
  const ActiveRewardLoading();
}

class ActivePunishmentLoading extends RewardPunishmentState {
  const ActivePunishmentLoading();
}

class RewardHistoryLoading extends RewardPunishmentState {
  const RewardHistoryLoading();
}

class PunishmentHistoryLoading extends RewardPunishmentState {
  const PunishmentHistoryLoading();
}

class CreateRewardSuccess extends RewardPunishmentState {
  final CreateRewardMissionResponse response;

  const CreateRewardSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class UpdateRewardSuccess extends RewardPunishmentState {
  final UpdateRewardMissionResponse response;

  const UpdateRewardSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class DeleteRewardSuccess extends RewardPunishmentState {
  final DeleteRewardResponse response;

  const DeleteRewardSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class ConfirmRewardSuccess extends RewardPunishmentState {
  final ConfirmRewardResponse response;

  const ConfirmRewardSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class UpdateRewardStatusSuccess extends RewardPunishmentState {
  final UpdateRewardStatusResponse response;

  const UpdateRewardStatusSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class UpdatePunishmentStatusSuccess extends RewardPunishmentState {
  final UpdateRewardStatusResponse response;

  const UpdatePunishmentStatusSuccess(this.response);

  @override
  List<Object?> get props => [response];
}


class CreatePunishmentSuccess extends RewardPunishmentState {
  final CreatePunishmentResponse response;

  const CreatePunishmentSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class UpdatePunishmentSuccess extends RewardPunishmentState {
  final UpdatePunishmentResponse response;

  const UpdatePunishmentSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class DeletePunishmentSuccess extends RewardPunishmentState {
  final DeletePunishmentResponse response;

  const DeletePunishmentSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class ConfirmPunishmentSuccess extends RewardPunishmentState {
  final ConfirmPunishmentResponse response;

  const ConfirmPunishmentSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class ActiveRewardListLoaded extends RewardPunishmentState {
  final ActiveRewardListResponse response;

  const ActiveRewardListLoaded(this.response);

  @override
  List<Object?> get props => [response];
}

class RewardHistoryListLoaded extends RewardPunishmentState {
  final RewardHistoryListResponse response;

  const RewardHistoryListLoaded(this.response);

  @override
  List<Object?> get props => [response];
}

class ActivePunishmentListLoaded extends RewardPunishmentState {
  final ActivePunishmentListResponse response;

  const ActivePunishmentListLoaded(this.response);

  @override
  List<Object?> get props => [response];
}

class PunishmentHistoryListLoaded extends RewardPunishmentState {
  final PunishmentHistoryListResponse response;

  const PunishmentHistoryListLoaded(this.response);

  @override
  List<Object?> get props => [response];
}

class RewardPunishmentError extends RewardPunishmentState {
  final String message;

  const RewardPunishmentError(this.message);

  @override
  List<Object?> get props => [message];
}
