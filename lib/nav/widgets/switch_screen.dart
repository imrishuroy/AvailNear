import '/repositories/nearby/nearby_repository.dart';
import '/screens/dashboard/bloc/dashboard_bloc.dart';
import '/screens/dashboard/dashboard.dart';
import '/screens/nearby/cubit/nearby_cubit.dart';
import '/screens/nearby/nearby_screen.dart';
import '/screens/dashboard/cubit/post_cubit.dart';
import '/cubits/cubit/liked_posts_cubit.dart';
import '/repositories/post/post_repository.dart';
import '/screens/create-post/cubit/create_post_cubit.dart';
import '/screens/create-post/create_post_screen.dart';
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
        return MultiBlocProvider(
          providers: [
            BlocProvider<PostCubit>(
              create: (_) => PostCubit(
                postRepository: context.read<PostRepository>(),
                likedPostsCubit: context.read<LikedPostsCubit>(),
                authBloc: context.read<AuthBloc>(),
              ),
            ),
            BlocProvider<DashBoardBloc>(
              create: (context) => DashBoardBloc(
                postCubit: context.read<PostCubit>(),
                authBloc: context.read<AuthBloc>(),
              ),
            )
          ],
          child: const FeedScreen(),
        );

      case NavItem.addPost:
        return BlocProvider<CreatePostCubit>(
          create: (context) => CreatePostCubit(
              authBloc: context.read<AuthBloc>(),
              postRepository: context.read<PostRepository>()),
          child: const CreatePost(),
        );

      case NavItem.nearby:
        return BlocProvider(
          create: (context) => NearbyCubit(
            nearbyRepository: context.read<NearbyRepository>(),
          )..fetchNearBy(),
          child: const NearByScreen(),
        );

      //  BlocProvider(
      //   create: (context) => WishlistBloc(
      //     postRepository: context.read<PostRepository>(),
      //     authBloc: context.read<AuthBloc>(),
      //     likedPostsCubit: context.read<LikedPostsCubit>(),
      //   )..add(LoadWishListPots()),
      //   child: const WishListPosts(),
      // );

      case NavItem.profile:
        return BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit(
              profileRepository: context.read<ProfileRepository>(),
              authBloc: context.read<AuthBloc>())
            ..loadCurrentUserProfile(),
          child: OwnerProfile(),
        );

      default:
        return const Center(
          child: Text('Wrong'),
        );
    }
  }
}
