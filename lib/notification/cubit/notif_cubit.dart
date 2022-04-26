import '/models/failure.dart';
import '/models/notification.dart';
import '/repositories/notification/notification_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'notif_state.dart';

class NotifCubit extends Cubit<NotifState> {
  final NotificationRepository _notificationRepository;
  NotifCubit({required NotificationRepository notificationRepository})
      : _notificationRepository = notificationRepository,
        super(NotifState.initail());

  void fetchNotifs({required String? ownerId}) async {
    try {
      emit(state.copyWith(status: NotifStatus.loading));
      final notifs =
          await _notificationRepository.getOwnerNotifications(ownerId: ownerId);
      emit(state.copyWith(status: NotifStatus.succuss, notifs: notifs));
    } on Failure catch (failure) {
      emit(state.copyWith(failure: failure, status: NotifStatus.error));
    }
  }
}
