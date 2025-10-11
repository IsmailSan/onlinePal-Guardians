import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_pal_guardians/bloc/mission_bloc/mission_event.dart';
import 'package:online_pal_guardians/bloc/mission_bloc/mission_state.dart';
import 'package:online_pal_guardians/models/mission/app_category_list_response.dart';
import 'package:online_pal_guardians/models/mission/app_list_response.dart';
import 'package:online_pal_guardians/models/mission/mission_list_response.dart';
import 'package:online_pal_guardians/models/mission/suggested_mission_list_response.dart';
import 'package:online_pal_guardians/repositories/mission_repository.dart';

class MissionBloc extends Bloc<MissionEvent, MissionState> {
  final MissionRepository missionRepository;

  MissionBloc({required this.missionRepository}) : super(MissionInitial()) {
    on<MissionInitialized>(_onMissionInitialized);
    on<GetSuggestedMissions>(_onGetSuggestedMissions);
    on<GetAppList>(_onGetAppList);
    on<GetAppCategoryList>(_onGetAppCategoryList);
    on<CreateMissionFromSuggestion>(_onCreateMissionFromSuggestion);
    on<CreateAllMissionFromSuggestion>(_onCreateAllMissionFromSuggestion);
    on<CreateNewMission>(_onCreateNewMission);
    on<DeleteMission>(_onDeleteMission);
    on<GetMissions>(_onGetMissions);
    on<GetMissionsHistory>(_onGetMissionsHistory);
    on<UpdateMission>(_onUpdateMission);
    on<LoadAllMissions>(_onLoadAllMissions);
  }

  void _onMissionInitialized(
      MissionInitialized event, Emitter<MissionState> emit) {
    emit(MissionInitial());
  }

  Future<void> _onGetSuggestedMissions(
    GetSuggestedMissions event,
    Emitter<MissionState> emit,
  ) async {
    try {
      List<SuggestedMission> existingMissions = [];

      // Hanya ambil existing jika bukan refresh dan sudah ada state sukses
      if (state is SuggestedMissionSuccess && !event.isRefresh) {
        final current = state as SuggestedMissionSuccess;

        if (current.response.data.nextCursor == null) return;

        existingMissions = current.response.data.data ?? [];
      } else {
        emit(MissionLoading());
      }

      final response = await missionRepository.getSuggestedMissionList(
        cursor: event.cursor,
        limit: event.limit,
      );

      final allMissions = [
        ...existingMissions,
        ...response.data.data,
      ];

      final updatedResponse = SuggestedMissionListResponse(
        status: response.status,
        message: response.message,
        data: SuggestedMissionListData(
          data: allMissions,
          nextCursor: response.data.nextCursor,
        ),
      );

      emit(SuggestedMissionSuccess(updatedResponse));
    } catch (e) {
      emit(MissionError(e.toString()));
    }
  }

  Future<void> _onGetAppCategoryList(
    GetAppCategoryList event,
    Emitter<MissionState> emit,
  ) async {
    try {
      List<AppCategoryData> existingAppCategory = [];

      // Hanya ambil existing jika bukan refresh dan sudah ada state sukses
      if (state is AppCategoryListSuccess && !event.isRefresh) {
        final current = state as AppCategoryListSuccess;

        // Kalau nextCursor null, berarti tidak ada data baru
        if (current.response.data?.nextCursor == null) return;

        existingAppCategory = current.response.data?.data ?? [];
      } else {
        emit(MissionLoading());
      }

      final response = await missionRepository.getAppCategoryList(
        cursor: event.cursor,
        limit: event.limit,
      );

      // 🔥 Perbaikan di sini
      final newCategories = response.data?.data ?? <AppCategoryData>[];

      final allCategories = <AppCategoryData>[
        ...existingAppCategory,
        ...newCategories,
      ];

      final updatedResponse = AppCategoryListResponse(
        status: response.status,
        message: response.message,
        data: AppCategoryListData(
          data: allCategories,
          nextCursor: response.data?.nextCursor,
        ),
      );

      emit(AppCategoryListSuccess(updatedResponse));
    } catch (e) {
      emit(MissionError(e.toString()));
    }
  }

