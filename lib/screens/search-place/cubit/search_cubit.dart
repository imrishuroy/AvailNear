import 'package:availnear/models/place_details.dart';

import '/models/failure.dart';
import '/models/searched_Item.dart';
import '/repositories/nearby/nearby_repository.dart';
import '/utils/location_util.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:location/location.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final NearbyRepository _nearbyRepository;
  SearchCubit({required NearbyRepository nearbyRepository})
      : _nearbyRepository = nearbyRepository,
        super(SearchState.initial());

  void searchItem({required String value}) async {
    try {
      if (state.locationData != null) {
        final results = await _nearbyRepository.placeAutoComplete(
            keyword: value, location: state.locationData);

        emit(state.copyWith(
            searchResults: results, status: SearchStatus.succuss));
      }
    } on Failure catch (failure) {
      emit(state.copyWith(failure: failure, status: SearchStatus.error));
    }
  }

  void clear() {
    getCurrentLocation();
    emit(state.copyWith(searchResults: []));
  }

  Future<void> selectSearchResult({required SearchedItem? item}) async {
    emit(state.copyWith(status: SearchStatus.searching));
    if (item != null) {
      print('check 1 - this runs');
      final details =
          await _nearbyRepository.getPlaceDetails(placeId: item.placeId);
      print('palce Detials - $details');

      emit(
        state.copyWith(
          initialText: item.mainText,
          searchResults: [],
          lat: details?.lat,
          long: details?.long,
          placeDetails: details,
          status: SearchStatus.succuss,
        ),
      );
    }
  }

  void getSearchPlacesPhotos({required List<String?> photoRefs}) async {
    try {
      emit(state.copyWith(status: SearchStatus.loading));
      List<String> photoUrls = [];
      for (var item in photoRefs) {
        if (item != null) {
          final photoUrl =
              await _nearbyRepository.getPlacePhoto(photoRef: item);
          if (photoUrl != null) {
            photoUrls.add(photoUrl);
          }
        }
      }
      emit(state.copyWith(
          searchedPlacePhotos: photoUrls, status: SearchStatus.succuss));
    } on Failure catch (failure) {
      emit(state.copyWith(failure: failure, status: SearchStatus.error));
    }
  }

  void getCurrentLocation() async {
    try {
      emit(state.copyWith(status: SearchStatus.searching));
      final locationData = await LocationUtil.getCurrentLocation();
      final address = await LocationUtil.getCurrentAddress();
      // final details =
      //     await _nearbyRepository.getPlaceDetails(placeId: item.placeId);

      final placeDetails = PlaceDetails(
        palceId: 'aaaa',
        formatedAddress: address,
        lat: locationData?.latitude,
        long: locationData?.longitude,
      );

      emit(
        state.copyWith(
          locationData: locationData,
          lat: locationData?.latitude,
          long: locationData?.longitude,
          placeDetails: placeDetails,
          status: SearchStatus.succuss,
        ),
      );
    } on Failure catch (failure) {
      emit(state.copyWith(failure: failure, status: SearchStatus.error));
    }
  }
}
