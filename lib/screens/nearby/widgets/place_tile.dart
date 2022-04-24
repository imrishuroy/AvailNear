import 'package:availnear/models/place.dart';
import 'package:flutter/material.dart';

import 'show_place_image.dart';

class PlaceTile extends StatelessWidget {
  final Place? place;
  const PlaceTile({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _canvas = MediaQuery.of(context).size;
    final places = place?.types ?? [];
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Card(
        elevation: 5.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShowPlaceImage(
              photoRef: place?.photoRef,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10.0),
                  Text(
                    place?.name ?? 'N/A',
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 15.0,
                        color: Colors.black,
                      ),
                      const SizedBox(width: 5.0),
                      SizedBox(
                        width: _canvas.width * 0.7,
                        child: Text(
                          place?.address ?? 'N/A',
                          style: const TextStyle(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 7.0),
                  const Divider(),
                  Wrap(
                    spacing: 10.0,
                    children: places.map((type) {
                      if (type != null) {
                        return Chip(
                          backgroundColor: Colors.blue.shade600,
                          label: Text(
                            type,
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5.0),
          ],
        ),
      ),
    );
  }
}
