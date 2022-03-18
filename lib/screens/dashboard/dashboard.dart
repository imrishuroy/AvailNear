import 'package:finding_home/blocs/bloc/auth_bloc.dart';

import '/config/shared_prefs.dart';
import 'cubit/posts_cubit.dart';
import '/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _authBloc = context.read<AuthBloc>();
    print('User type -- ${SharedPrefs().getUserType}');
    print('Appuser type -- ${_authBloc.state.user?.userType}');
    return Scaffold(
      body: BlocConsumer<PostsCubit, PostsState>(
        listener: (context, state) {},

        // future: _postRepo.getOwnerPosts(
        // ownerId: context.read<AuthBloc>().state.user?.userId),
        builder: (context, state) {
          if (state.status == PostsStatus.loading) {
            return const LoadingIndicator();
          }
          return ListView.builder(
            itemCount: state.posts.length,
            itemBuilder: (context, index) {
              final post = state.posts[index];
              return ListTile(
                title: Text(
                  post?.title ?? '',
                  style: const TextStyle(color: Colors.black),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
