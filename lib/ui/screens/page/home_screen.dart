import 'package:flutter/material.dart';
import 'package:marketing_tracker/core/services/auth_service.dart';
import 'package:marketing_tracker/core/viewmodels/location_provider.dart';
import 'package:marketing_tracker/ui/screens/page/login_screen.dart';
import 'package:marketing_tracker/ui/screens/page/user_info_page.dart';
import 'package:marketing_tracker/ui/screens/splash_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final locationProv = Provider.of<LocationProvider>(context);
    locationProv.listenLocation(context);
    return Consumer(
      builder: (context, AuthService user, _) {
        switch (user.status) {
          case Status.Uninitialized:
            return SplashScreen();
          case Status.Unauthenticated:
          case Status.Authenticating:
            return LoginScreen();
          case Status.Authenticated:
            return UserInfoPage();
        }
      },
    );
  }
}
