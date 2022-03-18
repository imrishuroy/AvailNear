import 'dart:io';
import '/widgets/error_dialog.dart';

import '/widgets/show_snackbar.dart';

import '/constants/constants.dart';
import '/screens/create-post/cubit/create_post_cubit.dart';
import '/widgets/custom_button.dart';
import '/widgets/custom_text_field.dart';
import '/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final ImagePicker imagePicker = ImagePicker();

  List<XFile>? imageFileList = [];

  final _formKey = GlobalKey<FormState>();

  void _submitForm(BuildContext context, bool isSubmitting) async {
    print('this runs');
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate() && !isSubmitting) {
      print('this runs 2');

      if (context.read<CreatePostCubit>().state.images.isNotEmpty) {
        print('this runs 3');
        await context.read<CreatePostCubit>().submitPost();
        _formKey.currentState?.reset();
        context.read<CreatePostCubit>().clearSelectedImage();
        ShowSnackBar.showSnackBar(
          context,
          title: 'New Post added',
        );
      } else {
        ShowSnackBar.showSnackBar(
          context,
          title: 'Please select an image to continue',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final _canvas = MediaQuery.of(context).size;
    final _createPostCubit = context.read<CreatePostCubit>();
    return BlocConsumer<CreatePostCubit, CreatePostState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.status == CreatePostStatus.submitting) {
          return const LoadingIndicator();
        } else if (state.status == CreatePostStatus.error) {
          showDialog(
              context: context,
              builder: (_) => ErrorDialog(content: state.failure?.message));
        }
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 20.0,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 100.0),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: Colors.grey),
                        ),
                        height: _canvas.height * 0.34,
                        width: double.infinity,
                        child: state.images.isEmpty
                            ? Center(
                                child: ElevatedButton.icon(
                                  icon: const Icon(Icons.add_a_photo),
                                  label: const Text('Pick Image'),
                                  // onPressed: () => _pickImage(context),
                                  onPressed: () =>
                                      _createPostCubit.pickImages(),
                                ),
                              )
                            : GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 0.9,
                                  crossAxisSpacing: 2.0,
                                  mainAxisSpacing: 0.0,
                                ),
                                itemCount: state.images.length,
                                itemBuilder: (context, index) {
                                  final File? fileImage =
                                      state.images[index] != null
                                          ? File(state.images[index]!.path)
                                          : null;
                                  if (fileImage != null) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                      ),
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(14.0),
                                            child: Image.file(
                                              File(state.images[index]!.path),
                                              fit: BoxFit.cover,
                                              height: 100.0,
                                              width: 100.0,
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: IconButton(
                                              onPressed: () => _createPostCubit
                                                  .removeImage(index),
                                              icon: const Icon(
                                                Icons.remove_circle,
                                                color: Colors.red,
                                                size: 27.0,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }
                                  return Image.network(errorImage);
                                },
                              ),
                      ),
                      const SizedBox(height: 20.0),
                      CustomTextField(
                        onChanged: (value) =>
                            context.read<CreatePostCubit>().titleChanged(value),
                        validator: (value) =>
                            value!.isEmpty ? 'Title can\'t empty' : null,
                        textInputType: TextInputType.name,
                        hintText: 'Enter post title',
                      ),
                      CustomTextField(
                        onChanged: (value) => context
                            .read<CreatePostCubit>()
                            .descriptionChanged(value),
                        validator: (value) =>
                            value!.isEmpty ? 'Description can\'t empty' : null,
                        textInputType: TextInputType.name,
                        hintText: 'Description',
                      ),
                      CustomTextField(
                        onChanged: (value) => context
                            .read<CreatePostCubit>()
                            .addressChanged(value),
                        validator: (value) =>
                            value!.isEmpty ? 'Address can\'t empty' : null,
                        textInputType: TextInputType.name,
                        hintText: 'Address',
                      ),
                      CustomTextField(
                        onChanged: (value) =>
                            context.read<CreatePostCubit>().priceChanged(value),
                        validator: (value) =>
                            value!.isEmpty ? 'Price can\'t empty' : null,
                        textInputType: TextInputType.number,
                        hintText: 'Price',
                      ),
                      const SizedBox(height: 20.0),
                      CustomGradientBtn(
                        onTap: () => _submitForm(context,
                            state.status == CreatePostStatus.submitting),
                        label: 'Submit',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
