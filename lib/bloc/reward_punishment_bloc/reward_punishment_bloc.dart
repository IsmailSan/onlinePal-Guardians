import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:online_pal_guardians/models/reward_punishment/active_punishment_list_response.dart';
import 'package:online_pal_guardians/models/reward_punishment/active_reward_list_response.dart';
import 'package:online_pal_guardians/models/reward_punishment/confirm_punishment_response.dart';
import 'package:online_pal_guardians/models/reward_punishment/confirm_reward_response.dart';
import 'package:online_pal_guardians/models/reward_punishment/create_punishment_response.dart';
import 'package:online_pal_guardians/models/reward_punishment/create_reward_mission_response.dart';
import 'package:online_pal_guardians/models/reward_punishment/delete_punishment_response.dart';
import 'package:online_pal_guardians/models/reward_punishment/delete_reward_response.dart';
import 'package:online_pal_guardians/models/reward_punishment/punishment_history_list_response.dart';
import 'package:online_pal_guardians/models/reward_punishment/reward_history_list_response.dart';
import 'package:online_pal_guardians/models/reward_punishment/update_punishment_response.dart';
import 'package:online_pal_guardians/models/reward_punishment/update_reward_mission_response.dart';
import 'package:online_pal_guardians/models/reward_punishment/update_reward_status_response.dart';
import 'package:online_pal_guardians/repositories/reward_punishment_repository.dart';

part 'reward_punishment_event.dart';
part 'reward_punishment_state.dart';

