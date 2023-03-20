import 'package:flutter/material.dart';
import '../pages/homepage.dart';
import '../pages/loginpage.dart';
import '../pages/settings.dart';
import '../pages/menuPage.dart';

const String homePage = '/';
const String loginPage = '/login';
const String settingsPage = '/settings'
const String menuPage = '/menu';

Route<dynamic> controller(RouteSettings destination) {
  switch (destination.name) {
    case homePage:
      return MaterialPageRoute(builder: (context) => const HomePage());
    case loginPage:
      return MaterialPageRoute(builder: (context) => const LoginPage());
     case menuPage:
      return MaterialPageRoute(builder: (context) => const MenuPage());
    case settingsPage:
      return MaterialPageRoute(builder: (context) => const SettingsPage());
    default:
      throw ('This route does not exist');
  }
}