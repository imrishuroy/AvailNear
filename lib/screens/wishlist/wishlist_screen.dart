import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '/screens/dashboard/widgets/one_posts_card.dart';
import '/cubits/cubit/liked_posts_cubit.dart';
import '/screens/wishlist/bloc/wishlist_bloc.dart';
import '/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text(
            'Your Wishlist',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: BlocConsumer<WishlistBloc, WishListState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state.status == WishlistStatus.loading) {
              return const LoadingIndicator();
            }

            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 15.0,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: AnimationLimiter(
                        child: ListView.builder(
                          itemCount: state.posts?.length,
                          itemBuilder: (context, index) {
                            final post = state.posts?[index];
                            final likedPostsState =
                                context.watch<LikedPostsCubit>().state;
                            final isLiked = likedPostsState.likedPostIds
                                .contains(post?.postId);

                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 375),
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: OnePostCard(
                                    post: state.posts?[index],
                                    isWishlisted: isLiked,
                                    onTap: () {
                                      if (isLiked) {
                                        context
                                            .read<LikedPostsCubit>()
                                            .unlikePost(post: post!);
                                      } else {
                                        context
                                            .read<LikedPostsCubit>()
                                            .likePost(post: post);
                                      }
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
}
