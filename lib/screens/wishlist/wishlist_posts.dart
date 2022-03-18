import '/cubits/cubit/liked_posts_cubit.dart';

import '/screens/feed/widgets/one_posts_card.dart';
import '/screens/wishlist/bloc/wishlist_bloc.dart';
import '/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishListPosts extends StatelessWidget {
  const WishListPosts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<WishlistBloc, WishListState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.status == WishlistStatus.loading) {
          return const LoadingIndicator();
        }

        return SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.posts?.length,
                  itemBuilder: (context, index) {
                    final post = state.posts?[index];
                    final likedPostsState =
                        context.watch<LikedPostsCubit>().state;
                    final isLiked =
                        likedPostsState.likedPostIds.contains(post?.postId);

                    return OnePostCard(
                      post: state.posts?[index],
                      isWishlisted: isLiked,
                      onTap: () {
                        if (isLiked) {
                          context
                              .read<LikedPostsCubit>()
                              .unlikePost(post: post!);
                        } else {
                          context.read<LikedPostsCubit>().likePost(post: post);
                        }
                      },
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    ));
  }
}
