part of 'feed_bloc.dart';

enum FeedStatus { initial, loading, succsss, error }

class FeedState extends Equatable {
  final FeedStatus? status;
  final Failure? failure;

  const FeedState({
    required this.status,
    required this.failure,
  });

  factory FeedState.initial() {
    return const FeedState(
      status: FeedStatus.initial,
      failure: Failure(),
    );
  }

  @override
  List<Object?> get props => [status, failure];

  FeedState copyWith({
    FeedStatus? status,
    Failure? failure,
  }) {
    return FeedState(
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
