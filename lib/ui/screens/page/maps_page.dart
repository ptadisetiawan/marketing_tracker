import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:marketing_tracker/core/model/user_location.dart';
import 'package:marketing_tracker/core/viewmodels/location_provider.dart';
import 'package:marketing_tracker/ui/screens/items/drawer.dart';
import 'package:provider/provider.dart';

class MapsPage extends StatefulWidget {
  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  List<UserLocation> lokasiList;
  final Set<Marker> _markers = {};
  BitmapDescriptor _customIcon;
  // double _pinPillPosition = -100;
 
  void _setCustomIcon() async {
    _customIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'images/location.png');
  }

  @override
  void initState() {
    _setCustomIcon();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final locationProv = Provider.of<LocationProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Marketing Tracker')),
      drawer: DrawerApp(),
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
                        icon: _customIcon,
                        infoWindow: InfoWindow(
                          title: lokasiList[i].email,
                        ),
                        onTap: () {
                          // _pinPillPosition = 0;
                        }),
                  );
                }
                return Stack(children: [
                  Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(-8.635461528045065, 115.1909955967761),
                          zoom: 10.0,
                        ),
                        markers: _markers,
                      )),
                  // AnimatedPositioned(
                  //   bottom: _pinPillPosition,
                  //   right: 0,
                  //   left: 0,
                  //   duration: Duration(milliseconds: 200),
                  //   child: Align(
                  //     alignment: Alignment.bottomCenter,
                  //     child: Container(
                  //       margin: EdgeInsets.all(20),
                  //       height: 70,
                  //       decoration: BoxDecoration(
                  //           color: Colors.white,
                  //           borderRadius: BorderRadius.all(Radius.circular(50)),
                  //           boxShadow: <BoxShadow>[
                  //             BoxShadow(
                  //               blurRadius: 20,
                  //               offset: Offset.zero,
                  //               color: Colors.grey.withOpacity(0.5),
                  //             )
                  //           ]),
                  //       child: Row(
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: <Widget>[Text('Hello')],
                  //       ),
                  //     ),
                  //   ),
                  // )
                ]);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
