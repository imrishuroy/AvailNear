import 'dart:convert';
import 'package:equatable/equatable.dart';

class Notification extends Equatable {
  final String? title;
  final String content;
  final String? renteePhNo;

  const Notification({
    this.title,
    required this.content,
    this.renteePhNo,
  });

  Notification copyWith({
    String? title,
    String? content,
    String? renteePhNo,
  }) {
    return Notification(
      title: title ?? this.title,
      content: content ?? this.content,
      renteePhNo: renteePhNo ?? this.renteePhNo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'renteePhNo': renteePhNo,
    };
  }

  factory Notification.fromMap(Map<String, dynamic> map) {
    return Notification(
      title: map['title'],
      content: map['content'] ?? '',
      renteePhNo: map['renteePhNo'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Notification.fromJson(String source) =>
      Notification.fromMap(json.decode(source));

  @override
  String toString() =>
      'Notification(title: $title, content: $content, renteePhNo: $renteePhNo)';

  @override
  List<Object?> get props => [title, content, renteePhNo];
}
