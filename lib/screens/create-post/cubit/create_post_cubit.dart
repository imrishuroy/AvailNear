import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';
import '/blocs/bloc/auth_bloc.dart';
import '/models/post.dart';
import '/repositories/post/post_repository.dart';
import '/utils/image_util.dart';
import '/models/app_user.dart';
import '/models/failure.dart';
import 'package:image_picker/image_picker.dart';
part 'create_post_state.dart';

class CreatePostCubit extends Cubit<CreatePostState> {
  final AuthBloc _authBloc;
  final PostRepository _postRepository;

  final ImagePicker imagePicker = ImagePicker();

  CreatePostCubit({
    required AuthBloc authBloc,
    required PostRepository postRepository,
  })  : _authBloc = authBloc,
        _postRepository = postRepository,
        super(CreatePostState.initial());

  void titleChanged(String value) {
    emit(state.copyWith(title: value, status: CreatePostStatus.initial));
  }

  void descriptionChanged(String value) {
    emit(state.copyWith(description: value, status: CreatePostStatus.initial));
  }

  void addressChanged(String value) {
    emit(state.copyWith(address: value, status: CreatePostStatus.initial));
  }

  void priceChanged(String value) {
    emit(state.copyWith(
        price: int.tryParse(value), status: CreatePostStatus.initial));
  }

  void clearSelectedImage() {
    emit(state.copyWith(images: []));
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

        emit(state.copyWith(images: images, status: CreatePostStatus.initial));

        // imageFileList!.addAll(selectedImages);
      }
      print('Image List Length:' + state.images.length.toString());
    } catch (error) {
      emit(state.copyWith(
          failure: const Failure(message: 'Error picking images'),
          status: CreatePostStatus.error));
    }
  }

  void removeImage(int index) async {
    final List<XFile?> images = List.from(state.images)..removeAt(index);
    // state.images.removeAt(index);
    //state.images.removeAt(index);
    emit(state.copyWith(images: images, status: CreatePostStatus.initial));
  }

  Future<void> submitPost() async {
    try {
      emit(state.copyWith(status: CreatePostStatus.submitting));
      List<String?> images = [];
      final postId = const Uuid().v4();

      for (var element in state.images) {
        if (element != null) {
          final String? downloadUrl = await ImageUtil.uploadPostImageToStorage(
            folderName: 'postImages',
            file: await element.readAsBytes(),
            postId: postId,
          );

          // ImageUtil.uploadProfileImageToStorage(
          //   'postImages',
          //   await element.readAsBytes(),
          //   true,
          //   _authBloc.state.user?.userId ?? '',
          // );

          images.add(downloadUrl);
        }
      }

      final post = Post(
        postId: postId,
        images: images,
        title: state.title,
        description: state.description,
        address: state.address,
        owner: _authBloc.state.user,
        price: state.price,
        createdAt: DateTime.now(),
      );
      await _postRepository.addPost(post: post);

      emit(state.copyWith(status: CreatePostStatus.succuss));
    } catch (error) {
      print('Error in submitting post ${error.toString()}');
      emit(state.copyWith(
          failure: const Failure(message: 'Error in submitting post'),
          status: CreatePostStatus.error));
    }
  }
}
