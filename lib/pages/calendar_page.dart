import 'package:flutter/material.dart';
import '../models/calendar_model.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import '../utility/router.dart' as route;

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
  
}

class _CalendarPageState extends State<CalendarPage> {
  Timer? _timer;
  String? email;

  @override
  void initState() {
    super.initState();
    email = FirebaseAuth.instance.currentUser?.email;
    print(FirebaseAuth.instance.currentUser?.email);
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
      print('calendar_page timer expired');
      await FirebaseAuth.instance.signOut();
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    //_timer = null;
  }

  void _resetTimer() {
    _stopTimer();
    _startTimer();
  }

  void _onTimerExpired() async {
    _stopTimer();
  }
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar(
          title: const Text('Calendar'),
          centerTitle: true,
        ),
        body: GestureDetector(
  behavior: HitTestBehavior.opaque,
  onTap: () => _resetTimer(),
  onPanDown: (_) => _resetTimer(),
  child: const CalendarModel(),
          ),
        );
      }
    }
