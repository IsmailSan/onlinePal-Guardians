part of 'monitoring_bloc.dart';

@immutable
abstract class MonitoringEvent extends Equatable {
  const MonitoringEvent();

  @override
  List<Object?> get props => [];
}

class MonitoringEventInitialized extends MonitoringEvent {
  const MonitoringEventInitialized();
}

class GetScreenTime extends MonitoringEvent {
  final String childrenId;

  const GetScreenTime(this.childrenId);

  @override
  List<Object?> get props => [childrenId];
}

class GetScreenActivity extends MonitoringEvent {
  final String childrenId;

  const GetScreenActivity(this.childrenId);

  @override
  List<Object?> get props => [childrenId];
}

class GetMonitoringCombined extends MonitoringEvent {
  final String childrenId;

  const GetMonitoringCombined(this.childrenId);

  @override
  List<Object?> get props => [childrenId];
}
