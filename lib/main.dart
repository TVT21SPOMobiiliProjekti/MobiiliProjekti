import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobprojekti/utility/theme_provider.dart';
import 'utility/theme_data.dart';
import './utility/router.dart' as route; 

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('themeData');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget{
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
} 

class _MyAppState extends State<MyApp>{ 
  
  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: route.controller,
      debugShowCheckedModeBanner: false,
      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: currentTheme.currentTheme(), 
      initialRoute: route.loginPage,
    );
  }
}