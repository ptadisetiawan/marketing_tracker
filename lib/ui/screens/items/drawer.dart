import 'package:flutter/material.dart';
import 'package:marketing_tracker/core/services/auth_service.dart';
import 'package:provider/provider.dart';

class DrawerApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (context, authProv, _){
        return Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(authProv.user.email ?? ''),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
             ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
            ListTile(
              title: Text('List anggota'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/marketing');
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
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
          ],
        ),
      );
      } 
    );
  }
}
