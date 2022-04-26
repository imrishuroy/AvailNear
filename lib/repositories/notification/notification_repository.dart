import 'package:availnear/config/paths.dart';
import 'package:availnear/models/failure.dart';
import 'package:availnear/models/notification.dart';

import '/repositories/notification/base_notification_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationRepository extends BaseNotificationRepository {
  final FirebaseFirestore _firestore;

  NotificationRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<List<Notification?>> getOwnerNotifications({
    required String? ownerId,
  }) async {
    try {
      if (ownerId == null) {
        return [];
      }
      final notifSnaps = await _firestore
          .collection(Paths.notifications)
          .doc(ownerId)
          .collection(Paths.notifs)
          .get();

      return notifSnaps.docs
          .map((doc) => Notification.fromMap(doc.data()))
          .toList();
    } catch (error) {
      print('Error getting owner notifications ${error.toString()}');
      throw const Failure(message: 'Error getting notifications');
    }
  }
}
