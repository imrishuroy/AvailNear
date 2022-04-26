import 'package:availnear/models/place_details.dart';

import '/models/place.dart';
import 'package:location/location.dart';

abstract class BaseNearbyRepo {
  Future<List<Place?>> getNearBy({
    required String? category,
    required LocationData? location,
  });
  Future<String?> getPlacePhoto({required String? photoRef});
  Future placeAutoComplete({
    required String keyword,
    required LocationData? location,
  });
  Future<PlaceDetails?> getPlaceDetails({required String? placeId});
}
