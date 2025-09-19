import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:online_pal_guardians/repositories/notification_repository.dart';
import 'package:online_pal_guardians/models/notification/notification_list_response.dart';
import 'package:online_pal_guardians/models/notification/mark_as_notif_response.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepository notificationRepository;

  NotificationBloc({required this.notificationRepository})
      : super(const NotificationInitial()) {
    on<NotificationInitialized>(_onNotificationInitialized);
    on<MarkAsReadNotification>(_onMarkAsReadNotif);
    on<GetNotifications>(_onGetNotifications);
  }

  void _onNotificationInitialized(
      NotificationInitialized event, Emitter<NotificationState> emit) {
    emit(const NotificationInitial());
  }

  Future<void> _onGetNotifications(
      GetNotifications event,
      Emitter<NotificationState> emit,
      ) async {
    try {
      int cursor = 0;
      Map<String, List<NotificationItem>> existingData = {};

      if (state is NotificationListSuccess && !event.isRefresh) {
        final current = state as NotificationListSuccess;
        cursor = current.notificationsListResponse.data?.nextCursor ?? 0;
        existingData = current.notificationsListResponse.data?.data ?? {};

        if (current.notificationsListResponse.data?.nextCursor == null) return;
      } else {
        emit(const NotificationLoading());
      }

      final response = await notificationRepository.getNotificationList(
        search: event.search,
        cursor: cursor,
        limit: event.limit,
      );

      final newData = response.data?.data ?? {};

      // Gabungkan existingData dengan newData
      final mergedData = Map<String, List<NotificationItem>>.from(existingData);

      for (final entry in newData.entries) {
        if (mergedData.containsKey(entry.key)) {
          mergedData[entry.key] = [...mergedData[entry.key]!, ...entry.value];
        } else {
          mergedData[entry.key] = entry.value;
        }
      }

      final updatedResponse = NotificationListResponse(
        status: response.status,
        message: response.message,
        data: NotificationData(
          data: mergedData,
          nextCursor: response.data?.nextCursor,
        ),
      );

      emit(NotificationListSuccess(updatedResponse));
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }
  Future<void> _onMarkAsReadNotif(
      MarkAsReadNotification event,
      Emitter<NotificationState> emit,
      ) async {
    emit(const NotificationLoading());
    try {
      final response = await notificationRepository.markAsReadNotif(
        notificationId: event.notificationId,
      );
      emit(MarkAsReadNotifSuccess(response));
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }
}
