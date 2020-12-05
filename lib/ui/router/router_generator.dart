import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marketing_tracker/core/model/user.dart';
import 'package:marketing_tracker/ui/screens/page/home_screen.dart';
import 'package:marketing_tracker/ui/screens/page/login_screen.dart';
import 'package:marketing_tracker/ui/screens/page/marketing_list_page.dart';
import 'package:marketing_tracker/ui/screens/page/user_detail_page.dart';
import 'package:marketing_tracker/ui/screens/page/user_info_page.dart';
import 'package:marketing_tracker/ui/screens/splash_screen.dart';

class RouterGenerator {
  static const routeHome = "/home";
  static const routeSplash = "/splash";
  static const routeLogin = "/login";
  static const routeMaps = "/maps";
  static const routeMarketingList = "/marketing";
  static const routeMarketingDetail = "/marketing/details";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case routeHome:
        return MaterialPageRoute(builder: (_) => HomeScreen());
        break;
      case routeSplash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
        break;
      case routeLogin:
        return MaterialPageRoute(builder: (_) => LoginScreen());
        break;
      case routeMaps:
        return MaterialPageRoute(
            builder: (_) => UserInfoPage());
        break;
      case routeMarketingList:
          return MaterialPageRoute(
              builder: (_) => MarketingListPage());
        break;
      case routeMarketingDetail:
      if (args is User) {
        return MaterialPageRoute(builder: (_) => UserDetailPage(
          userDetail: args,
        ));
      }
      break;
    }
  }
}
