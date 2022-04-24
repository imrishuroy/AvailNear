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
  final String nearbyCategory;

  const NearbyState({
    required this.places,
    required this.status,
    required this.failure,
    required this.nearbyCategory,
  });

  factory NearbyState.initial() => NearbyState(
      places: const [],
      status: NearbyStatus.initial,
      failure: const Failure(),
      nearbyCategory: nearbyCategatories[0]);

  NearbyState copyWith({
    List<Place?>? places,
    NearbyStatus? status,
    Failure? failure,
    String? nearbyCategory,
  }) {
    return NearbyState(
      places: places ?? this.places,
      status: status ?? this.status,
      failure: failure ?? this.failure,
      nearbyCategory: nearbyCategory ?? this.nearbyCategory,
    );
  }

  @override
  String toString() =>
      'NearbyState(places: $places, status: $status, failure: $failure: nearbyCategory :$nearbyCategory)';

  @override
  List<Object> get props => [places, status, failure, nearbyCategory];
}
