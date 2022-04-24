import 'package:availnear/repositories/nearby/nearby_repository.dart';
import 'package:availnear/widgets/display_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
              height: 200.0,
              width: 32.0,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          )
        : Stack(
            alignment: Alignment.topRight,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                ),
                child: DisplayImage(
                  imageUrl: imgUrl,
                  height: 200.0,
                ),
              ),
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4.0,
                    vertical: 1.0,
                  ),
                  child: RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 17.0,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 10.0,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                ),
              ),
            ],
          );
  }
}
