import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:online_pal_guardians/models/monitoring/screen_activity_response.dart';
import 'package:online_pal_guardians/models/monitoring/screen_time_response.dart';
import 'package:online_pal_guardians/repositories/monitoring_repository.dart';

part 'monitoring_event.dart';
part 'monitoring_state.dart';

class MonitoringBloc extends Bloc<MonitoringEvent, MonitoringState> {
  final MonitoringRepository monitoringRepository;

  MonitoringBloc({required this.monitoringRepository})
      : super(const MonitoringInitial()) {
    on<MonitoringEventInitialized>(_onInitialized);
    on<GetScreenTime>(_onGetScreenTime);
    on<GetScreenActivity>(_onGetScreenActivity);
    on<GetMonitoringCombined>(_onGetMonitoringCombined);
  }

  void _onInitialized(
    MonitoringEventInitialized event,
    Emitter<MonitoringState> emit,
  ) {
    emit(const MonitoringInitial());
  }

  Future<void> _onGetScreenTime(
    GetScreenTime event,
    Emitter<MonitoringState> emit,
  ) async {
    emit(const MonitoringLoading());
    try {
      final screenTime =
          await monitoringRepository.getScreenTime(event.childrenId);
      emit(GetScreenTimeSuccess(screenTime));
    } catch (e) {
      emit(MonitoringError(e.toString()));
    }
  }

  Future<void> _onGetScreenActivity(
    GetScreenActivity event,
    Emitter<MonitoringState> emit,
  ) async {
    emit(const MonitoringLoading());
    try {
      final screenActivity =
          await monitoringRepository.getScreenActivity(event.childrenId);
      emit(GetScreenActivitySuccess(screenActivity));
    } catch (e) {
      emit(MonitoringError(e.toString()));
    }
  }

  Future<void> _onGetMonitoringCombined(
    GetMonitoringCombined event,
    Emitter<MonitoringState> emit,
  ) async {
    emit(const MonitoringLoading());
    try {
      final screenTime =
          await monitoringRepository.getScreenTime(event.childrenId);
      final screenActivity =
          await monitoringRepository.getScreenActivity(event.childrenId);
      emit(GetMonitoringCombinedSuccess(
        screenTime: screenTime,
        screenActivity: screenActivity,
      ));
    } catch (e) {
      emit(MonitoringError(e.toString()));
    }
  }
}
