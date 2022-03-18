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

  const Post({
    this.postId,
    this.title,
    this.description,
    this.owner,
    this.price,
    this.address,
    required this.images,
    this.createdAt,
  });

  Post copyWith({
    String? postId,
    String? title,
    String? description,
    AppUser? owner,
    int? price,
    String? address,
    List<String?>? images,
    DateTime? createdAt,
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
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
    };
  }

  static Future<Post> fromDocument(DocumentSnapshot? doc) async {
    print('data from post -- $doc');
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
      images: List<String?>.from(
        data?['images'],
      ),
      createdAt: data?['createdAt'] != null
          ? (data?['createdAt'] as Timestamp).toDate()
          : null,
    );
  }

  // factory Post.fromMap(Map<String, dynamic> map) {
  //   print('Post map data --$map');

  //   return Post(
  //     postId: map['postId'],
  //     title: map['title'],
  //     description: map['description'],
  //     owner: map['owner'] != null ? AppUser.fromMap(map['owner']) : null,
  //     price: map['price']?.toInt(),
  //     address: map['address'],
  //     images: List<String?>.from(map['images']),
  //          createdAt: map['createdAt'] != null
  //         ? (map['createdAt'] as Timestamp).toDate()
  //         : null,
  //   );
  // }

  String toJson() => json.encode(toMap());

  //factory Post.fromJson(String source) => Post.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Post(title: $title, description: $description, owner: $owner, price: $price, address: $address, images: $images, postId: $postId, createdAt: $createdAt)';
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
    ];
  }
}
