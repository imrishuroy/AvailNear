import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Notification extends Equatable {
  final String? title;
  final String content;
  final String? renteePhNo;
  final String? renteePhotoUrl;
  final DateTime? createdAt;

  const Notification({
    this.title,
    required this.content,
    this.renteePhNo,
    required this.createdAt,
    required this.renteePhotoUrl,
  });

  Notification copyWith({
    String? title,
    String? content,
    String? renteePhNo,
    DateTime? createdAt,
    String? renteePhotoUrl,
  }) {
    return Notification(
      title: title ?? this.title,
      content: content ?? this.content,
      renteePhNo: renteePhNo ?? this.renteePhNo,
      createdAt: createdAt ?? this.createdAt,
      renteePhotoUrl: renteePhotoUrl ?? renteePhotoUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'renteePhNo': renteePhNo,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
      'renteePhotoUrl': renteePhotoUrl,
    };
  }

  factory Notification.fromMap(Map<String, dynamic> map) {
    return Notification(
      title: map['title'],
      content: map['content'] ?? '',
      renteePhNo: map['renteePhNo'],
      createdAt: map['createdAt'] != null
          ? (map['createdAt'] as Timestamp).toDate()
          : null,
      renteePhotoUrl: map['renteePhotoUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Notification.fromJson(String source) =>
      Notification.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Notification(title: $title, content: $content, renteePhNo: $renteePhNo, createdAt: $createdAt, renteePhotoUrl: $renteePhotoUrl)';
  }

  @override
  List<Object?> get props =>
      [title, content, renteePhNo, createdAt, renteePhotoUrl];
}
