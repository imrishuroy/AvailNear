import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '/blocs/bloc/auth_bloc.dart';
import '/models/post.dart';
import '/repositories/post/post_repository.dart';

part 'liked_posts_state.dart';

class LikedPostsCubit extends Cubit<LikedPostsState> {
  final PostRepository _postRepository;
  final AuthBloc _authBloc;

  LikedPostsCubit({
    required AuthBloc authBloc,
    required PostRepository postRepository,
  })  : _postRepository = postRepository,
        _authBloc = authBloc,
        super(LikedPostsState.initial());

  void updateLikedPosts({required Set<String> postIds}) {
    emit(
      state.copyWith(
        likedPostIds: Set<String>.from(state.likedPostIds)..addAll(postIds),
      ),
    );
  }

  void likePost({required Post? post}) {
    if (post?.postId != null) {
      _postRepository.wishlistPost(
        postId: post?.postId,
        postOwnerId: post?.owner?.userId,
        user: _authBloc.state.user,
      );
      emit(
        state.copyWith(
          likedPostIds: Set<String>.from(state.likedPostIds)
            ..add(post!.postId!),
          recentlyLikedPostIds: Set<String>.from(state.recentlyLikedPostIds)
            ..add(post.postId!),
        ),
      );
    }
  }

  void unlikePost({required Post post}) {
    _postRepository.deletedWishlist(
      postId: post.postId,
      userId: _authBloc.state.user?.userId,
    );

    emit(
      state.copyWith(
        likedPostIds: Set<String>.from(state.likedPostIds)..remove(post.postId),
        recentlyLikedPostIds: Set<String>.from(state.recentlyLikedPostIds)
          ..remove(post.postId),
      ),
    );
  }

  void clearAllLikedPosts() {
    emit(LikedPostsState.initial());
  }
}
