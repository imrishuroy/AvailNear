import 'package:finding_home/screens/dashboard/cubit/posts_cubit.dart';
import 'package:finding_home/screens/dashboard/home_screen.dart';

import '/repositories/post/post_repository.dart';
import '/screens/create-post/cubit/create_post_cubit.dart';
import '../../screens/create-post/create_post_screen.dart';
import '/blocs/bloc/auth_bloc.dart';
import '/repositories/profile/profile_repository.dart';
import '/screens/profile/cubit/profile_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/screens/profile/owner/owner_profile.dart';
import 'package:flutter/material.dart';

import '/enums/nav_item.dart';

class SwitchScreen extends StatelessWidget {
  final NavItem navItem;

  const SwitchScreen({Key? key, required this.navItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (navItem) {
      case NavItem.dashboard:
        return BlocProvider(
          create: (context) => PostsCubit(
            postRepository: context.read<PostRepository>(),
            authBloc: context.read<AuthBloc>(),
          )..loadOwnerPosts(),
          child: const HomeScreen(),
        );

      case NavItem.nearby:
        return BlocProvider<CreatePostCubit>(
          create: (context) => CreatePostCubit(
              authBloc: context.read<AuthBloc>(),
              postRepository: context.read<PostRepository>()),
          child: const CreatePost(),
        );
      // return const GirlTable();

      case NavItem.search:
        return BlocProvider<CreatePostCubit>(
          create: (context) => CreatePostCubit(
              authBloc: context.read<AuthBloc>(),
              postRepository: context.read<PostRepository>()),
          child: const CreatePost(),
        );

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
