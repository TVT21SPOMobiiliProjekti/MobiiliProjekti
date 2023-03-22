import 'package:flutter/material.dart';
import '../pages/homepage.dart';
import '../pages/loginpage.dart';
import '../pages/adminhomepage.dart';
import '../pages/settings.dart';
import '../pages/accountinfopage.dart';
import '../pages/menupage.dart';
import '../pages/manage_employees.dart';


const String homePage = '/';
const String loginPage = '/login';
const String settingsPage = '/settings';
const String menuPage = '/menu';
const String adminHomePage = '/admin';
const String profilePage = '/profile';
const String manageEmployees = '/manageEmployees';



Route<dynamic> controller(RouteSettings destination) {
  switch (destination.name) {
    case homePage:
      return MaterialPageRoute(builder: (context) => const HomePage());
    case loginPage:
      return MaterialPageRoute(builder: (context) => const LoginPage());
    case adminHomePage:
      return MaterialPageRoute(builder: (context) => const AdminHomePage());
    case menuPage:
      return MaterialPageRoute(builder: (context) => const MenuPage());
    case settingsPage:
      return MaterialPageRoute(builder: (context) => const SettingsPage());
    case profilePage:
      return MaterialPageRoute(builder: (context) => const AccountInfoPage());
    case manageEmployees:
      return MaterialPageRoute(builder: (context) => const EmployeeManager());

    default:
      throw ('This route does not exist');
  }
}
