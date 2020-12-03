import 'package:flutter/material.dart';
import 'package:marketing_tracker/core/services/auth_service.dart';
import 'package:marketing_tracker/core/viewmodels/location_provider.dart';
import 'package:marketing_tracker/injector.dart';
import 'package:marketing_tracker/ui/router/router_generator.dart';
import 'package:provider/provider.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    LocationProvider locationProvider = locator<LocationProvider>();
    return MultiProvider(
      providers: [
        // StreamProvider(create: (context) => locationProvider.fetchLokasi()),
        ChangeNotifierProvider(create: (context) => AuthService.instance()),
        ChangeNotifierProvider(create: (context) => locationProvider),
      ],
      child: MaterialApp(
        title: 'Marketing Tracker',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: RouterGenerator.routeHome,
        onGenerateRoute: RouterGenerator.generateRoute,
      ),
    );
  }
}
