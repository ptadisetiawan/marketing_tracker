import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:marketing_tracker/core/services/firestore_service.dart';
import 'package:marketing_tracker/injector.dart';

class LocationProvider extends ChangeNotifier {
  Location location = new Location();
  FirestoreService firestoreService = locator<FirestoreService>();
  // StreamSubscription<LocationData> locationSubscription;
  void listenLocation() {
    location.requestPermission().then((granted) {
      if (granted != null) {
        // If granted listen to the onLocationChanged stream and emit over our controller
        // locationSubscription =
        location.onLocationChanged.listen((locationData) {
          if (locationData != null) {
            print(locationData.latitude);
            firestoreService.setDataLokasi(id: '1', data: {
              "latitude": locationData.latitude,
              "longitude": locationData.longitude
            });
            notifyListeners();
          }
        });
      }
    });
  }
}
