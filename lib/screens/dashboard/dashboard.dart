import '/screens/dashboard/cubit/owner_posts_cubit.dart';
import '/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<OwnerPostsCubit, OwnerPostsState>(
      listener: (context, state) {},

      // future: _postRepo.getOwnerPosts(
      // ownerId: context.read<AuthBloc>().state.user?.userId),
      builder: (context, state) {
        if (state.status == OwnerPostsStatus.loading) {
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
    )

        //  Center(
        //   child: Text(
        //     'Home Screen',
        //     style: TextStyle(color: Colors.white),
        //   ),
        // ),
        );
  }
}
