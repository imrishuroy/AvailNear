part of 'profile_cubit.dart';

enum ProfileStatus { initial, submitting, succuss, error }

class ProfileState extends Equatable {
  final String? userId;
  final String? email;
  final String? name;
  final String? phNo;
  final String? address;
  final Uint8List? imageFile;
  final ProfileStatus status;
  final Failure? failure;

  const ProfileState({
    this.userId,
    this.name,
    this.email,
    this.phNo,
    this.address,
    this.imageFile,
    required this.status,
    this.failure,
  });

  bool get isFormValid =>
      // email!.isNotEmpty &&
      name!.isNotEmpty && address!.isNotEmpty && imageFile != null;

  @override
  bool get stringify => true;

  factory ProfileState.initial() => const ProfileState(
        userId: '',
        phNo: '',
        imageFile: null,
        status: ProfileStatus.initial,
        address: '',
        email: '',
        name: '',
        failure: Failure(),
      );
  @override
  List<Object?> get props => [
        userId,
        email,
        phNo,
        address,
        imageFile,
        status,
        name,
        failure,
      ];

  ProfileState copyWith({
    String? userId,
    String? email,
    String? phNo,
    String? address,
    Uint8List? imageFile,
    ProfileStatus? status,
    String? name,
    Failure? failure,
  }) {
    return ProfileState(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      phNo: phNo ?? this.phNo,
      address: address ?? this.address,
      imageFile: imageFile ?? this.imageFile,
      status: status ?? this.status,
      name: name ?? this.name,
      failure: failure ?? this.failure,
    );
  }
}
