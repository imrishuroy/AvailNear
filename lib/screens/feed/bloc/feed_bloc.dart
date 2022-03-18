import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '/enums/user_type.dart';
import '/blocs/bloc/auth_bloc.dart';
import '/repositories/post/post_repository.dart';
import '/cubits/cubit/liked_posts_cubit.dart';
import '/models/failure.dart';
import '/models/post.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final PostRepository _postRepository;
  final AuthBloc _authBloc;
  final LikedPostsCubit _likedPostsCubit;

  FeedBloc({
    required PostRepository postRepository,
    required AuthBloc authBloc,
    required LikedPostsCubit likedPostsCubit,
  })  : _postRepository = postRepository,
        _authBloc = authBloc,
        _likedPostsCubit = likedPostsCubit,
        super(FeedState.initial()) {
    on((event, emit) async {
      if (event is FeedFetchPosts) {
        emit(state.copyWith(posts: [], status: FeedStatus.loading));
        try {
          List<Future<Post?>> futurePosts = [];
          _likedPostsCubit.clearAllLikedPosts();

          if (_authBloc.state.user?.userType == UserType.owner) {
            futurePosts = await _postRepository.getOwnerPosts(
                ownerId: _authBloc.state.user?.userId);
          } else if (_authBloc.state.user?.userType == UserType.renter) {
            futurePosts = await _postRepository.getRenterPosts();
          } else {
            emit(state.copyWith(posts: [], status: FeedStatus.loaded));
          }
          final posts = await Future.wait(futurePosts);

          final likedPostIds = await _postRepository.getWishListPostIds(
            userId: _authBloc.state.user!.userId,
          );
          _likedPostsCubit.updateLikedPosts(postIds: likedPostIds);

          emit(state.copyWith(posts: posts, status: FeedStatus.loaded));
        } catch (error) {
          print('Error getting feed posts  ${error.toString()}');
          emit(
            state.copyWith(
              failure:
                  const Failure(message: 'We were unable to load your feed.'),
              status: FeedStatus.error,
            ),
          );
        }
      } else if (event is FeedPaginatePosts) {}
    });
  }
}
