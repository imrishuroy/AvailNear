import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '/config/paths.dart';
import '/models/app_user.dart';

class Post extends Equatable {
  final String? postId;
  final String? title;
  final String? description;
  final AppUser? owner;
  final int? price;
  final String? address;
  final List<String?> images;
  final DateTime? createdAt;
  final GeoPoint? geoPoint;
  final String? noOfBedRoom;
  final String? noOfBathRoom;
  final String? noOfKitchen;

  const Post({
    this.noOfBedRoom,
    this.noOfBathRoom,
    this.noOfKitchen,
    this.postId,
    this.title,
    this.description,
    this.owner,
    this.price,
    this.address,
    required this.images,
    this.createdAt,
    this.geoPoint,
  });

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'title': title,
      'description': description,
      'owner': owner?.userId != null
          ? FirebaseFirestore.instance
              .collection(Paths.users)
              .doc(owner?.userId)
          : null,
      'price': price,
      'address': address,
      'images': images,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
      'geopoint': geoPoint,
      'noOfBathRoom': noOfBathRoom,
      'noOfBedRoom': noOfBedRoom,
      'noOfKitchen': noOfKitchen,
    };
  }

  static Future<Post> fromDocument(DocumentSnapshot? doc) async {
    print('data from post -- $doc');
    final data = doc?.data() as Map?;

    final userRef = data?['owner'] as DocumentReference?;

    final userSnap = await userRef?.get();
    print('Location -- ${data?['location']}');
    final geoPoint = data?['location'] as GeoPoint?;
    print('geopoint - $geoPoint');

    return Post(
      postId: data?['postId'],
      title: data?['title'],
      description: data?['description'],
      owner: data?['owner'] != null ? AppUser.fromDocument(userSnap) : null,
      price: data?['price']?.toInt(),
      address: data?['address'],
      images:
          data?['images'] != null ? List<String?>.from(data?['images']) : [],
      createdAt: data?['createdAt'] != null
          ? (data?['createdAt'] as Timestamp).toDate()
          : null,
      geoPoint: geoPoint,
      noOfKitchen: data?['noOfKitchen'],
      noOfBathRoom: data?['noOfBathRoom'],
      noOfBedRoom: data?['noOfBedRoom'],
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Post(postId: $postId, title: $title, description: $description, owner: $owner, price: $price, address: $address, images: $images, createdAt: $createdAt, geoPoint: $geoPoint, noOfBedRoom: $noOfBedRoom, noOfBathRoom: $noOfBathRoom, noOfKitchen: $noOfKitchen)';
  }

  @override
  List<Object?> get props {
    return [
      postId,
      title,
      description,
      owner,
      price,
      address,
      images,
      createdAt,
      geoPoint,
    ];
  }

  Post copyWith({
    String? postId,
    String? title,
    String? description,
    AppUser? owner,
    int? price,
    String? address,
    List<String?>? images,
    DateTime? createdAt,
    GeoPoint? geoPoint,
    String? noOfBedRoom,
    String? noOfBathRoom,
    String? noOfKitchen,
  }) {
    return Post(
      postId: postId ?? this.postId,
      title: title ?? this.title,
      description: description ?? this.description,
      owner: owner ?? this.owner,
      price: price ?? this.price,
      address: address ?? this.address,
      images: images ?? this.images,
      createdAt: createdAt ?? this.createdAt,
      geoPoint: geoPoint ?? this.geoPoint,
      noOfBedRoom: noOfBedRoom ?? this.noOfBedRoom,
      noOfBathRoom: noOfBathRoom ?? this.noOfBathRoom,
      noOfKitchen: noOfKitchen ?? this.noOfKitchen,
    );
  }
}
