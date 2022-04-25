// import 'dart:async';

// import 'package:availnear/screens/search-place/models/geometry.dart';
// import 'package:availnear/screens/search-place/models/place_search.dart';
// import 'package:availnear/screens/search-place/models/place_two.dart';
// import 'package:availnear/screens/search-place/services/geo_locator_service.dart';
// import 'package:availnear/screens/search-place/services/marker_service.dart';
// import 'package:availnear/screens/search-place/services/place_service.dart';
// import 'package:flutter/foundation.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class ApplicationBloc with ChangeNotifier {
//   final geoLocatorService = GeolocatorService();
//   final placesService = PlacesService();
//   final markerService = MarkerService();

//   //Variables
//   Position? currentLocation;
//   List<PlaceSearch>? searchResults;
//   StreamController<PlaceTwo> selectedLocation = StreamController<PlaceTwo>();
//   StreamController<LatLngBounds> bounds = StreamController<LatLngBounds>();
//   PlaceTwo? selectedLocationStatic;
//   String? placeType;
//   List<PlaceTwo> ?placeResults;
//   List<Marker> markers = <Marker>[];

//   ApplicationBloc() {
//     setCurrentLocation();
//   }

//   setCurrentLocation() async {
//     currentLocation = await geoLocatorService.getCurrentLocation();
//     selectedLocationStatic = PlaceTwo(
//       name: '',
//       geometry: Geometry(
//         location: Location(
//             lat: currentLocation.latitude, lng: currentLocation.longitude),
//       ), vicinity: '',
//     );
//     notifyListeners();
//   }

//   searchPlaces(String searchTerm) async {
//     searchResults = await placesService.getAutocomplete(searchTerm);
//     notifyListeners();
//   }

//   setSelectedLocation(String placeId) async {
//     var sLocation = await placesService.getPlace(placeId);
//     selectedLocation.add(sLocation);
//     selectedLocationStatic = sLocation;
//     searchResults = null;
//     notifyListeners();
//   }

//   clearSelectedLocation() {
//     selectedLocation.add(null);
//     selectedLocationStatic = null;
//     searchResults = null;
//     placeType = null;
//     notifyListeners();
//   }

//   togglePlaceType(String value, bool selected) async {
//     if (selected) {
//       placeType = value;
//     } else {
//       placeType = null;
//     }

//     if (placeType != null) {
//       var places = await placesService.getPlaces(
//           selectedLocationStatic.geometry.location.lat,
//           selectedLocationStatic.geometry.location.lng,
//           placeType);
//       markers = [];
//       if (places.length > 0) {
//         var newMarker = markerService.createMarkerFromPlace(places[0], false);
//         markers.add(newMarker);
//       }

//       var locationMarker =
//           markerService.createMarkerFromPlace(selectedLocationStatic, true);
//       markers.add(locationMarker);

//       var _bounds = markerService.bounds(Set<Marker>.of(markers));
//       bounds.add(_bounds);

//       notifyListeners();
//     }
//   }

//   @override
//   void dispose() {
//     selectedLocation.close();
//     bounds.close();
//     super.dispose();
//   }
// }
