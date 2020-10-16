import 'package:flutter/material.dart';
import 'package:marketing_tracker/core/viewmodels/map_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Builder(
          builder: (context) {
            return Consumer<MapProvider>(
              builder: (context, mapProv, _) {
                
                if(mapProv.sourceLocation == null){
                  mapProv.initLocation();
                  return CircularProgressIndicator();
                }
                return Text(mapProv.sourceLocation.toString());
              },
            );
          },
        ),
      ),
    );
  }
}
