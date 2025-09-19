part of 'schedule_bloc.dart';

@immutable
abstract class ScheduleEvent extends Equatable {
  const ScheduleEvent();
}

class ScheduleInitialized extends ScheduleEvent {
  const ScheduleInitialized();

  @override
  List<Object> get props => [];
}

class GetScheduleList extends ScheduleEvent {
  final int childrenId;
  final String dateStart;
  final String? dateEnd;

  const GetScheduleList({
    required this.childrenId,
    required this.dateStart,
    this.dateEnd,
  });

  @override
  List<Object?> get props => [childrenId, dateStart, dateEnd];
}

class GetSuggestedSchedules extends ScheduleEvent {
  final String search;
  final int limit;
  final String? cursor;
  final bool isRefresh;

  const GetSuggestedSchedules({
    this.search = '',
    this.limit = 10,
    this.cursor,
    this.isRefresh = false,
  });

  @override
  List<Object?> get props => [search, limit, cursor, isRefresh];
}

class CreateSchedule extends ScheduleEvent {
  final String date;
  final String? dateEnd;
  final String timeStart;
  final String timeEnd;
  final int? scheduleItemId;
  final String? customName;
  final String? customCategory;
  final String? customIcon;
  final String? customColor;
  final String repeat;
  final int childrenId;

  const CreateSchedule({
    required this.date,
    this.dateEnd,
    required this.timeStart,
    required this.timeEnd,
    this.scheduleItemId,
    this.customName,
    this.customCategory,
    this.customIcon,
    this.customColor,
    required this.repeat,
    required this.childrenId,
  });

  @override
  List<Object?> get props => [
        date,
        dateEnd,
        timeStart,
        timeEnd,
        scheduleItemId,
        customName,
        customCategory,
        customIcon,
        customColor,
        repeat,
        childrenId
      ];
}

class UpdateSchedule extends ScheduleEvent {
  final int scheduleId;
  final String date;
  final String timeStart;
  final String timeEnd;
  final int? scheduleItemId;
  final String? customName;
  final String? customCategory;
  final String? customIcon;
  final String? customColor;

  const UpdateSchedule({
    required this.date,
    required this.scheduleId,
    required this.timeStart,
    required this.timeEnd,
    this.scheduleItemId,
    this.customName,
    this.customCategory,
    this.customIcon,
    this.customColor,
  });

  @override
  List<Object?> get props => [
    date,
    timeStart,
    timeEnd,
    scheduleId,
    scheduleItemId,
    customName,
    customCategory,
    customIcon,
    customColor
  ];
}
