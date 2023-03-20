import 'dart:js';

import 'package:flutter/material.dart';
import 'package:mobprojekti/pages/menuPage.dart';
import '../pages/homepage.dart';
import '../pages/loginpage.dart';
import '../pages/menuPage.dart';

const String homePage = '/';
const String loginPage = '/login';
const String menuPage = '/menu';



Route<dynamic> controller(RouteSettings destination) {
  switch (destination.name) {
    case homePage:
      return MaterialPageRoute(builder: (context) => const HomePage());
    case loginPage:
      return MaterialPageRoute(builder: (context) => const LoginPage());
     case menuPage:
      return MaterialPageRoute(builder: (context) => const MenuPage());
    
   
    
    default:
      throw ('This route does not exist');
  }
}