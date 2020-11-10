import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:marketing_tracker/core/services/auth_service.dart';
import 'package:marketing_tracker/core/services/firestore_service.dart';
import 'package:marketing_tracker/injector.dart';
import 'package:provider/provider.dart';

class LocationProvider extends ChangeNotifier {
  Location location = new Location();
  FirestoreService firestoreService = locator<FirestoreService>();

  void listenLocation(BuildContext context) {
    final auth = Provider.of<AuthService>(context);

    location.requestPermission().then((granted) {
      if (granted != null) {
        // If granted listen to the onLocationChanged stream and emit over our controller
        // locationSubscription =
        location.onLocationChanged.listen((locationData) {
          if (locationData != null) {
            print(auth.status.toString());
            if (auth.status == Status.Authenticated) {
              print(locationData.latitude);
              print('authenticated');
              firestoreService.setDataLokasi(id: auth.user.email, data: {
                "latitude": locationData.latitude,
                "longitude": locationData.longitude
              });
            } else {
              print('unauthenticated');
            }
            notifyListeners();
          }
        });
      }
    });
  }
}
