import 'package:availnear/widgets/error_dialog.dart';

import '/models/place.dart';
import '/screens/nearby/cubit/nearby_cubit.dart';
import '/screens/nearby/widgets/place_photos.dart';

import '/widgets/loading_indicator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';
import '/repositories/nearby/nearby_repository.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NearbyDetailsArgs {
  final Place? place;

  NearbyDetailsArgs({required this.place});
}

class NearbyDetails extends StatefulWidget {
  static const String routeName = '/nearbyDetails';
  final Place? place;

  const NearbyDetails({
    Key? key,
    required this.place,
  }) : super(key: key);

  static Route route({required NearbyDetailsArgs args}) {
    return MaterialPageRoute(
      builder: (_) => BlocProvider<NearbyCubit>(
        create: (context) => NearbyCubit(
          nearbyRepository: context.read<NearbyRepository>(),
        )..getPlaceDetails(placeId: args.place?.placeId),
        child: NearbyDetails(place: args.place),
      ),
    );
  }

  @override
  State<NearbyDetails> createState() => _NearbyDetailsState();
}

class _NearbyDetailsState extends State<NearbyDetails> {
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  GoogleMapController? controller;

  void _onMapCreated(GoogleMapController? controller) {
    this.controller = controller;
  }

  @override
  void initState() {
    //final _searchCubit = context.read<SearchCubit>();

    super.initState();
    _onMapCreated(controller);
    // if (_searchCubit.state.lat != null && _searchCubit.state.long != null) {
    //   _addMarker(
    //     markerUID: 'Initial',
    //     lat: _searchCubit.state.lat,
    //     long: _searchCubit.state.long,
    //   );
    // }
    // _addMarker(
    //   markerUID: 'Initial',
    //   lat: _searchCubit.state.lat,
    //   long: _searchCubit.state.long,
    // );
  }

  MarkerId? selectedMarker;
  int _markerIdCounter = 1;

  void changeCameraPosition(
      {required double? lat, required double? long}) async {
    print('camera lat ------- $lat');
    print('camera long ------- $long');
    final cameraUpdate = CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(lat ?? 23.2486, long ?? 77.5022),
        zoom: 16.0,
      ),
    );
    controller?.animateCamera(cameraUpdate);
  }

  void _addMarker({double? lat, double? long}) {
    print('Market lat long - $lat , $long');
    final int markerCount = markers.length;

    if (markerCount == 12) {
      return;
    }
    _markerIdCounter++;
    final String markerIdVal = 'marker_id_$_markerIdCounter';
    // _markerIdCounter++;

    //final MarkerId markerId = MarkerId(markerUID);
    // const int markerCount = 1;
    //markers.length;

    if (markerCount == 12) {
      return;
    }

    //LatLng(23.2486, 77.5022);
    final id = const Uuid().v4();
    final MarkerId markerId = MarkerId(id);
    final Marker marker = Marker(
      markerId: markerId,
      // position: LatLng(
      //   lat ?? 23.2486 + sin(_markerIdCounter * pi / 6.0) / 20.0,
      //   lat ?? 777.5022 + cos(_markerIdCounter * pi / 6.0) / 20.0,
      // ),
      position: LatLng(lat ?? 23.2486, long ?? 77.5022),
      // center.latitude + sin(_markerIdCounter * pi / 6.0) / 20.0,
      // center.longitude + cos(_markerIdCounter * pi / 6.0) / 20.0,

      infoWindow: InfoWindow(title: markerIdVal, snippet: '*'),
      onTap: () {},
      // _onMarkerTapped(markerId),
      // onDragEnd: (LatLng position) => _onMarkerDragEnd(markerId, position),
      // onDrag: (LatLng position) => _onMarkerDrag(markerId, position),
    );

    setState(() {
      markers[markerId] = marker;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NearbyCubit, NearbyState>(
      listener: (context, state) {
        if (state.status == NearbyStatus.error) {
          showDialog(
            context: context,
            builder: (_) => ErrorDialog(content: state.failure.message),
          );
        }
        if (state.status == NearbyStatus.succuss) {
          _addMarker(
            // markerUID: const Uuid().v4(),
            lat: widget.place?.lat?.toDouble(),
            long: widget.place?.lat?.toDouble(),
          );
        }
      },
      builder: (context, state) {
        if (state.status == NearbyStatus.loading) {
          return const Scaffold(body: LoadingIndicator());
        }

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            title: Text(
              state.placeDetails?.name ?? '',
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  const SizedBox(height: 10.0),
                  if ((state.placeDetails?.photoRefs ?? []).isNotEmpty)
                    PlacePhotos(photoRefs: state.placeDetails?.photoRefs ?? []),
                  Expanded(
                    child: GoogleMap(
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(widget.place?.lat?.toDouble() ?? 23.2486,
                            widget.place?.lng?.toDouble() ?? 77.5022),
                        zoom: 16.0,
                      ),
                      markers: Set<Marker>.of(markers.values),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(state.placeDetails);
                        },
                        icon: const Icon(
                          Icons.pin_drop,
                          size: 20.0,
                        ),
                        label: const Text(
                          'Pick this location',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.8,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
        // if (state.status == SearchStatus.loading) {
        //   return const LoadingIndicator();
        // } else {
        //   print('Status-- ${state.status}');
        // }
      },
    );
  }
}
