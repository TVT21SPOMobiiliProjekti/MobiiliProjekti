import 'package:flutter/material.dart';
import './utility/router.dart' as route; 

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget{
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
} 

class _MyAppState extends State<MyApp>{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: route.controller,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      initialRoute: route.homePage,
    );
  }
}