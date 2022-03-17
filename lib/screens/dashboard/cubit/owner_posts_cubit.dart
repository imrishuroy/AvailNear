import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '/blocs/bloc/auth_bloc.dart';
import '/models/failure.dart';
import '/models/post.dart';
import '/repositories/post/post_repository.dart';

part 'owner_posts_state.dart';

class OwnerPostsCubit extends Cubit<OwnerPostsState> {
  final PostRepository _postRepository;
  final AuthBloc _authBloc;
  OwnerPostsCubit(
      {required PostRepository postRepository, required AuthBloc authBloc})
      : _authBloc = authBloc,
        _postRepository = postRepository,
        super(OwnerPostsState.initial());

  void loadOwnerPosts() async {
    try {
      emit(state.copyWith(status: OwnerPostsStatus.loading));
      final futurePosts = await _postRepository.getOwnerPosts(
          ownerId: _authBloc.state.user?.userId);
      final posts = await Future.wait(futurePosts);
      emit(OwnerPostsState.loaded(posts: posts));
    } on Failure catch (error) {
      print('Error getting posts');
      emit(state.copyWith(
          failure: Failure(message: error.message),
          status: OwnerPostsStatus.error));
    }
  }
}
