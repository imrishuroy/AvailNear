import 'dart:async';

import 'package:availnear/repositories/profile/profile_repository.dart';
import 'package:bloc/bloc.dart';
import '/repositories/auth/auth_repository.dart';
import '/models/app_user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  final ProfileRepository _profileRepository;
  late StreamSubscription<AppUser?> _userSubscription;

  AuthBloc({
    @required AuthRepository? authRepository,
    required ProfileRepository profileRepository,
  })  : _authRepository = authRepository!,
        _profileRepository = profileRepository,
        super(AuthState.unknown()) {
    _userSubscription = _authRepository.onAuthChanges.listen((user) async {
      final currentUser =
          await _profileRepository.loadUserProfile(userId: user?.userId);
      add(AuthUserChanged(user: currentUser));
    });
    on((event, emit) async {
      if (event is AuthUserChanged) {
        emit(event.user != null
            ? AuthState.authenticated(user: event.user)
            : AuthState.unAuthenticated());
      } else if (event is AuthLogoutRequested) {
        await _authRepository.signOut();
      }
    });
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
