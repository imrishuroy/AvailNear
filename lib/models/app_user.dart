import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:equatable/equatable.dart';
import '/enums/user_type.dart';

class AppUser extends Equatable {
  final String? userId;
  final String? photoUrl;
  final String? name;
  final String? phoneNo;
  final String? email;
  final String? address;
  final UserType userType;

  const AppUser({
    this.userId,
    this.photoUrl,
    this.name,
    this.phoneNo,
    this.email,
    this.address,
    this.userType = UserType.unknown,
  });

  AppUser copyWith({
    String? userId,
    String? photoUrl,
    String? name,
    String? phoneNo,
    String? email,
    UserType? userType,
    String? address,
  }) {
    return AppUser(
      userId: userId ?? this.userId,
      photoUrl: photoUrl ?? this.photoUrl,
      name: name ?? this.name,
      phoneNo: phoneNo ?? this.phoneNo,
      email: email ?? this.email,
      userType: userType ?? this.userType,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    final type = EnumToString.convertToString(userType);
    return {
      'userId': userId,
      'photoUrl': photoUrl,
      'name': name,
      'phoneNo': phoneNo,
      'email': email,
      'userType': type,
      'address': address,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    final type = EnumToString.fromString(UserType.values, map['userType']);
    return AppUser(
      userId: map['userId'],
      photoUrl: map['photoUrl'],
      name: map['name'],
      phoneNo: map['phoneNo'],
      email: map['email'],
      address: map['address'],
      userType: type ?? UserType.unknown,
    );
  }

  static AppUser? fromDocument(DocumentSnapshot? doc) {
    if (doc == null) {
      return null;
    }
    final data = doc.data() as Map?;
    final type = EnumToString.fromString(UserType.values, data?['userType']);
    print('App users ---- $data');
    return AppUser(
      userId: doc.id,
      email: data?['email'],
      name: data?['name'],
      photoUrl: data?['photoUrl'],
      phoneNo: data?['phoneNo'],
      address: data?['address'],
      userType: type ?? UserType.unknown,
    );
  }

  static const emptyUser = AppUser(
    userId: '',
    photoUrl: '',
    name: '',
    phoneNo: '',
    email: '',
    userType: UserType.unknown,
  );

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AppUser(userId: $userId, photoUrl: $photoUrl, name: $name, phoneNo: $phoneNo, email: $email)';
  }

  @override
  List<Object?> get props {
    return [
      userId,
      photoUrl,
      name,
      phoneNo,
      email,
      userType,
    ];
  }
}
