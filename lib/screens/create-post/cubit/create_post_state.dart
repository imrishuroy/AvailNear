part of 'create_post_cubit.dart';

enum CreatePostStatus { initial, submitting, succuss, error }

class CreatePostState extends Equatable {
  final String? title;
  final String? description;
  final String? address;
  final AppUser? owner;
  final int? price;
  final List<XFile?> images;
  final Failure? failure;
  final CreatePostStatus status;

  const CreatePostState({
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
    ];
  }

  CreatePostState copyWith({
    String? title,
    String? description,
    String? address,
    AppUser? owner,
    int? price,
    List<XFile?>? images,
    CreatePostStatus? status,
    Failure? failure,
  }) {
    return CreatePostState(
      title: title ?? this.title,
      description: description ?? this.description,
      address: address ?? this.address,
      owner: owner ?? this.owner,
      price: price ?? this.price,
      images: images ?? this.images,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }

  @override
  String toString() {
    return 'CreatePostState(name: $title, description: $description, address: $address, owner: $owner, price: $price, images: $images, status: $status,failure: $failure)';
  }
}
