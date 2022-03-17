import '/config/shared_prefs.dart';
import '/repositories/auth/auth_repository.dart';
import '/screens/profile/cubit/profile_cubit.dart';
import '/utils/image_util.dart';
import '/widgets/circle_button.dart';
import '/widgets/custom_button.dart';
import '/widgets/custom_text_field.dart';
import '/widgets/error_dialog.dart';
import '/widgets/loading_indicator.dart';
import '/widgets/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';

class OwnerProfile extends StatelessWidget {
  OwnerProfile({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  void _submitForm(BuildContext context, bool isSubmitting) {
    print('this runs');
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate() && !isSubmitting) {
      print('this runs 2');
      if (context.read<ProfileCubit>().state.imageFile != null) {
        print('this runs 3');
        context.read<ProfileCubit>().submitOwnerDetails();
      } else {
        ShowSnackBar.showSnackBar(
          context,
          title: 'Please select an image to continue',
          //backgroundColor: Colors.red,
        );
      }
    }
  }

  Future<void> _pickImage(BuildContext context) async {
    final pickedImage = await ImageUtil.pickImageFromGallery(
      cropStyle: CropStyle.circle,
      context: context,
      imageQuality: 30,
      title: 'Pick profile pic',
    );

    context.read<ProfileCubit>().imagePicked(await pickedImage?.readAsBytes());
  }

  @override
  Widget build(BuildContext context) {
    final _canvas = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () async {
              await SharedPrefs().deleteEverything();
              await SharedPrefs().setUserType(owner);
              await context.read<AuthRepository>().signOut();
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 10.0),
        ],
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          print('Current state ${state.status}');
          if (state.status == ProfileStatus.error) {
            showDialog(
              context: context,
              builder: (context) => ErrorDialog(
                content: state.failure?.message,
              ),
            );
          }
        },
        builder: (context, state) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30.0,
                vertical: 20.0,
              ),
              child: state.status == ProfileStatus.submitting
                  ? const LoadingIndicator()
                  : Form(
                      key: _formKey,
                      child: ListView(
                        children: [
                          SizedBox(height: _canvas.height * 0.09),
                          Center(
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                CircleAvatar(
                                  radius: 60.0,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    backgroundImage: state.imageFile != null
                                        ? MemoryImage(state.imageFile!,
                                            scale: 0.3)
                                        : null,
                                    radius: 58.0,
                                    // backgroundColor: Colors.red,
                                    child: state.imageFile == null
                                        ? const Icon(
                                            Icons.person,
                                            color: Colors.white,
                                            size: 30.0,
                                          )
                                        : null,
                                  ),
                                ),
                                GradientCircleButton(
                                  size: 40.0,
                                  onTap: () async => _pickImage(context),
                                  icon: state.imageFile == null
                                      ? Icons.add
                                      : Icons.edit,
                                  iconSize: 20.0,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 40.0),
                          CustomTextField(
                            onChanged: (value) =>
                                context.read<ProfileCubit>().nameChanged(value),
                            validator: (value) =>
                                value!.isEmpty ? 'Name can\'t empty' : null,
                            textInputType: TextInputType.name,
                            hintText: 'Enter owner name',
                          ),
                          CustomTextField(
                            onChanged: (value) => context
                                .read<ProfileCubit>()
                                .addressChanged(value),
                            validator: (value) =>
                                value!.isEmpty ? 'Address can\'t empty' : null,
                            textInputType: TextInputType.name,
                            hintText: 'Address',
                          ),
                          CustomTextField(
                            onChanged: (value) => context
                                .read<ProfileCubit>()
                                .phoneChanged(value),
                            validator: (value) => value!.length < 10
                                ? 'Invalid Phone Number'
                                : null,
                            textInputType: TextInputType.phone,
                            hintText: 'Phone Number',
                          ),
                          CustomTextField(
                            onChanged: (value) => context
                                .read<ProfileCubit>()
                                .emailChanged(value),
                            validator: (value) {
                              return null;
                            },
                            // validator: (value) =>
                            //     !(value!.contains('@gmail.com')) ? 'Invalid Email' : null,
                            textInputType: TextInputType.emailAddress,
                            hintText: 'Email (optional)',
                          ),
                          const SizedBox(height: 20.0),
                          CustomGradientBtn(
                            onTap: () => _submitForm(context,
                                state.status == ProfileStatus.submitting),
                            label: 'Submit',
                          )
                        ],
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}
