import 'package:flutter/material.dart';
import '../pages/homepage.dart';

const String homePage = '/';


Route<dynamic> controller(RouteSettings setting) {
  switch (setting.name) {
    case homePage:
      return MaterialPageRoute(builder: (context) => const HomePage());
    
    
    default:
      throw ('This route does not exist');
  }
}