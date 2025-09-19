import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:online_pal_guardians/models/schedule/suggested_schedules_response.dart';
import 'package:online_pal_guardians/models/schedule/create_schedule_response.dart';
import 'package:online_pal_guardians/models/schedule/schedule_list_response.dart';
import 'package:online_pal_guardians/models/schedule/update_schedule_response.dart';
import 'package:online_pal_guardians/repositories/schedule_repository.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final ScheduleRepository scheduleRepository;

  ScheduleBloc({required this.scheduleRepository}) : super(const ScheduleInitial()) {
    on<ScheduleInitialized>(_onScheduleInitialized);
    on<GetScheduleList>(_onGetScheduleList);
    on<CreateSchedule>(_onCreateSchedule);
    on<UpdateSchedule>(_onUpdateSchedule);
    on<GetSuggestedSchedules>(_onGetSuggestedSchedules);
  }

  void _onScheduleInitialized(
      ScheduleInitialized event,
      Emitter<ScheduleState> emit,
      ) {
    emit(const ScheduleInitial());
  }

  Future<void> _onGetScheduleList(
      GetScheduleList event,
      Emitter<ScheduleState> emit,
      ) async {
    emit(const ScheduleLoading());
    try {
      final response = await scheduleRepository.getScheduleList(
        childrenId: event.childrenId,
        dateStart: event.dateStart,
        dateEnd: event.dateEnd ?? ""
      );
      emit(ScheduleListSuccess(response));
    } catch (e) {
      emit(ScheduleError(e.toString()));
    }
  }

  Future<void> _onCreateSchedule(
      CreateSchedule event,
      Emitter<ScheduleState> emit,
      ) async {
    emit(const ScheduleLoading());
    try {
      final response = await scheduleRepository.createSchedule(
        date: event.date,
        dateEnd: event.dateEnd,
        timeStart: event.timeStart,
        timeEnd: event.timeEnd,
        scheduleItemId: event.scheduleItemId,
        customName: event.customName,
        customCategory: event.customCategory,
        customIcon: event.customIcon,
        customColor: event.customColor,
        repeat: event.repeat,
        childrenId: event.childrenId
      );
      emit(CreateScheduleSuccess(response));
    } catch (e) {
      emit(ScheduleError(e.toString()));
    }
  }

  Future<void> _onUpdateSchedule(
      UpdateSchedule event,
      Emitter<ScheduleState> emit,
      ) async {
    emit(const ScheduleLoading());
    try {
      final response = await scheduleRepository.updateSchedule(
        scheduleId: event.scheduleId,
        date: event.date,
        timeStart: event.timeStart,
        timeEnd: event.timeEnd,
        scheduleItemId: event.scheduleItemId,
        customName: event.customName,
        customCategory: event.customCategory,
        customIcon: event.customIcon,
        customColor: event.customColor,
      );
      emit(UpdateScheduleSuccess(response));
    } catch (e) {
      emit(ScheduleError(e.toString()));
    }
  }

  Future<void> _onGetSuggestedSchedules(
      GetSuggestedSchedules event,
      Emitter<ScheduleState> emit,
      ) async {
    try {
      int cursor = 0;
      List<SuggestedSchedule>  suggestedSchedules= [];

      if (state is SuggestedSchedulesSuccess && !event.isRefresh) {
        final current = state as SuggestedSchedulesSuccess;
        cursor = current.suggestedSchedulesResponse.data.nextCursor ?? 0;
        suggestedSchedules = current.suggestedSchedulesResponse.data.data;

        if (current.suggestedSchedulesResponse.data.nextCursor == null) return;
      } else {
        emit(const ScheduleLoading());
      }

      final response = await scheduleRepository.getSuggestedSchedules(
        search: event.search,
        cursor: cursor,
        limit: event.limit,
      );

      final allSuggestedSchedules = [
        ...suggestedSchedules,
        ...response.data.data,
      ];

      final updatedResponse = SuggestedSchedulesResponse(
        status: response.status,
        message: response.message,
        data: SuggestedScheduleData(
          data: allSuggestedSchedules,
          nextCursor: response.data.nextCursor,
        ),
      );

      emit(SuggestedSchedulesSuccess(updatedResponse));
    } catch (e) {
      emit(ScheduleError(e.toString()));
    }
  }
}

