part of 'wishlist_bloc.dart';

enum WishlistStatus { initial, loading, loaded, paginating, error }

class WishListState extends Equatable {
  final List<Post?>? posts;
  final WishlistStatus? status;
  final Failure? failure;

  const WishListState({
    required this.posts,
    required this.status,
    required this.failure,
  });

  factory WishListState.initial() {
    return const WishListState(
      posts: [],
      status: WishlistStatus.initial,
      failure: Failure(),
    );
  }

  @override
  List<Object?> get props => [posts, status, failure];

  WishListState copyWith({
    List<Post?>? posts,
    WishlistStatus? status,
    Failure? failure,
  }) {
    return WishListState(
      posts: posts ?? this.posts,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
