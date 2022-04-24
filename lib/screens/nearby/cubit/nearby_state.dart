part of 'nearby_cubit.dart';

enum NearbyStatus {
  initial,
  loading,
  succuss,
  error,
}

class NearbyState extends Equatable {
  final List<Place?> places;
  final NearbyStatus status;
  final Failure failure;

  const NearbyState({
    required this.places,
    required this.status,
    required this.failure,
  });

  factory NearbyState.initial() => const NearbyState(
        places: [],
        status: NearbyStatus.initial,
        failure: Failure(),
      );

  NearbyState copyWith({
    List<Place?>? places,
    NearbyStatus? status,
    Failure? failure,
  }) {
    return NearbyState(
      places: places ?? this.places,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }

  @override
  String toString() =>
      'NearbyState(places: $places, status: $status, failure: $failure)';

  @override
  List<Object> get props => [places, status, failure];
}
