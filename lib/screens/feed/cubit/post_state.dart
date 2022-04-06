part of 'post_cubit.dart';

enum PostStatus { initial, loading, loaded, paginating, error }

class PostState extends Equatable {
  final List<Post?>? posts;
  final PostStatus? status;
  final Failure? failure;

  const PostState({
    this.posts,
    this.status,
    this.failure,
  });

  factory PostState.initial() => const PostState(
      posts: [], status: PostStatus.initial, failure: Failure());

  @override
  List<Object?> get props => [posts, status, failure];

  PostState copyWith({
    List<Post?>? posts,
    PostStatus? status,
    Failure? failure,
  }) {
    return PostState(
      posts: posts ?? this.posts,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }

  @override
  String toString() =>
      'PostState(posts: $posts, status: $status, failure: $failure)';
}
