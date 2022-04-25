import '/blocs/bloc/auth_bloc.dart';
import '/models/app_user.dart';
import '/models/failure.dart';
import '/models/post.dart';
import '/repositories/post/post_repository.dart';
import '/utils/location_util.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'edit_post_state.dart';

class EditPostCubit extends Cubit<EditPostState> {
  final AuthBloc _authBloc;
  final PostRepository _postRepository;
  final Post? _post;

  final ImagePicker imagePicker = ImagePicker();
  EditPostCubit({
    required AuthBloc authBloc,
    required PostRepository postRepository,
    required Post? post,
  })  : _authBloc = authBloc,
        _postRepository = postRepository,
        _post = post,
        super(EditPostState.initial());

  void titleChanged(String value) {
    emit(state.copyWith(title: value, status: EditPostStatus.initial));
  }

  void descriptionChanged(String value) {
    emit(state.copyWith(description: value, status: EditPostStatus.initial));
  }

  void addressChanged(String value) {
    emit(state.copyWith(address: value, status: EditPostStatus.initial));
  }

  void priceChanged(String value) {
    emit(state.copyWith(
        price: int.tryParse(value), status: EditPostStatus.initial));
  }

  void bedsChanged(String value) {
    emit(state.copyWith(noOfBedRoom: value, status: EditPostStatus.initial));
  }

  void kitchenChanged(String value) {
    emit(state.copyWith(noOfKitchen: value, status: EditPostStatus.initial));
  }

  void bathroomChanged(String value) {
    emit(state.copyWith(noOfBathRoom: value, status: EditPostStatus.initial));
  }

  void clearSelectedImage() {
    emit(state.copyWith(images: []));
  }

  void getInitialData() {
    emit(state.copyWith(status: EditPostStatus.loading));
    emit(
      state.copyWith(
        photoUrls: _post?.images,
        title: _post?.title,
        address: _post?.address,
        price: _post?.price,
        noOfBathRoom: _post?.noOfBathRoom,
        noOfBedRoom: _post?.noOfBedRoom,
        noOfKitchen: _post?.noOfKitchen,
        description: _post?.description,
        lat: _post?.geoPoint?.latitude,
        long: _post?.geoPoint?.longitude,
        status: EditPostStatus.succuss,
      ),
    );
  }

  Future<void> pickImages() async {
    try {
      final List<XFile>? selectedImages = await imagePicker.pickMultiImage(
        imageQuality: 50,
      );
      if (selectedImages!.isNotEmpty) {
        final List<XFile?> images = List.from(state.images)
          ..addAll(selectedImages);
        // state.images.addAll(selectedImages);

        emit(state.copyWith(images: images, status: EditPostStatus.initial));

        // imageFileList!.addAll(selectedImages);
      }
      print('Image List Length:' + state.images.length.toString());
    } catch (error) {
      emit(state.copyWith(
          failure: const Failure(message: 'Error picking images'),
          status: EditPostStatus.error));
    }
  }

  void removeImage(int index) async {
    final List<XFile?> images = List.from(state.images)..removeAt(index);
    // state.images.removeAt(index);
    //state.images.removeAt(index);
    emit(state.copyWith(images: images, status: EditPostStatus.initial));
  }

  Future<void> submitPost() async {
    try {
      emit(state.copyWith(status: EditPostStatus.submitting));
      //List<String?> images = [];
      // final postId = const Uuid().v4();

      // for (var element in state.images) {
      //   if (element != null) {
      //     final String? downloadUrl = await ImageUtil.uploadPostImageToStorage(
      //       folderName: 'postImages',
      //       file: await element.readAsBytes(),
      //       postId: postId,
      //     );

      //     // ImageUtil.uploadProfileImageToStorage(
      //     //   'postImages',
      //     //   await element.readAsBytes(),
      //     //   true,
      //     //   _authBloc.state.user?.userId ?? '',
      //     // );

      //     images.add(downloadUrl);
      //   }
      // }
      if (_post?.postId != null) {
        final post = Post(
          postId: _post?.postId,
          // images: images,
          images: _post?.images ?? [],
          title: state.title,
          description: state.description,
          address: state.address,
          owner: _authBloc.state.user,
          price: state.price,
          createdAt: DateTime.now(),
          noOfBathRoom: state.noOfBathRoom,
          noOfBedRoom: state.noOfBedRoom,
          noOfKitchen: state.noOfKitchen,
          geoPoint: GeoPoint(state.lat ?? 23.2527576, state.long ?? 77.5012589),
        );
        await _postRepository.addPost(post: post);
      }

      emit(state.copyWith(status: EditPostStatus.succuss));
    } catch (error) {
      print('Error in submitting post ${error.toString()}');
      emit(state.copyWith(
          failure: const Failure(message: 'Error in submitting post'),
          status: EditPostStatus.error));
    }
  }

  void changeLocation({
    required String? address,
    required double? lat,
    required double? long,
  }) {
    emit(state.copyWith(lat: lat, long: long, address: address));
  }

  void getCurrentLocation() async {
    try {
      emit(state.copyWith(status: EditPostStatus.loading));
      final address = await LocationUtil.getCurrentAddress();
      final locationData = await LocationUtil.getCurrentLocation();
      emit(state.copyWith(
          address: address,
          lat: locationData?.latitude,
          long: locationData?.longitude,
          status: EditPostStatus.succuss));
    } on Failure catch (failure) {
      emit(state.copyWith(status: EditPostStatus.error, failure: failure));
    }
  }
}
