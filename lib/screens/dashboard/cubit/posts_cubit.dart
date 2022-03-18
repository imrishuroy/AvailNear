import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:finding_home/enums/user_type.dart';
import '/blocs/bloc/auth_bloc.dart';
import '/models/failure.dart';
import '/models/post.dart';
import '/repositories/post/post_repository.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  final PostRepository _postRepository;
  final AuthBloc _authBloc;

  PostsCubit(
      {required PostRepository postRepository, required AuthBloc authBloc})
      : _authBloc = authBloc,
        _postRepository = postRepository,
        super(PostsState.initial());

  void loadOwnerPosts() async {
    try {
      emit(state.copyWith(status: PostsStatus.loading));

      List<Future<Post?>> futurePosts = [];

      if (_authBloc.state.user?.userType == UserType.owner) {
        futurePosts = await _postRepository.getOwnerPosts(
            ownerId: _authBloc.state.user?.userId);
      } else if (_authBloc.state.user?.userType == UserType.renter) {
        futurePosts = await _postRepository.getRenterPosts();
      } else {
        emit(PostsState.loaded(posts: const []));
      }
      final posts = await Future.wait(futurePosts);
      emit(PostsState.loaded(posts: posts));
    } on Failure catch (error) {
      print('Error getting posts');
      emit(state.copyWith(
          failure: Failure(message: error.message), status: PostsStatus.error));
    }
  }
}
