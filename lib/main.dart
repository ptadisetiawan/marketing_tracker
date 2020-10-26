import 'package:flutter/material.dart';
import 'package:marketing_tracker/core/model/user_location.dart';
import 'package:marketing_tracker/core/model/user_repository.dart';
import 'package:marketing_tracker/core/services/location_service.dart';
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
    return MultiProvider(
      providers: [
        StreamProvider<UserLocation>(
            create: (context) => LocationService().locationStream),
        ChangeNotifierProvider(create: (context) => UserRepository.instance())
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
