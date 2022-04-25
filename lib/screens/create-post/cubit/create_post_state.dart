part of 'create_post_cubit.dart';

enum CreatePostStatus { initial, loading, submitting, succuss, error }

class CreatePostState extends Equatable {
  final String? title;
  final String? description;
  final String? address;
  final AppUser? owner;
  final int? price;
  final List<XFile?> images;
  final Failure? failure;
  final CreatePostStatus status;
  final double? lat;
  final double? long;
  final String? noOfBedRoom;
  final String? noOfBathRoom;
  final String? noOfKitchen;

  const CreatePostState({
    this.lat,
    this.long,
    this.noOfBedRoom,
    this.noOfBathRoom,
    this.noOfKitchen,
    this.title,
    this.description,
    this.address,
    this.owner,
    this.price,
    this.failure,
    required this.images,
    required this.status,
  });

  factory CreatePostState.initial() => const CreatePostState(
        title: '',
        description: '',
        owner: null,
        price: null,
        address: '',
        images: [],
        failure: Failure(),
        status: CreatePostStatus.initial,
        lat: null,
        long: null,
        noOfBedRoom: null,
        noOfBathRoom: null,
        noOfKitchen: null,
      );

  @override
  List<Object?> get props {
    return [
      title,
      description,
      address,
      owner,
      price,
      images,
      status,
      failure,
      lat,
      long,
      noOfBedRoom,
      noOfBathRoom,
      noOfKitchen,
    ];
  }

  CreatePostState copyWith({
    String? title,
    String? description,
    String? address,
    AppUser? owner,
    int? price,
    List<XFile?>? images,
    Failure? failure,
    CreatePostStatus? status,
    double? lat,
    double? long,
    String? noOfBedRoom,
    String? noOfBathRoom,
    String? noOfKitchen,
  }) {
    return CreatePostState(
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
    );
  }

  @override
  String toString() {
    return 'CreatePostState(title: $title, description: $description, address: $address, owner: $owner, price: $price, images: $images, failure: $failure, status: $status, lat: $lat, long: $long, noOfBedRoom: $noOfBedRoom, noOfBathRoom: $noOfBathRoom, noOfKitchen: $noOfKitchen)';
  }
}
