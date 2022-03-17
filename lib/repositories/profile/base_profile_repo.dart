import '/models/app_user.dart';

abstract class BaseProfileRepository {
  Future<void> createUserProfile({required AppUser? user});
}
