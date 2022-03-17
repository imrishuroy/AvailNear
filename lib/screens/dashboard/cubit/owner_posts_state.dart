part of 'owner_posts_cubit.dart';

enum OwnerPostsStatus { initial, loading, succuss, error }

class OwnerPostsState extends Equatable {
  final List<Post?> posts;
  final OwnerPostsStatus status;
  final Failure? failure;

  const OwnerPostsState({
    required this.posts,
    required this.status,
    this.failure,
  });

  factory OwnerPostsState.initial() => const OwnerPostsState(
      posts: [], status: OwnerPostsStatus.initial, failure: Failure());

  factory OwnerPostsState.loaded({required List<Post?> posts}) =>
      OwnerPostsState(posts: posts, status: OwnerPostsStatus.succuss);

  @override
  List<Object?> get props => [posts, status, failure];

  OwnerPostsState copyWith({
    List<Post?>? posts,
    OwnerPostsStatus? status,
    Failure? failure,
  }) {
    return OwnerPostsState(
      posts: posts ?? this.posts,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