  Future<void> _onGetAppList(
    GetAppList event,
    Emitter<MissionState> emit,
  ) async {
    try {
      // Kalau sebelumnya sudah ada data di state, ambil dulu
      final currentState = state;
      List<AppData> oldData = [];
      String? nextCursor;

      if (currentState is AppListSuccess && event.cursor != null) {
        oldData = currentState.response.data?.data ?? [];
        nextCursor = currentState.response.data?.nextCursor;
      }

      // Panggil API
      final response = await missionRepository.getAppList(
        cursor: event.cursor,
        limit: event.limit,
        categoryAppId: event.appCategoryId,
      );

      // Gabungkan data lama dengan data baru kalau pagination
      final mergedData = <AppData>[
        ...oldData,
        ...(response.data?.data ?? []),
      ];

      final mergedResponse = AppListResponse(
        status: response.status,
        message: response.message,
        data: AppListData(
          data: mergedData,
          nextCursor: response.data?.nextCursor,
        ),
      );

      emit(AppListSuccess(response));
    } catch (e) {
      emit(MissionError(e.toString()));
    }
  }

  Future<void> _onGetMissions(
    GetMissions event,
    Emitter<MissionState> emit,
  ) async {
    try {
      int? cursor;
      List<Mission> existingMissions = [];
      Map<String, MissionListResponse> currentMap = {};

      if (state is MissionListSuccess) {
        currentMap = Map<String, MissionListResponse>.from(
          (state as MissionListSuccess).missionsByStatus,
        );

        final existingResponse = currentMap[event.status];
        if (existingResponse != null && !event.isRefresh) {
          cursor = existingResponse.data?.nextCursor;
          existingMissions = existingResponse.data?.data ?? [];

          if (cursor == null) {
            // Tidak ada data lagi, hentikan pagination
            return;
          }
        }
      } else if (event.isRefresh || !(state is MissionListSuccess)) {
        switch (event.status) {
          case "active":
            emit(ActiveMissionLoading());
            break;
          case "waiting":
            emit(WaitingMissionLoading());
            break;
          case "completed":
            emit(MissionHistoryLoading());
            break;
          default:
            emit(MissionLoading()); // fallback
        }
      }

      final response = await missionRepository.getMissionList(
        childrenId: event.childrenId,
        status: event.status,
        cursor: cursor ?? 0,
        limit: event.limit,
      );

      final newMissions = response.data?.data;
      final allMissions = [...?existingMissions, ...?newMissions];

      final updatedResponse = MissionListResponse(
        status: response.status,
        message: response.message,
        data: MissionData(
          data: allMissions,
          nextCursor: response.data?.nextCursor,
        ),
      );

      currentMap[event.status] = updatedResponse;
      emit(MissionListSuccess(currentMap));
    } catch (e) {
      emit(MissionError(e.toString()));
    }
  }

  Future<void> _onGetMissionsHistory(
    GetMissionsHistory event,
    Emitter<MissionState> emit,
  ) async {
    try {
      int? cursor;
      List<Mission> existingMissions = [];

      if (state is MissionHistoryListSuccess && !event.isRefresh) {
        final current = state as MissionHistoryListSuccess;

        if (current.response.data?.nextCursor == null) return;

        existingMissions = current.response.data?.data ?? [];
      } else {
        emit(MissionLoading());
      }

      final response = await missionRepository.getMissionHistoryList(
        childrenId: event.childrenId,
        cursor: cursor ?? 0,
        limit: event.limit,
      );
      final List<Mission> newMissions = response.data?.data ?? <Mission>[];
      final List<Mission> allMissions = [
        ...existingMissions,
        ...newMissions,
      ];

      final updatedResponse = MissionListResponse(
        status: response.status,
        message: response.message,
        data: MissionData(
          data: allMissions,
          nextCursor: response.data?.nextCursor,
        ),
      );

      emit(MissionHistoryListSuccess(updatedResponse));
    } catch (e) {
      emit(MissionError(e.toString()));
    }
  }

