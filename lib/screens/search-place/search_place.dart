// import 'dart:async';
// import 'dart:math';

// // TODO : https://github.com/nhandrew/google_places_autocomplete/blob/main/lib/src/screens/home_screen.dart
// // TODO: Implement this

// import 'package:availnear/.env.dart';
// import 'package:google_api_headers/google_api_headers.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_google_places/flutter_google_places.dart';
// import 'package:google_maps_webservice/places.dart';

// class SearchPlace extends StatefulWidget {
//   const SearchPlace({Key? key}) : super(key: key);

//   @override
//   _SearchPlaceState createState() => _SearchPlaceState();
// }

// final homeScaffoldKey = GlobalKey<ScaffoldState>();
// final searchScaffoldKey = GlobalKey<ScaffoldState>();

// class _SearchPlaceState extends State<SearchPlace> {
//   Mode? _mode = Mode.overlay;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: homeScaffoldKey,
//       appBar: AppBar(
//         title: const Text("My App"),
//       ),
//       body: Center(
//           child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           _buildDropdownMenu(),
//           ElevatedButton(
//             onPressed: _handlePressButton,
//             child: const Text("Search places"),
//           ),
//           ElevatedButton(
//             child: const Text("Custom"),
//             onPressed: () {
//               Navigator.of(context).pushNamed("/search");
//             },
//           ),
//         ],
//       )),
//     );
//   }

//   Widget _buildDropdownMenu() => DropdownButton(
//         value: _mode,
//         items: const <DropdownMenuItem<Mode>>[
//           DropdownMenuItem<Mode>(
//             child: Text("Overlay"),
//             value: Mode.overlay,
//           ),
//           DropdownMenuItem<Mode>(
//             child: Text("Fullscreen"),
//             value: Mode.fullscreen,
//           ),
//         ],
//         onChanged: (dynamic m) {
//           setState(() {
//             _mode = m;
//           });
//         },
//       );

//   void onError(PlacesAutocompleteResponse response) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(response.errorMessage!)),
//     );
//   }

//   Future<void> _handlePressButton() async {
//     // show input autocomplete with selected mode
//     // then get the Prediction selected
//     Prediction? p = await PlacesAutocomplete.show(
//       context: context,
//       apiKey: kGoogleApiKey,
//       onError: onError,
//       mode: _mode!,
//       language: "fr",
//       decoration: InputDecoration(
//         hintText: 'Search',
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(20),
//           borderSide: const BorderSide(
//             color: Colors.white,
//           ),
//         ),
//       ),
//       components: [Component(Component.country, "fr")],
//     );

//     displayPrediction(p, context);
//   }
// }

// Future<void> displayPrediction(Prediction? p, BuildContext context) async {
//   if (p != null) {
//     // get detail (lat/lng)
//     GoogleMapsPlaces _places = GoogleMapsPlaces(
//       apiKey: kGoogleApiKey,
//       apiHeaders: await const GoogleApiHeaders().getHeaders(),
//     );
//     PlacesDetailsResponse detail =
//         await _places.getDetailsByPlaceId(p.placeId!);
//     final lat = detail.result.geometry!.location.lat;
//     final lng = detail.result.geometry!.location.lng;

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("${p.description} - $lat/$lng")),
//     );
//   }
// }

// // custom scaffold that handle search
// // basically your widget need to extends [GooglePlacesAutocompleteWidget]
// // and your state [GooglePlacesAutocompleteState]
// class CustomSearchScaffold extends PlacesAutocompleteWidget {
//   CustomSearchScaffold({Key? key})
//       : super(
//           key: key,
//           apiKey: kGoogleApiKey,
//           sessionToken: Uuid().generateV4(),
//           language: "en",
//           components: [Component(Component.country, "uk")],
//         );

//   @override
//   _CustomSearchScaffoldState createState() => _CustomSearchScaffoldState();
// }

// class _CustomSearchScaffoldState extends PlacesAutocompleteState {
//   @override
//   Widget build(BuildContext context) {
//     final appBar = AppBar(title: AppBarPlacesAutoCompleteTextField());
//     final body = PlacesAutocompleteResult(
//       onTap: (p) {
//         displayPrediction(p, context);
//       },
//       logo: Row(
//         children: const [FlutterLogo()],
//         mainAxisAlignment: MainAxisAlignment.center,
//       ),
//     );
//     return Scaffold(key: searchScaffoldKey, appBar: appBar, body: body);
//   }

