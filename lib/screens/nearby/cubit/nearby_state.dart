part of 'nearby_cubit.dart';

enum NearbyStatus {
  initial,
  loading,
  succuss,
  error,
  photosLoading,
}

class NearbyState extends Equatable {
  final List<Place?> places;
  final NearbyStatus status;
  final Failure failure;
  final String nearbyCategory;
  final PlaceDetails? placeDetails;
  final List<String?> placePhotoUrls;

  const NearbyState(
      {required this.places,
      required this.status,
      required this.failure,
      required this.nearbyCategory,
      this.placeDetails,
      this.placePhotoUrls = const []});

  factory NearbyState.initial() => NearbyState(
        places: const [],
        status: NearbyStatus.initial,
        failure: const Failure(),
        nearbyCategory: nearbyCategatories[0],
        placeDetails: null,
        placePhotoUrls: const [],
      );

  NearbyState copyWith({
    List<Place?>? places,
    NearbyStatus? status,
    Failure? failure,
    String? nearbyCategory,
    List<String?>? placePhotoUrls,
    PlaceDetails? placeDetails,
  }) {
    return NearbyState(
      places: places ?? this.places,
      status: status ?? this.status,
      failure: failure ?? this.failure,
      nearbyCategory: nearbyCategory ?? this.nearbyCategory,
      placeDetails: placeDetails ?? this.placeDetails,
      placePhotoUrls: placePhotoUrls ?? this.placePhotoUrls,
    );
  }

  @override
  String toString() =>
      'NearbyState(places: $places, status: $status, failure: $failure: nearbyCategory :$nearbyCategory, placeDetails: $placeDetails, placePhotoUrls: $placePhotoUrls)';

  @override
  List<Object?> get props =>
      [places, status, failure, nearbyCategory, placeDetails, placePhotoUrls];
}