  Future<void> _onCreateMissionFromSuggestion(
    CreateMissionFromSuggestion event,
    Emitter<MissionState> emit,
  ) async {
    emit(CreateMissionLoading());
    try {
      final response = await missionRepository.createMissionFromSuggestion(
        missionSuggestionId: event.missionSuggestionId,
        childrenId: event.childrenId,
      );
      emit(CreateMissionFromSuggestionSuccess(response));
    } catch (e) {
      emit(CreateMissionError(e.toString()));
    }
  }

  Future<void> _onCreateAllMissionFromSuggestion(
    CreateAllMissionFromSuggestion event,
    Emitter<MissionState> emit,
  ) async {
    emit(CreateMissionLoading());
    try {
      final response = await missionRepository.createAllMissionFromSuggestion(
        type: event.type,
        childrenId: event.childrenId,
      );
      emit(CreateAllMissionFromSuggestionSuccess(response));
    } catch (e) {
      emit(CreateMissionError(e.toString()));
    }
  }

  Future<void> _onCreateNewMission(
    CreateNewMission event,
    Emitter<MissionState> emit,
  ) async {
    emit(CreateMissionLoading());
    try {
      final response = await missionRepository.createNewMission(
        childrenId: event.childrenId,
        name: event.name,
        description: event.description,
        reward: event.reward,
        punishment: event.punishment,
        periodeTime: event.periodeTime,
        startDate: event.startDate,
        endDate: event.endDate,
        type: event.type,
        condition: event.condition,
        categoryAppsId: event.categoryAppsId,
        appsId: event.appsId,
        directReward: event.directReward,
        directPunishment: event.directPunishment,
        pointAddition: event.pointAddition,
        pointDeduction: event.pointDeduction,
      );

      emit(CreateNewMissionSuccess(response));
    } catch (e) {
      emit(CreateMissionError(e.toString()));
    }
  }

  Future<void> _onDeleteMission(
    DeleteMission event,
    Emitter<MissionState> emit,
  ) async {
    emit(DeleteMissionLoading());
    try {
      final response = await missionRepository.deleteMission(
        missionId: event.missionId,
      );
      emit(DeleteMissionSuccess(response));
    } catch (e) {
      emit(MissionError(e.toString()));
    }
  }

  Future<void> _onUpdateMission(
    UpdateMission event,
    Emitter<MissionState> emit,
  ) async {
    emit(MissionLoading());
    try {
      final response = await missionRepository.updateMission(
        missionId: event.missionId,
        childrenId: event.childrenId,
        name: event.name,
        description: event.description,
        reward: event.reward,
        punishment: event.punishment,
        periodeTime: event.periodeTime,
        startDate: event.startDate,
        endDate: event.endDate,
        type: event.type,
        condition: event.condition,
        appCategory: event.appCategory,
        appName: event.appName,
        directReward: event.directReward,
        directPunishment: event.directPunishment,
        pointAddition: event.pointAddition,
        pointDeduction: event.pointDeduction,
      );
      emit(UpdateMissionSuccess(response));
    } catch (e) {
      emit(MissionError(e.toString()));
    }
  }

  void _onLoadAllMissions(
    LoadAllMissions event,
    Emitter<MissionState> emit,
  ) async {
    emit(MissionLoading());

    final Map<String, MissionListResponse> missionsMap = {};

    for (final status in ["active", "waiting", "completed"]) {
      try {
        final response = await missionRepository.getMissionList(
          childrenId: event.childrenId,
          status: status,
          cursor: 0,
          limit: event.limit,
        );
        missionsMap[status] = response;
      } catch (e) {}
    }

    emit(MissionListSuccess(missionsMap));
  }
}
