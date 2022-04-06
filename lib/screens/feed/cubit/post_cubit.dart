import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '/blocs/bloc/auth_bloc.dart';
import '/cubits/cubit/liked_posts_cubit.dart';
import '/enums/enums.dart';
import '/models/failure.dart';
import '/models/post.dart';
import '/repositories/post/post_repository.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  final PostRepository _postRepository;
  final LikedPostsCubit _likedPostsCubit;
  final AuthBloc _authBloc;

  PostCubit({
    required PostRepository postRepository,
    required LikedPostsCubit likedPostsCubit,
    required AuthBloc authBloc,
  })  : _postRepository = postRepository,
        _likedPostsCubit = likedPostsCubit,
        _authBloc = authBloc,
        super(PostState.initial());

  void loadOwnerPosts() async {
    emit(state.copyWith(posts: [], status: PostStatus.loading));
    try {
      List<Future<Post?>> futurePosts = [];
      _likedPostsCubit.clearAllLikedPosts();

      if (_authBloc.state.user?.userType == UserType.owner) {
        futurePosts = await _postRepository.getOwnerPosts(
            ownerId: _authBloc.state.user?.userId);
      } else if (_authBloc.state.user?.userType == UserType.renter) {
        futurePosts = await _postRepository.getRenterPosts();
      } else {
        emit(state.copyWith(posts: [], status: PostStatus.loaded));
      }
      final posts = await Future.wait(futurePosts);

      final likedPostIds = await _postRepository.getWishListPostIds(
        userId: _authBloc.state.user!.userId,
      );
      _likedPostsCubit.updateLikedPosts(postIds: likedPostIds);

      emit(state.copyWith(posts: posts, status: PostStatus.loaded));
    } catch (error) {
      print('Error getting feed posts  ${error.toString()}');
      emit(
        state.copyWith(
          failure: const Failure(message: 'We were unable to load your posts.'),
          status: PostStatus.error,
        ),
      );
    }
  }
}
