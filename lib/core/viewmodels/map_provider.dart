import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:marketing_tracker/core/utils/location_utils.dart';
import 'package:marketing_tracker/injector.dart';

class MapProvider extends ChangeNotifier {
  LatLng _sourceLocation;
  LatLng get sourceLocation => _sourceLocation;

  LocationUtils locationUtils = locator<LocationUtils>();

  void initLocation() async {
    await locationUtils.listeningLocation();
    _sourceLocation = LatLng(locationUtils.latitude, locationUtils.longitude);
    print('get location provider');
    notifyListeners();
  }

  void listenLocation() async {
    await locationUtils.listeningLocation();
    _sourceLocation = LatLng(locationUtils.latitude, locationUtils.longitude);
    print('listen location Provider');
    notifyListeners();
  }
}
