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
    emit(state.copyWith(searchResults: []));
  }

  void selectSearchResult({required SearchedItem? item}) async {
    if (item != null) {
      //searchItem(value: text);
      //emit(state.copyWith());
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
        ),
      );
    }

    //emit(state.copyWith(initialText: text));
  }

  void getCurrentLocation() async {
    try {
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
        ),
      );
    } on Failure catch (failure) {
      emit(state.copyWith(failure: failure, status: SearchStatus.error));
    }
  }
}
