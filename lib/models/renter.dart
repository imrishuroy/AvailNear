import 'dart:convert';

import 'package:equatable/equatable.dart';

class Renter extends Equatable {
  final String? renterId;
  final String? renterName;
  final String? renterProfilePic;
  final String? renterPhNo;
  final String? renterEmail;

  const Renter({
    this.renterId,
    this.renterName,
    this.renterProfilePic,
    this.renterPhNo,
    this.renterEmail,
  });

  Renter copyWith({
    String? renterId,
    String? renterName,
    String? renterProfilePic,
    String? renterPhNo,
    String? renterEmail,
  }) {
    return Renter(
      renterId: renterId ?? this.renterId,
      renterName: renterName ?? this.renterName,
      renterProfilePic: renterProfilePic ?? this.renterProfilePic,
      renterPhNo: renterPhNo ?? this.renterPhNo,
      renterEmail: renterEmail ?? this.renterEmail,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'renterId': renterId,
      'renterName': renterName,
      'renterProfilePic': renterProfilePic,
      'renterPhNo': renterPhNo,
      'renterEmail': renterEmail,
    };
  }

  factory Renter.fromMap(Map<String, dynamic> map) {
    return Renter(
      renterId: map['renterId'],
      renterName: map['renterName'],
      renterProfilePic: map['renterProfilePic'],
      renterPhNo: map['renterPhNo'],
      renterEmail: map['renterEmail'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Renter.fromJson(String source) => Renter.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Renter(renterId: $renterId, renterName: $renterName, renterProfilePic: $renterProfilePic, renterPhNo: $renterPhNo, renterEmail: $renterEmail)';
  }

  @override
  List<Object?> get props {
    return [
      renterId,
      renterName,
      renterProfilePic,
      renterPhNo,
      renterEmail,
    ];
  }
}
