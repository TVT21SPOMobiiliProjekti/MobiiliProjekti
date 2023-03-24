import 'dart:async';
import 'package:flutter/material.dart';
import '../utility/router.dart' as route;

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  Timer? _timer;
  int _secondsElapsed = 0;
  int _minutesElapsed = 0;
  int _hoursElapsed = 0;

  void _startTimer() {
    if (_timer == null || !_timer!.isActive) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          _secondsElapsed++;

          if (_secondsElapsed == 60) {
            _secondsElapsed = 0;
            _minutesElapsed++;
          }

          if (_minutesElapsed == 60) {
            _minutesElapsed = 0;
            _hoursElapsed++;
          }
        });
      });
    }
  }

  void _stopTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
      _timer = null;
    }
  }

  void _resetTimer() {
    _stopTimer();
    setState(() {
      _secondsElapsed = 0;
      _minutesElapsed = 0;
      _hoursElapsed = 0;
    });
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String secondsText = _secondsElapsed.toString().padLeft(2, '0');
    String minutesText = _minutesElapsed.toString().padLeft(2, '0');
    String hoursText = _hoursElapsed.toString().padLeft(2, '0');

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Menu"),
      ),
      body: Stack(
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
                height: 70,
              ),
              Center(
                child: Text('Tuntisaldo: $hoursText:$minutesText:$secondsText'),
              ),
              const SizedBox(
                height: 100,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: _startTimer,
                  child: const Text("Aloita työ"),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: _stopTimer,
                  child: const Text("Lounas"),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: _stopTimer,
                  child: const Text("Oma meno"),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: _resetTimer,
                  child: const Text("Päätä työ"),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text("->"),
                          padding: EdgeInsets.only(left: 220.0),
                          backgroundColor: Colors.orange)),
                  child: const Text("Palkkatiedot"),
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, route.homePage);
                    },
                    child: const Text("Takaisin")),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
