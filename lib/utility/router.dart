import 'package:flutter/material.dart';
import '../pages/homepage.dart';
import '../pages/loginpage.dart';
import '../pages/settings.dart';

const String homePage = '/';
const String loginPage = '/login';
const String settingsPage = '/settings';


Route<dynamic> controller(RouteSettings destination) {
  switch (destination.name) {
    case homePage:
      return MaterialPageRoute(builder: (context) => const HomePage());
    case loginPage:
      return MaterialPageRoute(builder: (context) => const LoginPage());
    case settingsPage:
      return MaterialPageRoute(builder: (context) => const SettingsPage());
    default:
      throw ('This route does not exist');
  }
}