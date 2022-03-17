import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finding_home/config/paths.dart';
import 'package:finding_home/models/app_user.dart';
import 'package:finding_home/repositories/profile/base_profile_repo.dart';

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
}
