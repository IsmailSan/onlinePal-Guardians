part of 'notification_bloc.dart';

@immutable
abstract class NotificationEvent extends Equatable {
  const NotificationEvent();
}

class NotificationInitialized extends NotificationEvent {
  const NotificationInitialized();

  @override
  List<Object> get props => [];
}

class GetNotifications extends NotificationEvent {
  final String search;
  final int limit;
  final String? cursor;
  final bool isRefresh;

  const GetNotifications({
    this.search = '',
    this.limit = 10,
    this.cursor,
    this.isRefresh = false,
  });

  @override
  List<Object?> get props => [search, limit, cursor, isRefresh];
}

class MarkAsReadNotification extends NotificationEvent {
  final int notificationId;

  const MarkAsReadNotification({required this.notificationId});

  @override
  List<Object> get props => [notificationId];
}
