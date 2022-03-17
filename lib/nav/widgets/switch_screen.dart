import '/blocs/bloc/auth_bloc.dart';

import '/repositories/profile/profile_repository.dart';
import '/screens/profile/cubit/profile_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/screens/profile/owner/owner_profile.dart';
import 'package:flutter/material.dart';
import '/screens/dashboard/dashboard.dart';
import '/screens/girl-table/girl_table.dart';
import '/screens/mentor-connect/mentor_connect.dart';

import '/enums/nav_item.dart';

class SwitchScreen extends StatelessWidget {
  final NavItem navItem;

  const SwitchScreen({Key? key, required this.navItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (navItem) {
      case NavItem.dashboard:
        return const DashBoard();

      case NavItem.nearby:
        return const GirlTable();

      case NavItem.search:
        return const MentorConnect();

      case NavItem.profile:
        return BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit(
              profileRepository: context.read<ProfileRepository>(),
              authBloc: context.read<AuthBloc>()),
          child: OwnerProfile(),
        );

      default:
        return const Center(
          child: Text('Wrong'),
        );
    }
  }
}
