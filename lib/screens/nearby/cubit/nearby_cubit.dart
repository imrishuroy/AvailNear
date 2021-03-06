import 'package:availnear/constants/constants.dart';
import 'package:availnear/models/place_details.dart';
import 'package:availnear/utils/location_util.dart';

import '/models/failure.dart';
import '/models/place.dart';
import '/repositories/nearby/nearby_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'nearby_state.dart';

class NearbyCubit extends Cubit<NearbyState> {
  final NearbyRepository _nearbyRepository;
  NearbyCubit({required NearbyRepository nearbyRepository})
      : _nearbyRepository = nearbyRepository,
        super(NearbyState.initial());

  void fetchNearBy() async {
    try {
      emit(state.copyWith(status: NearbyStatus.loading));
      final location = await LocationUtil.getCurrentLocation();

      final places = await _nearbyRepository.getNearBy(
          category: state.nearbyCategory, location: location);
      emit(state.copyWith(places: places, status: NearbyStatus.succuss));
    } on Failure catch (failure) {
      emit(state.copyWith(failure: failure, status: NearbyStatus.error));
    }
  }

  void getSearchPlacesPhotos({required List<String?> photoRefs}) async {
    try {
      emit(state.copyWith(status: NearbyStatus.photosLoading));
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
          placePhotoUrls: photoUrls, status: NearbyStatus.succuss));
    } on Failure catch (failure) {
      emit(state.copyWith(failure: failure, status: NearbyStatus.error));
    }
  }

  void nearbyCategoryChanged(String? value) {
    if (value != null) {
      emit(state.copyWith(nearbyCategory: value, status: NearbyStatus.initial));
      fetchNearBy();
    }
  }

  void getPlaceDetails({required String? placeId}) async {
    try {
      emit(state.copyWith(status: NearbyStatus.loading));
      final details = await _nearbyRepository.getPlaceDetails(placeId: placeId);
      emit(state.copyWith(status: NearbyStatus.succuss, placeDetails: details));
    } on Failure catch (failure) {
      emit(state.copyWith(failure: failure, status: NearbyStatus.error));
    }
  }

  // void fetchNearBy() async {
  //   try {
  //     emit(state.copyWith(status: NearbyStatus.loading));
  //     final places = await _nearbyRepository.getNearBy();
  //     emit(state.copyWith(places: places, status: NearbyStatus.succuss));
  //   } on Failure catch (failure) {
  //     emit(state.copyWith(failure: failure, status: NearbyStatus.error));
  //   }
  // }
}
