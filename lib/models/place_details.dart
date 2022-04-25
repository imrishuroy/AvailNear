import 'dart:convert';

import 'package:equatable/equatable.dart';

class PlaceDetails extends Equatable {
  final String? formatedAddress;
  final String? phNo;
  final double? lat;
  final double? long;
  final String? name;
  final String palceId;

  const PlaceDetails({
    this.formatedAddress,
    this.phNo,
    this.lat,
    this.long,
    this.name,
    required this.palceId,
  });

  PlaceDetails copyWith({
    String? formatedAddress,
    String? phNo,
    double? lat,
    double? long,
    String? name,
    String? palceId,
  }) {
    return PlaceDetails(
      formatedAddress: formatedAddress ?? this.formatedAddress,
      phNo: phNo ?? this.phNo,
      lat: lat ?? this.lat,
      long: long ?? this.long,
      name: name ?? this.name,
      palceId: palceId ?? this.palceId,
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

    return PlaceDetails(
      formatedAddress: map['formatted_address'],
      phNo: map['international_phone_number'],
      lat: location?['lat']?.toDouble(),
      long: location?['lat']?.toDouble(),
      name: map['name'],
      palceId: map['place_id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PlaceDetails.fromJson(String source) =>
      PlaceDetails.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PlaceDetails(formatedAddress: $formatedAddress, phNo: $phNo, lat: $lat, long: $long, name: $name, palceId: $palceId)';
  }

  @override
  List<Object?> get props {
    return [
      formatedAddress,
      phNo,
      lat,
      long,
      name,
      palceId,
    ];
  }
}
