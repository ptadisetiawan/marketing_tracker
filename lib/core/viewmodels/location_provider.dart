import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:marketing_tracker/core/services/auth_service.dart';
import 'package:marketing_tracker/core/services/firestore_service.dart';
import 'package:marketing_tracker/injector.dart';
import 'package:provider/provider.dart';

class LocationProvider extends ChangeNotifier {
  Location location = new Location();
  FirestoreService firestoreService = locator<FirestoreService>();
  double lat = 0.0;
  // double get lat => _lat;
  double long = 0.0;
  // double get long => _long;
  int detik = 0;
  int detikHistory = 0;

  void listenLocation(BuildContext context) {
    final auth = Provider.of<AuthService>(context);

    location.requestPermission().then((granted) {
      if (granted != null) {
        location.onLocationChanged.listen((locationData) {
          if (locationData != null) {
            if (auth.status == Status.Authenticated) {
              if(lat != locationData.latitude && long != locationData.longitude){
                detik = detik + 1;
                detikHistory = detikHistory + 1;
                if(detik > 5){
                  detik = 0;
                   firestoreService.setDataLokasi(id: auth.user.email, data: {
                    "latitude": locationData.latitude,
                    "longitude": locationData.longitude,
                    "email" : auth.user.email
                  });
                } 
                if(detikHistory > 10){
                  detikHistory = 0;
                   firestoreService.setHistoryLokasi(data: {
                    "latitude": locationData.latitude,
                    "longitude": locationData.longitude,
                    "email" : auth.user.email
                  });
                } 
                lat = locationData.latitude;
                long = locationData.longitude;
              }
            } 
            notifyListeners();
          }
        });
      }else{
        print('not granted');
      }
    });
  }

  Stream<QuerySnapshot> fetchLokasi(){
    return firestoreService.getLokasiList();
  }

  
}
