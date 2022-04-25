part of 'edit_post_cubit.dart';

enum EditPostStatus { initial, loading, succuss, error, submitting }

class EditPostState extends Equatable {
  final String? title;
  final String? description;
  final String? address;
  final AppUser? owner;
  final int? price;
  final List<XFile?> images;
  final Failure? failure;
  final EditPostStatus status;
  final double? lat;
  final double? long;
  final String? noOfBedRoom;
  final String? noOfBathRoom;
  final String? noOfKitchen;
  final List<String?> photoUrls;

  const EditPostState({
    this.title,
    this.description,
    this.address,
    this.owner,
    this.price,
    required this.images,
    this.failure,
    required this.status,
    this.lat,
    this.long,
    this.noOfBedRoom,
    this.noOfBathRoom,
    this.noOfKitchen,
    this.photoUrls = const [],
  });

  EditPostState copyWith({
    String? title,
    String? description,
    String? address,
    AppUser? owner,
    int? price,
    List<XFile?>? images,
    Failure? failure,
    EditPostStatus? status,
    double? lat,
    double? long,
    String? noOfBedRoom,
    String? noOfBathRoom,
    String? noOfKitchen,
    List<String?>? photoUrls,
  }) {
    return EditPostState(
      title: title ?? this.title,
      description: description ?? this.description,
      address: address ?? this.address,
      owner: owner ?? this.owner,
      price: price ?? this.price,
      images: images ?? this.images,
      failure: failure ?? this.failure,
      status: status ?? this.status,
      lat: lat ?? this.lat,
      long: long ?? this.long,
      noOfBedRoom: noOfBedRoom ?? this.noOfBedRoom,
      noOfBathRoom: noOfBathRoom ?? this.noOfBathRoom,
      noOfKitchen: noOfKitchen ?? this.noOfKitchen,
      photoUrls: photoUrls ?? this.photoUrls,
    );
  }

  factory EditPostState.initial() =>
      const EditPostState(images: [], status: EditPostStatus.initial);

  @override
  String toString() {
    return 'EditPostState(title: $title, description: $description, address: $address, owner: $owner, price: $price, images: $images, failure: $failure, status: $status, lat: $lat, long: $long, noOfBedRoom: $noOfBedRoom, noOfBathRoom: $noOfBathRoom, noOfKitchen: $noOfKitchen , photoUrls: $photoUrls,)';
  }

  @override
  List<Object?> get props {
    return [
      title,
      description,
      address,
      owner,
      price,
      images,
      failure,
      status,
      lat,
      long,
      noOfBedRoom,
      noOfBathRoom,
      noOfKitchen,
      photoUrls,
    ];
  }
}
