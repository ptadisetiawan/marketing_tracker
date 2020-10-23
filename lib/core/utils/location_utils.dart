// import 'dart:async';
import 'dart:async';

import 'package:location/location.dart';

class LocationUtils {
  static LocationUtils instance = LocationUtils();
  double latitude;
  double longitude;
  Location location = new Location();

  StreamSubscription<LocationData> locationSubscription;

  void getLocation() async {
    var _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    var _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    var _locationData = await location.getLocation();
    latitude = _locationData.latitude;
    longitude = _locationData.longitude;
    print('get location Utils');
  }

  void listeningLocation() {
    locationSubscription =
        location.onLocationChanged.listen((LocationData data) async {
      latitude = data.latitude;
      longitude = data.longitude;
      print('listen location Utils');
    });
  }
}
