import 'package:availnear/models/failure.dart';
import 'package:geocoding/geocoding.dart' as geo;

import 'package:location/location.dart';

class LocationUtil {
  static Future<LocationData?> getCurrentLocation() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    _locationData = await location.getLocation();

    return _locationData;
  }

  static Future<String?> getCurrentAddress() async {
    try {
      final locationData = await getCurrentLocation();
      if (locationData != null) {
        List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
            locationData.latitude!, locationData.longitude!);
        var first = placemarks.first;
        final String address = '${first.locality}, ${first.subLocality}';
        //first.administrativeArea
        print(
            'complete address ${first.locality}, ${first.administrativeArea},${first.subLocality}, ${first.subAdministrativeArea},${first.street}, ${first.name},${first.thoroughfare}, ${first.subThoroughfare}');

        return address;
      }
      return null;
    } catch (error) {
      print('Error in gettin user current address ${error.toString()}');
      throw const Failure(message: 'Error in getting user current address');
    }
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  // static Future<Position?> determinePosition() async {
  //   try {
  //     bool serviceEnabled;
  //     LocationPermission permission;

  //     // Test if location services are enabled.
  //     serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //     if (!serviceEnabled) {
  //       // Location services are not enabled don't continue
  //       // accessing the position and request users of the
  //       // App to enable the location services.
  //       return Future.error('Location services are disabled.');
  //     }

  //     permission = await Geolocator.checkPermission();
  //     if (permission == LocationPermission.denied) {
  //       permission = await Geolocator.requestPermission();
  //       if (permission == LocationPermission.denied) {
  //         // Permissions are denied, next time you could try
  //         // requesting permissions again (this is also where
  //         // Android's shouldShowRequestPermissionRationale
  //         // returned true. According to Android guidelines
  //         // your App should show an explanatory UI now.
  //         return Future.error('Location permissions are denied');
  //       }
  //     }

  //     if (permission == LocationPermission.deniedForever) {
  //       // Permissions are denied forever, handle appropriately.
  //       return Future.error(
  //           'Location permissions are permanently denied, we cannot request permissions.');
  //     }

  //     // When we reach here, permissions are granted and we can
  //     // continue accessing the position of the device.
  //     return await Geolocator.getCurrentPosition();
  //   } catch (error) {
  //     print('Error in gettin user current location ${error.toString()}');
  //     throw const Failure(message: 'Error in getting current location');
  //   }
  // }
}
