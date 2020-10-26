import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marketing_tracker/ui/screens/page/home_screen.dart';
import 'package:marketing_tracker/ui/screens/splash_screen.dart';

class RouterGenerator {
  static const routeHome = "/home";
  static const routeSplash = "/splash";
  // static const routeMarketingList = "/marketing";
  // static const routeMarketingDetail = "/marketing/details";

  static Route<dynamic> generateRoute(RouteSettings settings){
    // final args = settings.arguments;

    switch (settings.name) {
      case routeHome:
        return MaterialPageRoute(builder: (_) => HomeScreen());
        break;
      case routeSplash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      // case routeMarketingList:
      // return MaterialPageRoute(builder: (_) => HomeScreen());
      // break;
      // case routeMarketingDetail:
      // if (args is MarketingModel) {
      //   return MaterialPageRoute(builder: (_) => MarketingDetailScreen(
      //     restaurant: args,
      //   ));
      // }
      // break;
    }
  }
}