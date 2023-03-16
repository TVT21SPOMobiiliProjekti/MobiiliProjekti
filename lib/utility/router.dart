import 'package:flutter/material.dart';
import '../pages/homepage.dart';
import '../pages/loginpage.dart';

const String homePage = '/';
const String loginPage = '/login';


Route<dynamic> controller(RouteSettings destination) {
  switch (destination.name) {
    case homePage:
      return MaterialPageRoute(builder: (context) => const HomePage());
    case loginPage:
      return MaterialPageRoute(builder: (context) => const LoginPage());
    
    default:
      throw ('This route does not exist');
  }
}