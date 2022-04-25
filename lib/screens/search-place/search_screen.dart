import 'package:availnear/widgets/loading_indicator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';
import '/repositories/nearby/nearby_repository.dart';
import '/screens/search-place/cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/search_place_photos.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search';

  const SearchScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => BlocProvider<SearchCubit>(
        create: (context) => SearchCubit(
          nearbyRepository: context.read<NearbyRepository>(),
        )..getCurrentLocation(),
        child: const SearchScreen(),
      ),
    );
  }

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _seachController = TextEditingController();
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
    return BlocConsumer<SearchCubit, SearchState>(
      listener: (context, state) {
        if (state.status == SearchStatus.succuss) {
          _addMarker(
            // markerUID: const Uuid().v4(),
            lat: state.lat,
            long: state.long,
          );
        }
      },
      builder: (context, state) {
        if (state.status == SearchStatus.searching) {
          return const Scaffold(body: LoadingIndicator());
        }
        print('State lat -- ${state.lat}');
        print('State long -- ${state.long}');
        return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            title: TextFormField(
              controller: _seachController,
              onChanged: (value) {
                context.read<SearchCubit>().searchItem(value: value);
              },
              decoration: const InputDecoration(
                hintText: 'Search Your Place 📍',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.cyan),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.cyan),
                ),
                disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.cyan),
                ),
              ),
              // collapsed(
              //   hintText: 'Search Your Place 📍',
              // ),
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _seachController.clear();
                  context.read<SearchCubit>().clear();

                  //Navigator.of(context).pop();
                },
              ),
              const SizedBox(width: 5.0),
            ],
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  const SizedBox(height: 10.0),
                  if ((state.placeDetails?.photoRefs ?? []).isNotEmpty)
                    SearchPlacePhotos(
                      photoRefs: state.placeDetails?.photoRefs ?? [],
                    ),
                  Expanded(
                    child: GoogleMap(
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target:
                            LatLng(state.lat ?? 23.2486, state.long ?? 77.5022),
                        zoom: 16.0,
                      ),
                      markers: Set<Marker>.of(markers.values),
                    ),
                  ),
                ],
              ),
              if (state.searchResults.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                    height: 250.0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: ListView.builder(
                        itemCount: state.searchResults.length,
                        itemBuilder: (context, index) {
                          final searchItem = state.searchResults[index];
                          return ListTile(
                            onTap: () async {
                              FocusScope.of(context).unfocus();
                              await context
                                  .read<SearchCubit>()
                                  .selectSearchResult(item: searchItem);
                              if (searchItem?.mainText != null) {
                                _seachController.text =
                                    searchItem?.mainText ?? '';
                              }

                              _addMarker(
                                lat: state.lat,
                                long: state.long,
                              );
                              // _addMarker(lat: 18.52, long: 18.52);

                              changeCameraPosition(
                                  lat: state.lat, long: state.long);
                            },
                            leading: CircleAvatar(
                              backgroundColor: Colors.blue.shade800,
                              child: const Icon(
                                Icons.location_pin,
                                color: Colors.white,
                              ),
                            ),
                            title: Text(
                              searchItem?.mainText ?? '',
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
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
