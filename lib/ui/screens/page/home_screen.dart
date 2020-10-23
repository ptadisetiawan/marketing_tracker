import 'package:flutter/material.dart';
import 'package:marketing_tracker/core/model/user_location.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var userLocation = Provider.of<UserLocation>(context);
    return Scaffold(
      body: Center(
        child: Text(
            'Location: Lat${userLocation?.latitude}, Long: ${userLocation?.longitude}'),
      ),
    );
  }
}
