part of 'schedule_bloc.dart';

@immutable
abstract class ScheduleState extends Equatable {
  const ScheduleState();

  @override
  List<Object?> get props => [];
}

class ScheduleInitial extends ScheduleState {
  const ScheduleInitial();
}

class ScheduleLoading extends ScheduleState {
  const ScheduleLoading();
}

class ScheduleListSuccess extends ScheduleState {
  final ScheduleListResponse scheduleListResponse;

  const ScheduleListSuccess(this.scheduleListResponse);

  @override
  List<Object?> get props => [scheduleListResponse];
}

class SuggestedSchedulesSuccess extends ScheduleState {
  final SuggestedSchedulesResponse suggestedSchedulesResponse;

  const SuggestedSchedulesSuccess(this.suggestedSchedulesResponse);

  @override
  List<Object?> get props => [suggestedSchedulesResponse];
}

class CreateScheduleSuccess extends ScheduleState {
  final CreateScheduleResponse createScheduleResponse;

  const CreateScheduleSuccess(this.createScheduleResponse);

  @override
  List<Object?> get props => [createScheduleResponse];
}

class UpdateScheduleSuccess extends ScheduleState {
  final UpdateScheduleResponse updateScheduleResponse;

  const UpdateScheduleSuccess(this.updateScheduleResponse);

  @override
  List<Object?> get props => [updateScheduleResponse];
}

class ScheduleError extends ScheduleState {
  final String message;

  const ScheduleError(this.message);

  @override
  List<Object?> get props => [message];
}
