import 'package:cloud_firestore/cloud_firestore.dart';
import '/config/paths.dart';
import '/models/app_user.dart';
import '/models/failure.dart';
import '/repositories/profile/base_profile_repo.dart';

class ProfileRepository extends BaseProfileRepository {
  final FirebaseFirestore _firestore;

  ProfileRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<void> createUserProfile({required AppUser? user}) async {
    try {
      if (user == null) return;

      await _firestore.collection(Paths.users).add(user.toMap());
    } catch (error) {
      print('Error creating owner ${error.toString()}');
      rethrow;
    }
  }

  Future<void> updateUserProfile({required AppUser? user}) async {
    try {
      if (user == null) return;

      await _firestore
          .collection(Paths.users)
          .doc(user.userId)
          .update(user.toMap());
    } catch (error) {
      print('Error creating owner ${error.toString()}');
      rethrow;
    }
  }

  Future<AppUser?> loadUserProfile({required String? userId}) async {
    try {
      if (userId == null) {
        return null;
      }

      final userSnap =
          await _firestore.collection(Paths.users).doc(userId).get();

      print('User snap -- ${userSnap.data()}');

      return AppUser.fromDocument(userSnap);
    } catch (error) {
      print('Error in loading user profile ${error.toString()}');
      throw const Failure(message: 'Error in loading current user profile');
    }
  }
}
