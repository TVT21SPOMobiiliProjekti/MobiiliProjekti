import 'package:flutter/material.dart';
import '../utility/router.dart' as route;
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _startTimer();
    _stopTimer();
    super.dispose();
  }

  @override
  void _startTimer() {
    _timer = Timer(const Duration(seconds: 1000), () async {
      Navigator.pushNamed(context, route.loginPage);
      print('admin timer expired');
      await FirebaseAuth.instance.signOut();
    });
  }

  @override
  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void _resetTimer() {
    _stopTimer();
    _startTimer();
  }

  @override
  void _onTimerExpired() async {
    _stopTimer();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
      ),
      body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _resetTimer(),
          onPanDown: (_) => _resetTimer(),
          child: Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/homepage_background.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Center(
                    child: Text(
                      "Admin",
                      style: TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 250,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(
                        content: Text("Avaa kalenterin"),
                      )),
                      child: const Text("Tarkastele vuoroja"),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, route.manageEmployees),
                      child: const Text("Lisää/Poista työntekijä"),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const SizedBox(
                    height: 70,
                  ),

                  // Voi kopioida takaisin napin ja asettaa haluaman navigoinnin.
                  /*Center(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, route.homePage);
                    },
                    child: const Text("Takaisin")),
              ),*/
                ],
              ),
            ],
          ),
        ));
  }
}