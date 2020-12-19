import 'package:flutter/material.dart';
import 'package:marketing_tracker/core/services/auth_service.dart';
import 'package:marketing_tracker/ui/router/router_generator.dart';
import 'package:provider/provider.dart';

class DrawerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(builder: (context, authProv, _) {
      return Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                  radius: 55,
                  backgroundColor: Color(0xffFDCF09),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(authProv?.dbUser?.photoUrl ?? 'https://akusaradigital.com/profile.png'),
                  ),
                ),
              accountName: Text(authProv?.dbUser?.nama ?? ''),
              accountEmail: Text(authProv?.dbUser?.email ?? ''),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
            ListTile(
              title: Text('List anggota'),
              leading: Icon(Icons.person),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/marketing');
              },
            ),
            ListTile(
              title: Text('Edit profile'),
              leading: Icon(Icons.edit),
              onTap: () {
                Navigator.pushNamed(context, RouterGenerator.routeMarketingEdit,
                    arguments: authProv.dbUser);
              },
            ),
            ListTile(
              title: Text('Sign out'),
              leading: Icon(Icons.logout),
              onTap: () {
                Provider.of<AuthService>(context, listen: false).signOut();
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
          ],
        ),
      );
    });
  }
}
