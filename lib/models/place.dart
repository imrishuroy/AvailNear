import 'dart:convert';

import 'package:equatable/equatable.dart';

class Place extends Equatable {
  final String? name;
  final String? photoRef;
  final String? placeId;
  final double? rating;
  final String? address;
  final List<String?> types;
  final int? lat;
  final int? lng;
  final String? photoUrl;
  final bool? isOpen;
  final int? rattingCount;

  const Place({
    this.name,
    this.photoRef,
    this.placeId,
    this.rating,
    this.address,
    required this.types,
    this.lat,
    this.lng,
    this.photoUrl,
    this.isOpen,
    this.rattingCount,
  });

  Place copyWith({
    String? name,
    String? photoRef,
    String? placeId,
    double? rating,
    String? address,
    List<String?>? types,
    int? lat,
    int? lng,
    String? photoUrl,
    bool? isOpen,
    int? rattingCount,
  }) {
    return Place(
      name: name ?? this.name,
      photoRef: photoRef ?? this.photoRef,
      placeId: placeId ?? this.placeId,
      rating: rating ?? this.rating,
      address: address ?? this.address,
      types: types ?? this.types,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      photoUrl: photoUrl ?? this.photoUrl,
      isOpen: isOpen ?? this.isOpen,
      rattingCount: rattingCount ?? this.rattingCount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'photoRef': photoRef,
      'placeId': placeId,
      'rating': rating,
      'address': address,
      'types': types,
      'lat': lat,
      'lng': lng,
      'photoUrl': photoUrl,
      'isOpen': isOpen,
    };
  }

  factory Place.fromMap(Map<String, dynamic> map) {
    final location = map['geometry']['location'] as Map?;
    final photos = map['photos'] as List? ?? [];

    final openingHrs = map['opening_hours'] as Map?;

    final openNow = openingHrs?['open_now'] as bool?;

    // print('is open ${map['opening_hours']['open_now']}');

    return Place(
      name: map['name'],
      photoRef: photos.isNotEmpty ? photos[0]['photo_reference'] : null,
      placeId: map['place_id'],
      rating: map['rating']?.toDouble(),
      address: map['vicinity'],
      types: map['types'] != null ? List<String?>.from(map['types']) : [],
      lat: location != null ? location['lat']?.toInt() : null,
      lng: location != null ? location['lng']?.toInt() : null,
      isOpen: openNow,
      rattingCount: map['user_ratings_total'],
      // isOpen: openingHrs != null ? openingHrs['open_now'] : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Place.fromJson(String source) => Place.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Place(name: $name, photoRef: $photoRef, placeId: $placeId, rating: $rating, address: $address, types: $types, lat: $lat, lng: $lng, photoUrl: $photoUrl isOpen: $isOpen)';
  }

  @override
  List<Object?> get props {
    return [
      name,
      photoRef,
      placeId,
      rating,
      address,
      types,
      lat,
      lng,
      photoUrl,
      isOpen,
    ];
  }
}
