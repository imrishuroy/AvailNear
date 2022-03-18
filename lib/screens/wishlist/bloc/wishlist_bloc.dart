import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '/blocs/bloc/auth_bloc.dart';
import '/cubits/cubit/liked_posts_cubit.dart';
import '/repositories/post/post_repository.dart';
import '/models/failure.dart';
import '/models/post.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishListState> {
  final PostRepository _postRepository;
  final AuthBloc _authBloc;
  final LikedPostsCubit _likedPostsCubit;

  WishlistBloc({
    required PostRepository postRepository,
    required AuthBloc authBloc,
    required LikedPostsCubit likedPostsCubit,
  })  : _postRepository = postRepository,
        _authBloc = authBloc,
        _likedPostsCubit = likedPostsCubit,
        super(WishListState.initial()) {
    on<WishlistEvent>((event, emit) async {
      if (event is LoadWishListPots) {
        emit(state.copyWith(posts: [], status: WishlistStatus.loading));
        try {
          List<Future<Post?>> futurePosts = [];
          _likedPostsCubit.clearAllLikedPosts();

          futurePosts = await _postRepository.getWishListPosts(
              userId: _authBloc.state.user?.userId);

          final posts = await Future.wait(futurePosts);

          final likedPostIds = await _postRepository.getWishListPostIds(
            userId: _authBloc.state.user?.userId,
          );
          _likedPostsCubit.updateLikedPosts(postIds: likedPostIds);

          emit(state.copyWith(posts: posts, status: WishlistStatus.loaded));
        } catch (error) {
          print('Error getting feed posts  ${error.toString()}');
          emit(
            state.copyWith(
              failure:
                  const Failure(message: 'We were unable to load your feed.'),
              status: WishlistStatus.error,
            ),
          );
        }
      }
    });
  }
}
