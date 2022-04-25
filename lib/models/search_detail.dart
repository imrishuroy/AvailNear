import 'package:equatable/equatable.dart';

class SearchedDetails extends Equatable {
  final String? description;
  final String? placeId;
  final String mainText;

  const SearchedDetails({
    this.description,
    this.placeId,
    required this.mainText,
  });

  SearchedDetails copyWith({
    String? description,
    String? placeId,
    String? mainText,
  }) {
    return SearchedDetails(
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

  factory SearchedDetails.fromMap(Map<String, dynamic> map) {
    final formatedText = map['structured_formatting'] as Map?;
    final mainText =
        formatedText != null ? formatedText['main_text'] as String? : null;
    return SearchedDetails(
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
