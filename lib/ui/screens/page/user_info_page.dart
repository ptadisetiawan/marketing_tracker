import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:marketing_tracker/core/model/user_location.dart';
import 'package:marketing_tracker/core/services/auth_service.dart';
import 'package:marketing_tracker/core/viewmodels/location_provider.dart';
import 'package:provider/provider.dart';

class UserInfoPage extends StatefulWidget {
  final FirebaseUser user;
  UserInfoPage({Key key, this.user}) : super(key: key);
  

  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  List<UserLocation> lokasiList;
  final Set<Marker> _markers = {};
  // GlobalKey iconKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final locationProv = Provider.of<LocationProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Marketing Tracker')),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(widget.user.email),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('List anggota'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
             ListTile(
              title: Text('Edit profile'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('Sign out'),
              onTap: () {
                Provider.of<AuthService>(context, listen: false).signOut();
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: StreamBuilder(
            stream: locationProv.fetchLokasi(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                lokasiList = snapshot.data.documents
                    .map((doc) => UserLocation.fromMap(doc.data))
                    .toList();
                for (int i = 0; i < lokasiList.length; i++) {
                  _markers.add(
                    Marker(
                      markerId: MarkerId(lokasiList[i].email),
                      position: LatLng(
                          lokasiList[i].latitude, lokasiList[i].longitude),
                      icon: BitmapDescriptor.defaultMarker,
                    ),
                  );
                }
                return Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(-8.4918052, 115.4523402),
                        zoom: 14.0,
                      ),
                      markers: _markers,
                    ));
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }

 
}
