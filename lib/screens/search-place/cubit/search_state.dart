part of 'search_cubit.dart';

enum SearchStatus { initial, loading, error, succuss, searching }

class SearchState extends Equatable {
  final LocationData? locationData;
  final String? initialText;
  final Failure failure;
  final SearchStatus status;
  final List<SearchedDetails?> searchResults;
  final double? lat;
  final double? long;
  final PlaceDetails? placeDetails;
  final List<String?> searchedPlacePhotos;

  const SearchState({
    this.locationData,
    required this.initialText,
    required this.failure,
    required this.status,
    this.searchResults = const [],
    this.lat,
    this.long,
    this.placeDetails,
    this.searchedPlacePhotos = const [],
  });

  factory SearchState.initial() => const SearchState(
        initialText: null,
        failure: Failure(),
        locationData: null,
        status: SearchStatus.initial,
        searchResults: [],
        lat: null,
        long: null,
        placeDetails: null,
        searchedPlacePhotos: [],
      );

  @override
  List<Object?> get props => [
        locationData,
        initialText,
        failure,
        status,
        searchResults,
        lat,
        long,
        placeDetails,
        searchedPlacePhotos,
      ];

  SearchState copyWith({
    LocationData? locationData,
    String? initialText,
    Failure? failure,
    SearchStatus? status,
    List<SearchedDetails?>? searchResults,
    double? lat,
    double? long,
    PlaceDetails? placeDetails,
    List<String?>? searchedPlacePhotos,
  }) {
    return SearchState(
      locationData: locationData ?? this.locationData,
      initialText: initialText ?? this.initialText,
      failure: failure ?? this.failure,
      status: status ?? this.status,
      searchResults: searchResults ?? this.searchResults,
      lat: lat ?? this.lat,
      long: long ?? this.long,
      placeDetails: placeDetails ?? this.placeDetails,
      searchedPlacePhotos: searchedPlacePhotos ?? this.searchedPlacePhotos,
    );
  }

  @override
  String toString() {
    return 'SearchState(locationData: $locationData, initialText: $initialText, failure: $failure, status: $status searchResults: $searchResults, lat: $lat, long: $long, placeDetails : $placeDetails , searchedPlacePhotos: $searchedPlacePhotos)';
  }
}
