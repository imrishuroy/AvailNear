part of 'dashboard_bloc.dart';

enum DashBoardStatus { initial, loading, succsss, error }

class DashBoardState extends Equatable {
  final DashBoardStatus? status;
  final Failure? failure;
  final String? currentAddress;

  const DashBoardState({
    required this.status,
    required this.failure,
    required this.currentAddress,
  });

  factory DashBoardState.initial() {
    return const DashBoardState(
      status: DashBoardStatus.initial,
      failure: Failure(),
      currentAddress: '',
    );
  }

  @override
  List<Object?> get props => [status, failure, currentAddress];

  DashBoardState copyWith({
    DashBoardStatus? status,
    Failure? failure,
    String? currentAddress,
  }) {
    return DashBoardState(
      status: status ?? this.status,
      failure: failure ?? this.failure,
      currentAddress: currentAddress ?? this.currentAddress,
    );
  }
}