//   @override
//   void onResponseError(PlacesAutocompleteResponse response) {
//     super.onResponseError(response);
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(response.errorMessage!)),
//     );
//   }

//   @override
//   void onResponse(PlacesAutocompleteResponse? response) {
//     super.onResponse(response);
//     if (response != null && response.predictions.isNotEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Got answer")),
//       );
//     }
//   }
// }

// class Uuid {
//   final Random _random = Random();

//   String generateV4() {
//     // Generate xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx / 8-4-4-4-12.
//     final int special = 8 + _random.nextInt(4);

//     return '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}-'
//         '${_bitsDigits(16, 4)}-'
//         '4${_bitsDigits(12, 3)}-'
//         '${_printDigits(special, 1)}${_bitsDigits(12, 3)}-'
//         '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}';
//   }

//   String _bitsDigits(int bitCount, int digitCount) =>
//       _printDigits(_generateBits(bitCount), digitCount);

//   int _generateBits(int bitCount) => _random.nextInt(1 << bitCount);

//   String _printDigits(int value, int count) =>
//       value.toRadixString(16).padLeft(count, '0');
// }




// // import 'dart:async';
// // import 'package:availnear/.env.dart';
// // import 'package:google_maps_webservice/places.dart';
// // import 'package:flutter_google_places/flutter_google_places.dart';
// // import 'package:flutter/material.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:location/location.dart' as location_manager;

// // GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

// // class SearchPlace extends StatefulWidget {
// //   const SearchPlace({Key? key}) : super(key: key);

// //   @override
// //   State<StatefulWidget> createState() {
// //     return SearchPlaceState();
// //   }
// // }

// // class SearchPlaceState extends State<SearchPlace> {
// //   final homeScaffoldKey = GlobalKey<ScaffoldState>();
// //   late GoogleMapController mapController;
// //   List<PlacesSearchResult> places = [];
// //   bool isLoading = false;
// //   String? errorMessage;

// //   @override
// //   Widget build(BuildContext context) {
// //     Widget expandedChild;
// //     if (isLoading) {
// //       expandedChild =
// //           const Center(child: CircularProgressIndicator(value: null));
// //     } else if (errorMessage != null) {
// //       expandedChild = Center(
// //         child: Text(errorMessage ?? ''),
// //       );
// //     } else {
// //       expandedChild = buildPlacesList();
// //     }

// //     return Scaffold(
// //         key: homeScaffoldKey,
// //         appBar: AppBar(
// //           title: const Text('PlaceZ'),
// //           actions: <Widget>[
// //             isLoading
// //                 ? IconButton(
// //                     icon: const Icon(Icons.timer),
// //                     onPressed: () {},
// //                   )
// //                 : IconButton(
// //                     icon: const Icon(Icons.refresh),
// //                     onPressed: () {
// //                       refresh();
// //                     },
// //                   ),
// //             IconButton(
// //               icon: const Icon(Icons.search),
// //               onPressed: () {
// //                 _handlePressButton();
// //               },
// //             ),
// //           ],
// //         ),
// //         body: Column(
// //           children: <Widget>[
// //             SizedBox(
// //               height: 200.0,
// //               child: GoogleMap(
// //                 onMapCreated: _onMapCreated,
// //                 initialCameraPosition: CameraPosition(
// //                   target: LatLng(0.0, 0.0),
// //                 ),
// //               ),
// //             ),

// //             // options: GoogleMapOptions(
// //             //     myLocationEnabled: true,
// //             //     cameraPosition:
// //             //         const CameraPosition(target: LatLng(0.0, 0.0))), initialCameraPosition: null,)),
// //             Expanded(child: expandedChild)
// //           ],
// //         ));
// //   }

// //   void refresh() async {
// //     final center = await getUserLocation();

// //     mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
// //         target: center == null ? LatLng(0, 0) : center, zoom: 15.0)));
// //     getNearbyPlaces(center!);
// //   }

// //   void _onMapCreated(GoogleMapController controller) async {
// //     mapController = controller;
// //     refresh();
// //   }

// //   Future<LatLng?> getUserLocation() async {
// //     location_manager.LocationData locationData;
// //     final location = location_manager.Location();
// //     try {
// //       locationData = await location.getLocation();
// //       final lat = locationData.latitude;
// //       final lng = locationData.longitude;
// //       final center = LatLng(lat!, lng!);
// //       return center;
// //     } on Exception {
// //       // currentLocation = null;
// //       // return null;
// //     }
// //   }

