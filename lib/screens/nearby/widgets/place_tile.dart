import '/models/place.dart';
import '/screens/post/widgets/map_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'show_place_image.dart';

//https://www.google.com/search?q=restaurants&oq=restaurants&aqs=chrome..69i57j69i59.2666j0j1&sourceid=chrome&ie=UTF-8
class PlaceTile extends StatelessWidget {
  final Place? place;
  const PlaceTile({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _canvas = MediaQuery.of(context).size;
    //final places = place?.types ?? [];
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const MapView(),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                ShowPlaceImage(
                  photoRef: place?.photoRef,
                ),
                const SizedBox(width: 15.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: _canvas.width * 0.55,
                      height: 20.0,
                      child: Text(
                        place?.name ?? 'N/A',
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Row(
                      children: [
                        RatingBar.builder(
                          initialRating: place?.rating ?? 0,
                          minRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 17.0,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 2.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 10.0,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                        const SizedBox(width: 5.0),
                        if (place?.rattingCount != null)
                          Text('(${place?.rattingCount})'),
                      ],
                    ),
                    const SizedBox(height: 5.0),
                    SizedBox(
                      width: _canvas.width * 0.55,
                      child: Text(
                        place?.address ?? 'N/A',
                        style: const TextStyle(),
                      ),
                    ),
                    const SizedBox(height: 7.0),
                    if (place?.isOpen != null)
                      Text(
                        place!.isOpen! ? '' : 'Closed',
                        style: TextStyle(
                          color:
                              place!.isOpen! ? Colors.blue : Colors.redAccent,
                        ),
                      ),
                    const SizedBox(height: 5.0),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 15.0),
            const Divider(color: Colors.grey),
            const SizedBox(height: 5.0),
          ],
        ),
      ),
    );

    // Card(
    //   elevation: 5.0,
    //   shape:
    //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       ShowPlaceImage(
    //         photoRef: place?.photoRef,
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 18.0),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             const SizedBox(height: 10.0),
    //             Text(
    //               place?.name ?? 'N/A',
    //               style: const TextStyle(
    //                 fontSize: 18.0,
    //                 fontWeight: FontWeight.w600,
    //               ),
    //             ),
    //             const SizedBox(height: 10.0),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.start,
    //               children: [
    //                 const Icon(
    //                   Icons.location_on,
    //                   size: 15.0,
    //                   color: Colors.black,
    //                 ),
    //                 const SizedBox(width: 5.0),
    //                 SizedBox(
    //                   width: _canvas.width * 0.7,
    //                   child: Text(
    //                     place?.address ?? 'N/A',
    //                     style: const TextStyle(),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //             const SizedBox(height: 7.0),
    //             const Divider(),
    //             Wrap(
    //               spacing: 10.0,
    //               children: places.map((type) {
    //                 if (type != null) {
    //                   return Chip(
    //                     backgroundColor: Colors.blue.shade600,
    //                     label: Text(
    //                       type,
    //                       style: const TextStyle(color: Colors.white),
    //                     ),
    //                   );
    //                 } else {
    //                   return const SizedBox.shrink();
    //                 }
    //               }).toList(),
    //             ),
    //           ],
    //         ),
    //       ),
    //       const SizedBox(height: 5.0),
    //     ],
    //   ),
    // ),
    // );
  }
}
