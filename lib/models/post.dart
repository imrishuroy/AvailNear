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

  const Post({
    this.postId,
    this.title,
    this.description,
    this.owner,
    this.price,
    this.address,
    required this.images,
  });

  Post copyWith({
    String? postId,
    String? title,
    String? description,
    AppUser? owner,
    int? price,
    String? address,
    List<String?>? images,
  }) {
    return Post(
      postId: postId ?? this.postId,
      title: title ?? this.title,
      description: description ?? this.description,
      owner: owner ?? this.owner,
      price: price ?? this.price,
      address: address ?? this.address,
      images: images ?? this.images,
    );
  }

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
    };
  }

  static Future<Post> fromDocument(DocumentSnapshot? doc) async {
    final data = doc?.data() as Map?;

    final userRef = data?['owner'] as DocumentReference?;

    final userSnap = await userRef?.get();
    return Post(
      postId: data?['postId'],
      title: data?['title'],
      description: data?['description'],
      owner: data?['owner'] != null ? AppUser.fromDocument(userSnap) : null,
      price: data?['price']?.toInt(),
      address: data?['address'],
      images: List<String?>.from(data?['images']),
    );
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    print('Post map data --$map');

    return Post(
      postId: map['postId'],
      title: map['title'],
      description: map['description'],
      owner: map['owner'] != null ? AppUser.fromMap(map['owner']) : null,
      price: map['price']?.toInt(),
      address: map['address'],
      images: List<String?>.from(map['images']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Post(title: $title, description: $description, owner: $owner, price: $price, address: $address, images: $images, postId: $postId)';
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
    ];
  }
}
