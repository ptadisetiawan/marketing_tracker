import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marketing_tracker/core/model/user_location.dart';
import 'package:marketing_tracker/core/services/auth_service.dart';
import 'package:marketing_tracker/core/viewmodels/location_provider.dart';
import 'package:marketing_tracker/ui/screens/page/login_screen.dart';
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
    locationProv.listenLocation();
    return Consumer(
      builder: (context, AuthService user, _) {
        switch (user.status) {
          case Status.Uninitialized:
            return SplashScreen();
          case Status.Unauthenticated:
          case Status.Authenticating:
            return LoginScreen();
          case Status.Authenticated:
            return UserInfoPage(user: user.user);
        }
      },
    );
  }
}

class UserInfoPage extends StatelessWidget {
  final FirebaseUser user;

  const UserInfoPage({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Info"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(user.email),
            RaisedButton(
              child: Text("SIGN OUT"),
              onPressed: () =>
                  Provider.of<AuthService>(context, listen: false).signOut(),
            )
          ],
        ),
      ),
    );
  }
}
