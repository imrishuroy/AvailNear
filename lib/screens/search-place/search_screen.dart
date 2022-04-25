import 'package:google_maps_flutter/google_maps_flutter.dart';
import '/repositories/nearby/nearby_repository.dart';
import '/screens/search-place/cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  //Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController controller) {
    this.controller = controller;
  }

  @override
  void initState() {
    super.initState();
    _addMarker();
  }

  MarkerId? selectedMarker;
  final int _markerIdCounter = 1;

  void changeCameraPosition({required double lat, required long}) async {
    final cameraUpdate = CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(lat, long),
        zoom: 16.0,
      ),
    );

    //final GoogleMapController controller = await _controller.future;
    // controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
    controller?.animateCamera(cameraUpdate);
  }

  void _addMarker({double? lat, double? long}) {
    const int markerCount = 1;
    //markers.length;

    if (markerCount == 12) {
      return;
    }

    final String markerIdVal = 'marker_id_$_markerIdCounter';
    //  _markerIdCounter++;
    final MarkerId markerId = MarkerId(markerIdVal);
    //LatLng(23.2486, 77.5022);
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(lat ?? 23.2486, long ?? 77.5022
          // center.latitude + sin(_markerIdCounter * pi / 6.0) / 20.0,
          // center.longitude + cos(_markerIdCounter * pi / 6.0) / 20.0,
          ),
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
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            title: TextFormField(
              controller: _seachController,
              onChanged: (value) {
                context.read<SearchCubit>().searchItem(value: value);
                // if (state.lat != null && state.long != null) {
                //   _addMarker(lat: state.lat, long: state.long);

                //   changeCameraPosition(lat: state.lat!, long: state.long);
                // }
              },
              decoration: const InputDecoration.collapsed(
                hintText: 'Search your place...',
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  context.read<SearchCubit>().clear();
                },
              ),
              const SizedBox(width: 5.0),
            ],
          ),
          // floatingActionButton: FloatingActionButton(onPressed: () async {
          //   final result = await context
          //       .read<NearbyRepository>()
          //       .getPlaceDetails(placeId: 'ChIJh09POeRBfDkR7F3OBkKju7M');
          //   print('Place details $result');
          // }),
          body: Stack(
            children: [
              // MapView1(lat: state.lat, long: state.long),
              Column(
                children: [
                  Expanded(
                    child: GoogleMap(
                      // onMapCreated: (GoogleMapController controller) {
                      //   _controller.complete(controller);
                      // },

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
                      color: Colors.grey.shade200,
                    ),
                    height: 250.0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: ListView.builder(
                        itemCount: state.searchResults.length,
                        itemBuilder: (context, index) {
                          final searchItem = state.searchResults[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                              vertical: 10.0,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                if (searchItem?.mainText != null) {
                                  _seachController.text =
                                      searchItem?.mainText ?? '';
                                }

                                if (state.lat != null && state.long != null) {
                                  _addMarker(lat: state.lat, long: state.long);

                                  changeCameraPosition(
                                      lat: state.lat!, long: state.long);
                                }

                                context
                                    .read<SearchCubit>()
                                    .selectSearchResult(item: searchItem);
                              },
                              child: Text(
                                searchItem?.mainText ?? '',
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.blue,
                                ),
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
                      // ElevatedButton.icon(
                      //   onPressed: () {
                      //     context.read<SearchCubit>().getCurrentLocation();
                      //     if (state.lat != null && state.long != null) {
                      //       print('State lat ${state.lat}');
                      //       print('State lat ${state.long}');
                      //       _addMarker(lat: state.lat, long: state.long);

                      //       changeCameraPosition(
                      //           lat: state.lat!, long: state.long);
                      //     }
                      //   },
                      //   icon: const Icon(Icons.my_location),
                      //   label: const Text(
                      //     'Current Location',
                      //     style: TextStyle(
                      //       fontSize: 16.0,
                      //       fontWeight: FontWeight.w600,
                      //       letterSpacing: 0.9,
                      //     ),
                      //   ),
                      // ),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).pop(state.placeDetails);
                        },
                        icon: const Icon(Icons.pin_drop),
                        label: const Text(
                          'Pick This Location',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.9,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )

              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
              //   child: Column(
              //     children: [
              //       CustomTextField(
              //         controller: _seachController,
              //         //  initialValue: state.initialText,
              //         hintText: 'Search your place',
              //         onChanged: (value) =>
              //             context.read<SearchCubit>().searchItem(value: value),
              //         validator: (value) {
              //           if (value!.isEmpty) {
              //             return 'Search text can\'t be empty';
              //           }
              //           return null;
              //         },
              //         textInputType: TextInputType.streetAddress,
              //         // TODO: add initial text here
              //       ),
              //       const SizedBox(height: 10.0),

              //     ],
              //   ),
              // ),
            ],
          ),

          //  BlocConsumer<SearchCubit, SearchState>(
          //   listener: (context, state) {},
          //   builder: (context, state) {
          //     print('Current location ${state.locationData}');
          //     print('Screen lat  text ${state.lat}');
          //     print('Screen long ${state.long}');
          //     return
          //   },
          // ),
        );
      },
    );
  }
}
