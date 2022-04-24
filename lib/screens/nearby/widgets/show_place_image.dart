import '/repositories/nearby/nearby_repository.dart';
import 'package:availnear/widgets/display_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowPlaceImage extends StatefulWidget {
  final String? photoRef;
  const ShowPlaceImage({Key? key, required this.photoRef}) : super(key: key);

  @override
  State<ShowPlaceImage> createState() => _ShowPlaceImageState();
}

class _ShowPlaceImageState extends State<ShowPlaceImage> {
  String? imgUrl;

  @override
  void initState() {
    super.initState();
    getImage();
  }

  bool loading = true;

  void getImage() async {
    try {
      final photoUrl = await context
          .read<NearbyRepository>()
          .getPlacePhoto(photoRef: widget.photoRef);
      setState(() {
        imgUrl = photoUrl;
        loading = false;
      });
    } catch (error) {
      print('Error getting image ${error.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(
            child: SizedBox(
              height: 110.0,
              width: 105.0,
              child: Center(
                child: CircularProgressIndicator(strokeWidth: 2.0),
              ),
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: DisplayImage(
              imageUrl: imgUrl,
              height: 110.0,
              width: 105.0,
              fit: BoxFit.cover,
            ),
          );
  }
}
