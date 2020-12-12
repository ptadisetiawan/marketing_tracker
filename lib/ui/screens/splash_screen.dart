import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // @override
  // void initState() {
  //   startSplashScreen();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image(image: AssetImage('images/logo.png')),
      ),
    );
  }

  // startSplashScreen() async {
  //   var duration = Duration(seconds: 3);
  //   return Timer(duration, () {
  //     Navigator.pushNamed(context, '/login');
  //   });
  // }
}
