part of 'notification_bloc.dart';

@immutable
abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object?> get props => [];
}

class NotificationInitial extends NotificationState {
  const NotificationInitial();
}

class NotificationLoading extends NotificationState {
  const NotificationLoading();
}

class NotificationListSuccess extends NotificationState {
  final NotificationListResponse notificationsListResponse;

  const NotificationListSuccess(this.notificationsListResponse);

  @override
  List<Object?> get props => [notificationsListResponse];
}

class MarkAsReadNotifSuccess extends NotificationState {
  final MarkAsReadNotifResponse markAsReadNotifResponse;

  const MarkAsReadNotifSuccess(this.markAsReadNotifResponse);

  @override
  List<Object?> get props => [markAsReadNotifResponse];
}

class NotificationError extends NotificationState {
  final String message;

  const NotificationError(this.message);

  @override
  List<Object?> get props => [message];
}
