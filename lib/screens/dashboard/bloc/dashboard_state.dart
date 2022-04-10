part of 'dashboard_bloc.dart';

enum FeedStatus { initial, loading, succsss, error }

class DashBoardState extends Equatable {
  final FeedStatus? status;
  final Failure? failure;

  const DashBoardState({
    required this.status,
    required this.failure,
  });

  factory DashBoardState.initial() {
    return const DashBoardState(
      status: FeedStatus.initial,
      failure: Failure(),
    );
  }

  @override
  List<Object?> get props => [status, failure];

  DashBoardState copyWith({
    FeedStatus? status,
    Failure? failure,
  }) {
    return DashBoardState(
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
