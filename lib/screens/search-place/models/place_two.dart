import 'package:availnear/screens/search-place/models/geometry.dart';

class PlaceTwo {
  final Geometry geometry;
  final String name;
  final String vicinity;

  PlaceTwo(
      {required this.geometry, required this.name, required this.vicinity});

  factory PlaceTwo.fromJson(Map<String, dynamic> json) {
    return PlaceTwo(
      geometry: Geometry.fromJson(json['geometry']),
      name: json['formatted_address'],
      vicinity: json['vicinity'],
    );
  }
}
