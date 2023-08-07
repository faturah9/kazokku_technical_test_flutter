import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kazokku_technical_test/features/home/presentation/pages/home_page.dart';

import '../common/constants/router_constants.dart';
import '../features/users/presentation/pages/users_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    return CupertinoPageRoute(builder: (context) {
      switch (settings.name) {
        case RouteName.homeRoute:
          return const HomePage();
        case RouteName.usersRoute:
          return const UsersPage();

        default:
          return Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          );
      }
    });
  }
}
