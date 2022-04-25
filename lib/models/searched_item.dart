import 'package:equatable/equatable.dart';

class SearchedItem extends Equatable {
  final String? description;
  final String? placeId;
  final String mainText;

  const SearchedItem({
    this.description,
    this.placeId,
    required this.mainText,
  });

  SearchedItem copyWith({
    String? description,
    String? placeId,
    String? mainText,
  }) {
    return SearchedItem(
      description: description ?? this.description,
      placeId: placeId ?? this.placeId,
      mainText: mainText ?? this.mainText,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'placeId': placeId,
      'mainText': mainText,
    };
  }

  factory SearchedItem.fromMap(Map<String, dynamic> map) {
    final formatedText = map['structured_formatting'] as Map?;
    final mainText =
        formatedText != null ? formatedText['main_text'] as String? : null;
    return SearchedItem(
      description: map['description'],
      placeId: map['place_id'],
      mainText: mainText ?? '',
    );
  }

  @override
  String toString() =>
      'SearchedItem(description: $description, placeId: $placeId, mainText: $mainText)';

  @override
  List<Object?> get props => [description, placeId, mainText];
}
