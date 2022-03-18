part of 'posts_cubit.dart';

enum PostsStatus { initial, loading, succuss, error }

class PostsState extends Equatable {
  final List<Post?> posts;
  final PostsStatus status;
  final Failure? failure;

  const PostsState({
    required this.posts,
    required this.status,
    this.failure,
  });

  factory PostsState.initial() => const PostsState(
      posts: [], status: PostsStatus.initial, failure: Failure());

  factory PostsState.loaded({required List<Post?> posts}) =>
      PostsState(posts: posts, status: PostsStatus.succuss);

  @override
  List<Object?> get props => [posts, status, failure];

  PostsState copyWith({
    List<Post?>? posts,
    PostsStatus? status,
    Failure? failure,
  }) {
    return PostsState(
      posts: posts ?? this.posts,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
