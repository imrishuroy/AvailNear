import '/screens/nearby/cubit/nearby_cubit.dart';

import '/widgets/display_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlacePhotos extends StatefulWidget {
  final List<String?> photoRefs;
  const PlacePhotos({Key? key, required this.photoRefs}) : super(key: key);

  @override
  State<PlacePhotos> createState() => _PlacePhotosState();
}

class _PlacePhotosState extends State<PlacePhotos> {
  @override
  void initState() {
    super.initState();
    context
        .read<NearbyCubit>()
        .getSearchPlacesPhotos(photoRefs: widget.photoRefs);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NearbyCubit, NearbyState>(
      builder: (context, state) {
        return SizedBox(
          height: 350.0,
          child: state.status == NearbyStatus.photosLoading
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SpinKitWanderingCubes(
                      color: Colors.blue,
                      size: 50.0,
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      'Searching for details...',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 200.0,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.placePhotoUrls.length,
                            itemBuilder: (contex, index) {
                              final photoUrl = state.placePhotoUrls[index];

                              return photoUrl != null
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: DisplayImage(
                                          imageUrl: photoUrl,
                                          width: 270.0,
                                        ),
                                      ),
                                    )

                                  //  Image.network(
                                  //     photoUrl,
                                  //     fit: BoxFit.cover,
                                  //   )
                                  : const SizedBox.shrink();
                            },
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          state.placeDetails?.name ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 17.0,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          state.placeDetails?.formatedAddress ?? '',
                          style: const TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                        if (state.placeDetails?.rating != null)
                          Chip(
                            backgroundColor: Colors.black,
                            label: Text(
                              '${state.placeDetails?.rating ?? 'N/A'} ⭐️',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
