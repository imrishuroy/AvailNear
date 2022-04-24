import '/models/failure.dart';
import '/models/place.dart';
import '/repositories/nearby/base_nearby_repo.dart';
import 'package:dio/dio.dart';

class NearbyRepository extends BaseNearbyRepo {
  final _dio = Dio();

  Future<List<Place?>> getNearBy({required String? category}) async {
    final List<Place?> places = [];
    try {
      final params = {
        'location': '23.2465,77.5018',
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
}
