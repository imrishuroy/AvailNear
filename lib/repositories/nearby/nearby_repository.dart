import 'package:availnear/models/place_details.dart';

import '/models/searched_Item.dart';
import 'package:location/location.dart';

import '/models/failure.dart';
import '/models/place.dart';
import '/repositories/nearby/base_nearby_repo.dart';
import 'package:dio/dio.dart';

class NearbyRepository extends BaseNearbyRepo {
  final _dio = Dio();

  Future<List<Place?>> getNearBy({
    required String? category,
    required LocationData? location,
  }) async {
    final List<Place?> places = [];
    try {
      if (category == null || location == null) {
        return [];
      }

      final params = {
        'location': '${location.latitude},${location.longitude}',
        // 'radius': '1500',
        'radius': '2000',
        'type': category,
        'key': 'AIzaSyCMbk9Bug3L7-HFZ6WEBhILQDsxpZDsGwA'
      };
      final response = await _dio.get(
          'https://maps.googleapis.com/maps/api/place/nearbysearch/json',
          queryParameters: params);

      final resData = response.data['results'] as List?;
      final lenght = resData?.length ?? 0;

      for (int i = 0; i < lenght; i++) {
        final place = Place.fromMap(resData?[i]);
        print('Place --- $place');

        // final photoUrl = await getPlacePhoto(photoRef: place.photoRef);

        // print('neee $photoUrl');

        // places.add(place.copyWith(photoUrl: photoUrl));
        if (place.photoRef != null) {
          places.add(place);
        }
      }
      print('Response $response');
      print('Response ${resData.runtimeType}');
      print('Response ${response.statusCode}');
      return places;
    } catch (error) {
      print('Error getting nearby ${error.toString()}');
      throw const Failure(message: 'Error getting nearby');
    }
  }

  Future<String?> getPlacePhoto({required String? photoRef}) async {
    try {
      if (photoRef == null) {
        return null;
      }
      final params = {
        'maxwidth': '400',
        'photo_reference': photoRef,
        'key': 'AIzaSyCMbk9Bug3L7-HFZ6WEBhILQDsxpZDsGwA'
      };
      final response = await _dio.get(
          'https://maps.googleapis.com/maps/api/place/photo',
          queryParameters: params);
      //print('Photo Response ${response.data.runtimeType}');

      // print('kkkk ${response.realUri.toString()}');

      // https://lh3.googleusercontent.com/places/AAcXr8pkvLto8cSPGG8EpsUbpoHZ7u8Uqj95OIXKdEFH9mHGoqvV9X9IEVt0wVO-YJoMEfOJ8VhmUkqD34s_tzaM8z2otJDcxNPLM00=s1600-w400

      return response.realUri.toString();
    } catch (error) {
      print('Error in getting place photo');
      throw const Failure(message: 'Error in getting image');
    }
  }

  Future placeAutoComplete({
    required String keyword,
    required LocationData? location,
  }) async {
    try {
      List<SearchedItem?> items = [];
      if (location == null) {
        return;
      }

      final params = {
        'input': keyword,
        'location': '${location.latitude},${location.longitude}',
        'radius': '2000',
        'key': 'AIzaSyCMbk9Bug3L7-HFZ6WEBhILQDsxpZDsGwA'
      };

      final response = await _dio.get(
          'https://maps.googleapis.com/maps/api/place/autocomplete/json',
          queryParameters: params);

      if (response.statusCode == 200) {
        final predections = response.data['predictions'] as List? ?? [];
        for (var element in predections) {
          items.add(SearchedItem.fromMap(element));
        }
      }
      return items;
    } catch (error) {
      print('Error in place autocomplete');
      throw const Failure(message: 'Error in place autocomplete ');
    }
  }

  Future<PlaceDetails?> getPlaceDetails({required String? placeId}) async {
    try {
      if (placeId == null) {
        return null;
      }
      final params = {
        'place_id': placeId,
        'key': 'AIzaSyCMbk9Bug3L7-HFZ6WEBhILQDsxpZDsGwA'
      };
      final response = await _dio.get(
          'https://maps.googleapis.com/maps/api/place/details/json',
          queryParameters: params);

      if (response.statusCode == 200) {
        final result = response.data['result'];
        if (result != null) {
          return PlaceDetails.fromMap(result);
          // print(
          //     'geometyr ${result['geometry']['location']['lat'].runtimeType}');
        }
      }
      return null;
    } catch (error) {
      print('Error getting place details ${error.toString()}');
      throw const Failure(message: 'Error getting place details');
    }
  }
}