// //   void getNearbyPlaces(LatLng center) async {
// //     setState(() {
// //       this.isLoading = true;
// //       this.errorMessage = null;
// //     });

// //     final location = Location(lat: center.latitude, lng: center.longitude);
// //     final result = await _places.searchNearbyWithRadius(location, 2500);
// //     setState(() {
// //       this.isLoading = false;
// //       if (result.status == "OK") {
// //         this.places = result.results;
// //         result.results.forEach((f) {
// //           final markerOptions = Marker(
// //             position:
// //                 LatLng(f.geometry!.location.lat, f.geometry!.location.lng),
// //             infoWindow: InfoWindow(title: "${f.name}", snippet: '*'),
// //             markerId: MarkerId('amamam'),
// //           );
// //           // infoWindowText: InfoWindowText("${f.name}", "${f.types?.first}"));
// //           // mapController

// //           // .addMarker(markerOptions);
// //         });
// //       } else {
// //         this.errorMessage = result.errorMessage;
// //       }
// //     });
// //   }

// //   void onError(PlacesAutocompleteResponse response) {
// //     //  homeScaffoldKey.currentState.showSnackBar(
// //     // SnackBar(content: Text(response.errorMessage)),
// //     // );
// //   }

// //   Future<void> _handlePressButton() async {
// //     try {
// //       final center = await getUserLocation();
// //       Prediction? p = await PlacesAutocomplete.show(
// //           context: context,
// //           strictbounds: center == null ? false : true,
// //           apiKey: kGoogleApiKey,
// //           onError: onError,
// //           mode: Mode.fullscreen,
// //           language: "en",
// //           location: center == null
// //               ? null
// //               : Location(lat: center.latitude, lng: center.longitude),
// //           radius: center == null ? null : 10000);

// //       showDetailPlace(p?.placeId ?? '');
// //     } catch (e) {
// //       return;
// //     }
// //   }

// //   Future<Null> showDetailPlace(String placeId) async {
// //     if (placeId != null) {
// //       // Navigator.push(
// //       //   context,
// //       //   MaterialPageRoute(builder: (context) => PlaceDetailWidget(placeId)),
// //       // );
// //     }
// //   }

// //   ListView buildPlacesList() {
// //     final placesWidget = places.map((f) {
// //       List<Widget> list = [
// //         Padding(
// //           padding: EdgeInsets.only(bottom: 4.0),
// //           child: Text(
// //             f.name,
// //             //style: Theme.of(context).textTheme.subtitle,
// //           ),
// //         )
// //       ];
// //       if (f.formattedAddress != null) {
// //         list.add(Padding(
// //           padding: EdgeInsets.only(bottom: 2.0),
// //           child: Text(
// //             f.formattedAddress ?? '',
// //             style: Theme.of(context).textTheme.subtitle1,
// //           ),
// //         ));
// //       }

// //       if (f.vicinity != null) {
// //         list.add(Padding(
// //           padding: EdgeInsets.only(bottom: 2.0),
// //           child: Text(
// //             f.vicinity ?? '',
// //             style: Theme.of(context).textTheme.bodyText2,
// //           ),
// //         ));
// //       }

// //       if (f.types?.first != null) {
// //         list.add(Padding(
// //           padding: EdgeInsets.only(bottom: 2.0),
// //           child: Text(
// //             f.types.first,
// //             style: Theme.of(context).textTheme.caption,
// //           ),
// //         ));
// //       }

// //       return Padding(
// //         padding: EdgeInsets.only(top: 4.0, bottom: 4.0, left: 8.0, right: 8.0),
// //         child: Card(
// //           child: InkWell(
// //             onTap: () {
// //               showDetailPlace(f.placeId);
// //             },
// //             highlightColor: Colors.lightBlueAccent,
// //             splashColor: Colors.red,
// //             child: Padding(
// //               padding: EdgeInsets.all(8.0),
// //               child: Column(
// //                 mainAxisAlignment: MainAxisAlignment.start,
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: list,
// //               ),
// //             ),
// //           ),
// //         ),
// //       );
// //     }).toList();

// //     return ListView(shrinkWrap: true, children: placesWidget);
// //   }
// // }
