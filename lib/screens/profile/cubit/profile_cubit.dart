import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '/enums/user_type.dart';
import '/models/app_user.dart';
import '/repositories/profile/profile_repository.dart';
import '/blocs/bloc/auth_bloc.dart';
import '/models/failure.dart';
import '/utils/image_util.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _profileRepository;
  final AuthBloc _authBloc;

  ProfileCubit({
    required ProfileRepository profileRepository,
    required AuthBloc authBloc,
  })  : _profileRepository = profileRepository,
        _authBloc = authBloc,
        super(ProfileState.initial());

  void nameChanged(String value) {
    emit(state.copyWith(name: value, status: ProfileStatus.initial));
  }

  void addressChanged(String value) {
    emit(state.copyWith(address: value, status: ProfileStatus.initial));
  }

  void phoneChanged(String value) {
    emit(state.copyWith(phNo: value, status: ProfileStatus.initial));
  }

  void emailChanged(String value) {
    emit(state.copyWith(email: value, status: ProfileStatus.initial));
  }

  void imagePicked(Uint8List? image) {
    emit(state.copyWith(imageFile: image, status: ProfileStatus.initial));
  }

  void submitOwnerDetails() async {
    print('this runs 6');

    print('User name -- ${state.name}');
    print('User email -- ${state.email}');
    print('User address --- ${state.address}');
    print('User image file -- ${state.imageFile}');
    print('User status -- ${state.status}');

    if (!state.isFormValid || state.status == ProfileStatus.submitting) return;
    try {
      emit(state.copyWith(status: ProfileStatus.submitting));
      print('This runs 5');
      final String? downloadUrl = await ImageUtil.uploadProfileImageToStorage(
          'profileImages',
          state.imageFile!,
          false,
          _authBloc.state.user?.userId ?? '');
      // final doc = await _usersRef.doc(user.uid).get();

      final user = AppUser(
        userId: _authBloc.state.user?.userId,
        userType: UserType.owner,
        email: state.email,
        name: state.name,
        photoUrl: downloadUrl,
        phoneNo: state.phNo,
      );

      await _profileRepository.createUserProfile(user: user);
      emit(state.copyWith(status: ProfileStatus.succuss));
    } on Failure catch (err) {
      emit(state.copyWith(failure: err, status: ProfileStatus.error));
    } catch (error) {
      print('Error in submitting owner details');
    }
  }
}
