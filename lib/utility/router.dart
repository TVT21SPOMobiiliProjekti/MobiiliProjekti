import 'package:flutter/material.dart';
import '../pages/homepage.dart';
import '../pages/loginpage.dart';
import '../pages/adminhomepage.dart';

const String homePage = '/';
const String loginPage = '/login';
const String adminHomePage = '/admin';


Route<dynamic> controller(RouteSettings destination) {
  switch (destination.name) {
    case homePage:
      return MaterialPageRoute(builder: (context) => const HomePage());
    case loginPage:
      return MaterialPageRoute(builder: (context) => const LoginPage());
    case adminHomePage:
      return MaterialPageRoute(builder: (context) => const AdminHomePage());
    
    default:
      throw ('This route does not exist');
  }
}