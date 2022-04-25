import '/nav/nav_screen.dart';
import '/widgets/image_slider.dart';

import '/blocs/bloc/auth_bloc.dart';

import '/models/place_details.dart';
import '/models/post.dart';

import '/repositories/post/post_repository.dart';
import '/screens/edit-post/cubit/edit_post_cubit.dart';
import '/screens/search-place/search_screen.dart';
import '/widgets/custom_text_field.dart';
import '/widgets/error_dialog.dart';
import '/widgets/loading_indicator.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditPostScreenArgs {
  final Post? post;

  EditPostScreenArgs({required this.post});
}

class EditPostScreen extends StatefulWidget {
  static const String routeName = '/editPost';
  final Post? post;

  static Route route({required EditPostScreenArgs args}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => BlocProvider(
        create: (context) => EditPostCubit(
          authBloc: context.read<AuthBloc>(),
          postRepository: context.read<PostRepository>(),
          post: args.post,
        )..getInitialData(),
        child: EditPostScreen(post: args.post),
      ),
    );
  }

  const EditPostScreen({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  State<EditPostScreen> createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  final ImagePicker imagePicker = ImagePicker();

  List<XFile>? imageFileList = [];

  final _formKey = GlobalKey<FormState>();

  void _submitForm(BuildContext context, bool isSubmitting) async {
    print('this runs');
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate() && !isSubmitting) {
      await context.read<EditPostCubit>().submitPost();
      _formKey.currentState?.reset();
      Navigator.of(context)
          .pushNamedAndRemoveUntil(NavScreen.routeName, (route) => false);
      //.pushNamedAndRemoveUntil(NavScreen.routeName);
      //  Navigator.of(context).pop(true);
      //context.read<NavBloc>().add(const UpdateNavItem(item: NavItem.dashboard));

      print('this runs 2');

      // if (context.read<EditPostCubit>().state.images.isNotEmpty) {
      //   print('this runs 3');
      //   await context.read<EditPostCubit>().submitPost();
      //   _formKey.currentState?.reset();
      //   context.read<EditPostCubit>().clearSelectedImage();
      //   ShowSnackBar.showSnackBar(
      //     context,
      //     title: 'New Post added',
      //   );
      //   context
      //       .read<NavBloc>()
      //       .add(const UpdateNavItem(item: NavItem.dashboard));
      // } else {
      //   ShowSnackBar.showSnackBar(
      //     context,
      //     title: 'Please select an image to continue',
      //   );
      // }
    }
  }

  @override
  void initState() {
    _addressController.text = widget.post?.address ?? '';
    super.initState();
  }

  @override
  void dispose() {
    _addressController.clear();
    super.dispose();
  }

  final _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final _canvas = MediaQuery.of(context).size;
    // final _createPostCubit = context.read<EditPostCubit>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const CircleAvatar(
                radius: 20.0,
                backgroundColor: Colors.black,
                child: Center(
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          title: const Text('Edit Post'),
          centerTitle: true,
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: BlocConsumer<EditPostCubit, EditPostState>(
          listener: (context, state) {
            if (state.status == EditPostStatus.error) {
              showDialog(
                context: context,
                builder: (_) => ErrorDialog(content: state.failure?.message),
              );
            }
            // if (state.status == EditPostStatus.succuss) {
            //   _addressController.text = state.address ?? '';
            // }
          },
          builder: (context, state) {
            if (state.status == EditPostStatus.submitting ||
                state.status == EditPostStatus.loading) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  LoadingIndicator(),
                  SizedBox(height: 20.0),
                  Text('Submitting your deails please wait...')
                ],
              );
            }
            if (state.status == EditPostStatus.loading) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  LoadingIndicator(),
                  SizedBox(height: 20.0),
                  Text('Getting your current location...')
                ],
              );
            }
            print('Create post lat ${state.lat}');
            print('Create post lat ${state.long}');
            print('Address ${state.address}');

            return SingleChildScrollView(
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
                      // Container(
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(10.0),
                      //     border: Border.all(color: Colors.grey.shade800),
                      //   ),
                      //   height: _canvas.height * 0.28,
                      //   width: double.infinity,
                      //   child: state.images.isEmpty
                      //       ? Center(
                      //           child: ElevatedButton.icon(
                      //             style: ElevatedButton.styleFrom(
                      //                 primary: Colors.black),
                      //             icon: const Icon(Icons.add_a_photo),
                      //             label: const Text('Pick Images'),
                      //             // onPressed: () => _pickImage(context),
                      //             onPressed: () =>
                      //                 _createPostCubit.pickImages(),
                      //           ),
                      //         )
                      //       : GridView.builder(
                      //           gridDelegate:
                      //               const SliverGridDelegateWithFixedCrossAxisCount(
                      //             crossAxisCount: 3,
                      //             childAspectRatio: 0.9,
                      //             crossAxisSpacing: 2.0,
                      //             mainAxisSpacing: 0.0,
                      //           ),
                      //           itemCount: state.images.length,
                      //           itemBuilder: (context, index) {
                      //             final File? fileImage =
                      //                 state.images[index] != null
                      //                     ? File(state.images[index]!.path)
                      //                     : null;
                      //             if (fileImage != null) {
                      //               return Padding(
                      //                 padding: const EdgeInsets.symmetric(
                      //                   horizontal: 10.0,
                      //                   vertical: 10.0,
                      //                 ),
                      //                 child: Stack(
                      //                   children: [
                      //                     ClipRRect(
                      //                       borderRadius:
                      //                           BorderRadius.circular(14.0),
                      //                       child: Image.file(
                      //                         File(state.images[index]!.path),
                      //                         fit: BoxFit.cover,
                      //                         height: 100.0,
                      //                         width: 100.0,
                      //                       ),
                      //                     ),
                      //                     Align(
                      //                       alignment: Alignment.center,
                      //                       child: IconButton(
                      //                         onPressed: () => _createPostCubit
                      //                             .removeImage(index),
                      //                         icon: const Icon(
                      //                           Icons.remove_circle,
                      //                           color: Colors.red,
                      //                           size: 27.0,
                      //                         ),
                      //                       ),
                      //                     )
                      //                   ],
                      //                 ),
                      //               );
                      //             }
                      //             return Image.network(errorImage);
                      //           },
                      //         ),
                      // ),

                      ImageSlider(
                        imgList: widget.post?.images,
                        bottomRadius: 12.0,
                      ),
                      const SizedBox(height: 20.0),
                      CustomTextField(
                        initialValue: state.title,
                        labelText: 'Post Title',
                        onChanged: (value) =>
                            context.read<EditPostCubit>().titleChanged(value),
                        validator: (value) =>
                            value!.isEmpty ? 'Title can\'t empty' : null,
                        textInputType: TextInputType.name,
                        hintText: 'Enter post title',
                      ),
                      CustomTextField(
                        controller: _addressController,
                        suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.add_location,
                              color: Colors.blue,
                            ),
                            onPressed: () async {
                              final placeDetails = await Navigator.of(context)
                                      .pushNamed(SearchScreen.routeName)
                                  as PlaceDetails?;
                              if (placeDetails != null) {
                                _addressController.text =
                                    placeDetails.formatedAddress ?? '';

                                context.read<EditPostCubit>().changeLocation(
                                      address: placeDetails.formatedAddress,
                                      lat: placeDetails.lat,
                                      long: placeDetails.long,
                                    );
                              }
                            }),
                        // initialValue: state.address,
                        labelText: 'Address',
                        onChanged: (value) =>
                            context.read<EditPostCubit>().addressChanged(value),
                        validator: (value) =>
                            value!.isEmpty ? 'Address can\'t empty' : null,
                        textInputType: TextInputType.name,
                        hintText: 'Enter your address',
                      ),
                      CustomTextField(
                        initialValue: state.price.toString(),
                        labelText: 'Price',
                        onChanged: (value) =>
                            context.read<EditPostCubit>().priceChanged(value),
                        validator: (value) =>
                            value!.isEmpty ? 'Price can\'t empty' : null,
                        textInputType: TextInputType.number,
                        hintText: 'Enter price',
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: CustomTextField(
                                initialValue: state.noOfBedRoom,
                                labelText: 'Beds',
                                onChanged: (value) => context
                                    .read<EditPostCubit>()
                                    .bedsChanged(value),
                                validator: (value) => value!.isEmpty
                                    ? 'No of beds can\'t empty'
                                    : null,
                                textInputType: TextInputType.number,
                                hintText: 'No.',
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: CustomTextField(
                                initialValue: state.noOfKitchen,
                                labelText: 'Kitchen',
                                textInputType: TextInputType.number,
                                onChanged: (value) => context
                                    .read<EditPostCubit>()
                                    .kitchenChanged(value),
                                validator: (value) => value!.isEmpty
                                    ? 'No of kitchen can\'t empty'
                                    : null,
                                hintText: 'No.',
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: CustomTextField(
                                initialValue: state.noOfBathRoom,
                                textInputType: TextInputType.number,
                                labelText: 'Bathroom',
                                onChanged: (value) => context
                                    .read<EditPostCubit>()
                                    .bathroomChanged(value),
                                validator: (value) => value!.isEmpty
                                    ? 'No of bathroom can\'t empty'
                                    : null,
                                hintText: 'No.',
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      CustomTextField(
                        initialValue: state.description,
                        maxLines: 3,
                        labelText: 'Description',
                        onChanged: (value) => context
                            .read<EditPostCubit>()
                            .descriptionChanged(value),
                        validator: (value) =>
                            value!.isEmpty ? 'Description can\'t empty' : null,
                        textInputType: TextInputType.name,
                        hintText: 'Enter post description',
                      ),
                      const SizedBox(height: 15.0),
                      SizedBox(
                        height: 40.0,
                        width: 120.0,
                        child: ElevatedButton(
                          onPressed: () => _submitForm(context,
                              state.status == EditPostStatus.submitting),
                          child: const Text(
                            'Submit',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50.0),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
