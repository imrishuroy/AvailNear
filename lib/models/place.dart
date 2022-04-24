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
    };
  }

  factory Place.fromMap(Map<String, dynamic> map) {
    final location = map['geometry']['location'] as Map?;
    final photos = map['photos'] as List? ?? [];

    return Place(
      name: map['name'],
      photoRef: photos.isNotEmpty ? photos[0]['photo_reference'] : null,
      placeId: map['place_id'],
      rating: map['rating']?.toDouble(),
      address: map['vicinity'],
      types: map['types'] != null ? List<String?>.from(map['types']) : [],
      lat: location != null ? location['lat']?.toInt() : null,
      lng: location != null ? location['lng']?.toInt() : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Place.fromJson(String source) => Place.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Place(name: $name, photoRef: $photoRef, placeId: $placeId, rating: $rating, address: $address, types: $types, lat: $lat, lng: $lng, photoUrl: $photoUrl)';
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
    ];
  }
}
