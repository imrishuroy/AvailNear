import 'dart:convert';

import 'package:equatable/equatable.dart';

class PlaceDetails extends Equatable {
  final String? formatedAddress;
  final String? phNo;
  final double? lat;
  final double? long;
  final String? name;
  final String? palceId;
  final List<String?> photoRefs;
  final List<String?> photoUrls;
  final double? rating;

  const PlaceDetails({
    this.formatedAddress,
    this.phNo,
    this.lat,
    this.long,
    this.name,
    required this.palceId,
    this.photoRefs = const [],
    this.photoUrls = const [],
    this.rating,
  });

  PlaceDetails copyWith({
    String? formatedAddress,
    String? phNo,
    double? lat,
    double? long,
    String? name,
    String? palceId,
    List<String?>? photoRefs,
    List<String?>? photoUrls,
    double? rating,
  }) {
    return PlaceDetails(
      formatedAddress: formatedAddress ?? this.formatedAddress,
      phNo: phNo ?? this.phNo,
      lat: lat ?? this.lat,
      long: long ?? this.long,
      name: name ?? this.name,
      palceId: palceId ?? this.palceId,
      photoUrls: photoUrls ?? this.photoUrls,
      photoRefs: photoRefs ?? this.photoRefs,
      rating: rating ?? this.rating,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'formatedAddress': formatedAddress,
      'phNo': phNo,
      'lat': lat,
      'long': long,
      'name': name,
      'palceId': palceId,
    };
  }

  factory PlaceDetails.fromMap(Map<String, dynamic> map) {
    final geometry = map['geometry'] as Map?;
    final location = geometry != null ? geometry['location'] as Map? : null;
    final photos = map['photos'] as List? ?? [];
    List<String?> photoRefs = [];

    for (var item in photos) {
      final photoRef = item['photo_reference'] as String?;
      if (photoRef != null) {
        photoRefs.add(photoRef);
      }
    }

    return PlaceDetails(
      formatedAddress: map['formatted_address'],
      phNo: map['international_phone_number'],
      lat: location?['lat']?.toDouble(),
      long: location?['lng']?.toDouble(),
      name: map['name'],
      palceId: map['place_id'] ?? '',
      photoRefs: photoRefs,
      rating: map['rating']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory PlaceDetails.fromJson(String source) =>
      PlaceDetails.fromMap(json.decode(source));

  @override
  List<Object?> get props {
    return [
      formatedAddress,
      phNo,
      lat,
      long,
      name,
      palceId,
      rating,
    ];
  }

  @override
  String toString() {
    return 'PlaceDetails(formatedAddress: $formatedAddress, phNo: $phNo, lat: $lat, long: $long, name: $name, palceId: $palceId, photoRefs: $photoRefs, photoUrls: $photoUrls, rating: $rating)';
  }
}
