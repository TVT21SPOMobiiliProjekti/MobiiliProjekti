import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobprojekti/utility/theme_provider.dart';
import '../utility/router.dart' as route;

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>{
  bool _light = true;
  bool _biometrics = true;

  final _switchPosition = Hive.box('themeData'); 

 
  @override
  void initState() {
    super.initState();
    setState(() {
      if(_switchPosition.containsKey('lightPosition')){
        _light = _switchPosition.get('lightPosition');
      }
      else {
        _switchPosition.put('lightPosition', _light);
      }
      
      if(_switchPosition.containsKey('biometricsPosition')){
        _biometrics = _switchPosition.get('biometricsPosition');
      }
      else{
        _switchPosition.put('biometricsPosition', _biometrics);
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
          centerTitle: true,
          //titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        body: Container(
          padding: const EdgeInsets.all(15),
          child: ListView(
            children: [
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.nightlight_round,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Dark mode",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Switch(
                      value: _light,
                      onChanged: (bool value)  {
                     currentTheme.toggleTheme(); 
                      _switchPosition.put('lightPosition', value);
                      setState(() {
                        _light = value;
                      });
                      }),
                ],
              ),
              const Divider(
                height: 20,
                thickness: 1,
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.fingerprint_rounded,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Enable biometric login",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Switch(
                      value: _biometrics,
                      onChanged: (bool value) async { 
                      _switchPosition.put('biometricsPosition', value);
                      setState(() {
                        _biometrics = value;
                      });
                      }),
                ],
              ),
              const Divider(
                height: 20,
                thickness: 1,
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.logout,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Log out",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, route.loginPage);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    
  }
}