class RewardPunishmentBloc
    extends Bloc<RewardPunishmentEvent, RewardPunishmentState> {
  final RewardPunishmentRepository rewardPunishmentRepository;

  RewardPunishmentBloc({required this.rewardPunishmentRepository})
      : super(const RewardPunishmentInitial()) {
    on<RewardPunishmentInitialized>(_onInitialized);
    on<CreateReward>(_onCreateReward);
    on<UpdateReward>(_onUpdateReward);
    on<DeleteReward>(_onDeleteReward);
    on<ConfirmReward>(_onConfirmReward);
    on<CreatePunishment>(_onCreatePunishment);
    on<UpdatePunishment>(_onUpdatePunishment);
    on<DeletePunishment>(_onDeletePunishment);
    on<ConfirmPunishment>(_onConfirmPunishment);
    on<GetActiveRewardList>(_onGetActiveRewardList);
    on<GetRewardHistoryList>(_onGetRewardHistoryList);
    on<GetActivePunishmentList>(_onGetActivePunishmentList);
    on<GetPunishmentHistoryList>(_onGetPunishmentHistoryList);
    on<UpdateRewardStatus>(_onUpdateRewardStatus);
    on<UpdatePunishmentStatus>(_onUpdatePunishmentStatus);
  }

  void _onInitialized(
    RewardPunishmentInitialized event,
    Emitter<RewardPunishmentState> emit,
  ) {
    emit(const RewardPunishmentInitial());
  }

  Future<void> _onCreateReward(
    CreateReward event,
    Emitter<RewardPunishmentState> emit,
  ) async {
    emit(const RewardPunishmentLoading());

    try {
      final response = await rewardPunishmentRepository.createReward(
        missionId: event.missionId,
        childrenId: event.childrenId,
        type: event.type,
        name: event.name,
        description: event.description,
        pointsNeeded: event.pointsNeeded,
        condition: event.condition,
        frequencyCount: event.frequencyCount != null
            ? int.tryParse(event.frequencyCount!) // parse String to int safely
            : null,
        periodStartDate: event.periodStartDate,
        periodEndDate: event.periodEndDate,
      );

      emit(CreateRewardSuccess(response));
    } catch (e) {
      emit(CreateRewardError(e.toString()));
    }
  }

  Future<void> _onUpdateReward(
    UpdateReward event,
    Emitter<RewardPunishmentState> emit,
  ) async {
    emit(const RewardPunishmentLoading());
    try {
      final response = await rewardPunishmentRepository.updateReward(
        rewardId: event.rewardId,
        missionId: event.missionId,
        childrenId: event.childrenId,
        type: event.type,
        name: event.name,
        description: event.description,
        pointsNeeded: event.pointsNeeded,
        condition: event.condition,
        frequencyCount: event.frequencyCount != null
            ? int.tryParse(event.frequencyCount!) // parse String to int safely
            : null,
        periodStartDate: event.periodStartDate,
        periodEndDate: event.periodEndDate,
      );
      emit(UpdateRewardSuccess(response));
    } catch (e) {
      emit(UpdateRewardError(e.toString()));
    }
  }

  Future<void> _onDeleteReward(
    DeleteReward event,
    Emitter<RewardPunishmentState> emit,
  ) async {
    emit(RewardPunishmentLoading());
    try {
      final response = await rewardPunishmentRepository.deleteReward(
        rewardId: event.rewardId,
      );
      emit(DeleteRewardSuccess(response));
    } catch (e) {
      emit(DeleteRewardError(e.toString()));
    }
  }

  Future<void> _onConfirmReward(
    ConfirmReward event,
    Emitter<RewardPunishmentState> emit,
  ) async {
    emit(RewardPunishmentLoading());
    try {
      final response = await rewardPunishmentRepository.confirmReward(
        rewardId: event.rewardId,
      );
      emit(ConfirmRewardSuccess(response));
    } catch (e) {
      emit(RewardPunishmentError(e.toString()));
    }
  }

  Future<void> _onUpdateRewardStatus(
    UpdateRewardStatus event,
    Emitter<RewardPunishmentState> emit,
  ) async {
    emit(RewardPunishmentLoading());
    try {
      final response = await rewardPunishmentRepository.updateRewardStatus(
        rewardId: event.rewardId,
      );
      emit(UpdateRewardStatusSuccess(response));
    } catch (e) {
      emit(RewardPunishmentError(e.toString()));
    }
  }

  Future<void> _onCreatePunishment(
    CreatePunishment event,
    Emitter<RewardPunishmentState> emit,
  ) async {
    emit(const RewardPunishmentLoading());
    try {
      final response = await rewardPunishmentRepository.createPunishment(
        missionId: event.missionId,
        childrenId: event.childrenId,
        name: event.name,
        description: event.description,
        pointReduction: event.pointReduction,
        periodStartDate: event.periodStartDate,
        periodEndDate: event.periodEndDate,
        condition: event.condition,
        frequencyCount: event.frequencyCount,
      );
      emit(CreatePunishmentSuccess(response));
    } catch (e) {
      emit(CreatePunishmentError(e.toString()));
    }
  }

  Future<void> _onUpdatePunishment(
    UpdatePunishment event,
    Emitter<RewardPunishmentState> emit,
  ) async {
    emit(const RewardPunishmentLoading());
    try {
      final response = await rewardPunishmentRepository.updatePunishment(
        punishmentId: event.punishmentId,
        childrenId: event.childrenId,
        missionId: event.missionId,
        periodStartDate: event.periodStartDate,
        periodEndDate: event.periodEndDate,
        condition: event.condition,
        frequencyCount: event.frequencyCount,
        pointReduction: event.pointReduction,
        name: event.name,
        description: event.description,
      );
      emit(UpdatePunishmentSuccess(response));
    } catch (e) {
      emit(UpdatePunishmentError(e.toString()));
    }
  }

  Future<void> _onUpdatePunishmentStatus(
    UpdatePunishmentStatus event,
    Emitter<RewardPunishmentState> emit,
  ) async {
    emit(RewardPunishmentLoading());
    try {
      final response = await rewardPunishmentRepository.updatePunishmentStatus(
        rewardId: event.rewardId,
      );
      emit(UpdatePunishmentStatusSuccess(response));
    } catch (e) {
      emit(RewardPunishmentError(e.toString()));
    }
  }

  Future<void> _onDeletePunishment(
    DeletePunishment event,
    Emitter<RewardPunishmentState> emit,
  ) async {
    emit(RewardPunishmentLoading());
    try {
      final response = await rewardPunishmentRepository.deletePunishment(
        punishmentId: event.punishmentId,
      );
      emit(DeletePunishmentSuccess(response));
    } catch (e) {
      emit(DeletePunishmentError(e.toString()));
    }
  }

  Future<void> _onConfirmPunishment(
    ConfirmPunishment event,
    Emitter<RewardPunishmentState> emit,
  ) async {
    emit(RewardPunishmentLoading());
    try {
      final response = await rewardPunishmentRepository.confirmPunishment(
        punishmentId: event.punishmentId,
      );
      emit(ConfirmPunishmentSuccess(response));
    } catch (e) {
      emit(RewardPunishmentError(e.toString()));
    }
  }

  void _onGetActiveRewardList(
    GetActiveRewardList event,
    Emitter<RewardPunishmentState> emit,
  ) async {
    try {
      int cursor = 0;
      List<RewardItem> existingRewards = [];

      if (state is ActiveRewardListLoaded) {
        final current = state as ActiveRewardListLoaded;
        cursor = current.response.data?.nextCursor ?? 0;
        existingRewards = current.response.data?.data ?? [];

        if (current.response.data?.nextCursor == null) return;
      } else {
        emit(ActiveRewardLoading());
      }

      final response = await rewardPunishmentRepository.getActiveRewardList(
          childrenId: event.childrenId, cursor: cursor, limit: 10);

      final allRewards = [
        ...existingRewards,
        ...?response.data?.data,
      ];

      final updatedResponse = ActiveRewardListResponse(
        status: response.status,
        message: response.message,
        data: RewardListData(
          data: allRewards,
          nextCursor: response.data?.nextCursor,
        ),
      );

      emit(ActiveRewardListLoaded(updatedResponse));
    } catch (e) {
      emit(RewardPunishmentError(e.toString()));
    }
  }

  void _onGetRewardHistoryList(
    GetRewardHistoryList event,
    Emitter<RewardPunishmentState> emit,
  ) async {
    try {
      int cursor = 0;
      List<RewardHistoryItem> existingRewards = [];

      if (state is RewardHistoryListLoaded) {
        final current = state as RewardHistoryListLoaded;
        cursor = current.response.data?.nextCursor ?? 0;
        existingRewards = current.response.data?.data ?? [];

        // Jika nextCursor null, artinya tidak ada data berikutnya
        if (current.response.data?.nextCursor == null) return;
      } else {
        emit(RewardHistoryLoading());
      }

      final response = await rewardPunishmentRepository.getHistoryRewardList(
          childrenId: event.childrenId, cursor: cursor, limit: 10);

      final allRewards = [
        ...existingRewards,
        ...?response.data?.data,
      ];

      final updatedResponse = RewardHistoryListResponse(
        status: response.status,
        message: response.message,
        data: RewardHistoryListData(
          data: allRewards,
          nextCursor: response.data?.nextCursor,
        ),
      );

      emit(RewardHistoryListLoaded(updatedResponse));
    } catch (e) {
      emit(RewardPunishmentError(e.toString()));
    }
  }

  void _onGetActivePunishmentList(
    GetActivePunishmentList event,
    Emitter<RewardPunishmentState> emit,
  ) async {
    try {
      int cursor = 0;
      List<PunishmentItem> existingPunishments = [];

      if (state is ActivePunishmentListLoaded) {
        final current = state as ActivePunishmentListLoaded;
        cursor = current.response.data?.nextCursor ?? 0;
        existingPunishments = current.response.data?.data ?? [];

        // Jika nextCursor null, artinya tidak ada data berikutnya
        if (current.response.data?.nextCursor == null) return;
      } else {
        emit(ActivePunishmentLoading());
      }

      final response = await rewardPunishmentRepository.getActivePunishmentList(
          childrenId: event.childrenId, cursor: cursor, limit: 10);

      final allPunishments = [
        ...existingPunishments,
        ...?response.data?.data,
      ];

      final updatedResponse = ActivePunishmentListResponse(
        status: response.status,
        message: response.message,
        data: PunishmentListData(
          data: allPunishments,
          nextCursor: response.data?.nextCursor,
        ),
      );

      emit(ActivePunishmentListLoaded(updatedResponse));
    } catch (e) {
      emit(RewardPunishmentError(e.toString()));
    }
  }

  void _onGetPunishmentHistoryList(
    GetPunishmentHistoryList event,
    Emitter<RewardPunishmentState> emit,
  ) async {
    try {
      int cursor = 0;
      List<PunishmentHistoryItem> existingPunishments = [];

      if (state is PunishmentHistoryListLoaded) {
        final current = state as PunishmentHistoryListLoaded;
        cursor = current.response.data?.nextCursor ?? 0;
        existingPunishments = current.response.data?.data ?? [];

        // Jika nextCursor null, artinya tidak ada data berikutnya
        if (current.response.data?.nextCursor == null) return;
      } else {
        emit(PunishmentHistoryLoading());
      }

      final response =
          await rewardPunishmentRepository.getHistoryPunishmentList(
              childrenId: event.childrenId, cursor: cursor, limit: 10);

      final allPunishments = [
        ...existingPunishments,
        ...?response.data?.data,
      ];

      final updatedResponse = PunishmentHistoryListResponse(
        status: response.status,
        message: response.message,
        data: PunishmentHistoryListData(
          data: allPunishments,
          nextCursor: response.data?.nextCursor,
        ),
      );

      emit(PunishmentHistoryListLoaded(updatedResponse));
    } catch (e) {
      emit(RewardPunishmentError(e.toString()));
    }
  }
}
