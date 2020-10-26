import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
import 'package:marketing_tracker/core/model/user_location.dart';

class LocationService {
  UserLocation _currentLocation;

  CollectionReference lokasiRef =
      Firestore.instance.collection('user_location');

  var location = Location();
  StreamController<UserLocation> _locationController =
      StreamController<UserLocation>();
  Stream<UserLocation> get locationStream => _locationController.stream;

  LocationService() {
    location.requestPermission().then((granted) {
      if (granted != null) {
        location.onLocationChanged.listen((locationData) {
          if (locationData != null) {
            var data = UserLocation(
                latitude: locationData.latitude,
                longitude: locationData.longitude);
            _locationController.add(data);
            lokasiRef.document('1').setData({
              'latitude': locationData.latitude.toString(),
              'longitude': locationData.longitude.toString()
            });
            // print('sent');
          }
        });
      }
    });
  }

  Future<UserLocation> getLocation() async {
    try {
      var userLocation = await location.getLocation();
      _currentLocation = UserLocation(
          latitude: userLocation.latitude, longitude: userLocation.longitude);
    } on Exception catch (e) {
      print('Could not get location: ${e.toString()}');
    }
    return _currentLocation;
  }
}
