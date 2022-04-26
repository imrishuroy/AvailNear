import '/models/notification.dart';

abstract class BaseNotificationRepository {
  Future<List<Notification?>> getOwnerNotifications({
    required String? ownerId,
  });
}
