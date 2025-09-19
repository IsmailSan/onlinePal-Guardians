part of 'monitoring_bloc.dart';

@immutable
abstract class MonitoringState extends Equatable {
  const MonitoringState();

  @override
  List<Object?> get props => [];
}

class MonitoringInitial extends MonitoringState {
  const MonitoringInitial();
}

class MonitoringLoading extends MonitoringState {
  const MonitoringLoading();
}

/// Success saat berhasil dapat data screen time
class GetScreenTimeSuccess extends MonitoringState {
  final ScreenTimeResponse response;

  const GetScreenTimeSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

/// Success saat berhasil dapat data screen activity
class GetScreenActivitySuccess extends MonitoringState {
  final ScreenActivityResponse response;

  const GetScreenActivitySuccess(this.response);

  @override
  List<Object?> get props => [response];
}

/// Jika ingin menggabungkan hasil screenTime & screenActivity sekaligus:
class GetMonitoringCombinedSuccess extends MonitoringState {
  final ScreenTimeResponse screenTime;
  final ScreenActivityResponse screenActivity;

  const GetMonitoringCombinedSuccess({
    required this.screenTime,
    required this.screenActivity,
  });

  @override
  List<Object?> get props => [screenTime, screenActivity];
}

class MonitoringError extends MonitoringState {
  final String message;

  const MonitoringError(this.message);

  @override
  List<Object?> get props => [message];
}
