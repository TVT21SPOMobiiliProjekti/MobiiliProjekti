import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../utility/router.dart' as route;

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final _timeStampInfo = Hive.box('userData');

  DateTime time = DateTime.now();
  DateTime? lunchStart;
  DateTime? lunchEnd;
  DateTime? personalStart;
  DateTime? personalEnd;
  String? docId;
  String? uId;

  void startTimer() {
    setState(() {
      time = DateTime.now();
    });
  }

  @override
  void initState() {
    super.initState();

    uId = _timeStampInfo.get('uid');
  }

  @override
  Widget build(BuildContext context) {
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
                height: 20,
              ),
              Center(
                child: Text(time.toString().substring(0, 16),
                    style: Theme.of(context).textTheme.bodyLarge),
              ),
              const SizedBox(
                height: 60,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    startTimer();
                    startWork();
                  },
                  child: const Text("Start work"),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    startTimer();
                    startLunch();
                  },
                  child: const Text("Lunch"),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    startTimer();
                    endLunch();
                  },
                  child: const Text("End lunch"),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    startTimer();
                    startPersonal();
                  },
                  child: const Text("Personal"),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    startTimer();
                    endPersonal();
                  },
                  child: const Text("End personal"),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    startTimer();
                    endWork();
                  },
                  child: const Text("End work"),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const SizedBox(
                height: 60,
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, route.homePage);
                    },
                    child: const Text("Go back")),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void startWork() async {
    setState(() {
      docId = time.toString().substring(0, 19);
      _timeStampInfo.put(docId, time);
    });
    FirebaseFirestore.instance
        .collection('/Users/$uId/workTime')
        .doc(docId)
        .set({
      'startWork': time,
    });
  }

  void endWork() async {
    DateTime? startWork = _timeStampInfo.get(docId) as DateTime?;
    if (startWork == null) {
      return;
    }
    Duration duration = time.difference(startWork);
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);

    String durationString = '$hours:$minutes:$seconds';

    Duration? lunchDuration = lunchEnd?.difference(lunchStart!);
    Duration? personalDuration = personalEnd?.difference(personalStart!);

    Duration workDurationAfterBreaks = duration;

    if (lunchDuration != null) {
      workDurationAfterBreaks -= lunchDuration;
    }

    if (personalDuration != null) {
      workDurationAfterBreaks -= personalDuration;
    }

    int workHours = workDurationAfterBreaks.inHours;
    int workMinutes = workDurationAfterBreaks.inMinutes.remainder(60);
    int workSeconds = workDurationAfterBreaks.inSeconds.remainder(60);
    String workDurationString = '$workHours:$workMinutes:$workSeconds';

    FirebaseFirestore.instance
        .collection('/Users/$uId/workTime')
        .doc(docId!)
        .set({
      'endWork': time,
      'workDuration': durationString,
      'workDurationAfterBreaks': workDurationString,
    }, SetOptions(merge: true));
  }

  void startLunch() async {
    setState(() {
      lunchStart = time;
    });
    FirebaseFirestore.instance
        .collection('/Users/$uId/workTime')
        .doc(docId!)
        .set({
      'startLunch': time,
    }, SetOptions(merge: true));
  }

  void endLunch() async {
    setState(() {
      lunchEnd = time;
    });
    Duration lunchDuration = lunchEnd!.difference(lunchStart!);
    int lunchHours = lunchDuration.inHours;
    int lunchMinutes = lunchDuration.inMinutes.remainder(60);
    int lunchSeconds = lunchDuration.inSeconds.remainder(60);
    String durationString = '$lunchHours:$lunchMinutes:$lunchSeconds';

    FirebaseFirestore.instance
        .collection('/Users/$uId/workTime')
        .doc(docId!)
        .set({
      'endLunch': lunchEnd as DateTime,
      'lunchDuration': durationString,
    }, SetOptions(merge: true));
  }

  void startPersonal() async {
    setState(() {
      personalStart = time;
    });
    FirebaseFirestore.instance
        .collection('/Users/$uId/workTime')
        .doc(docId!)
        .set({
      'startPersonal': time,
    }, SetOptions(merge: true));
  }

  void endPersonal() async {
    setState(() {
      personalEnd = time;
    });
    Duration personalDuration = personalEnd!.difference(personalStart!);
    int personalHours = personalDuration.inHours;
    int personalMinutes = personalDuration.inMinutes.remainder(60);
    int personalSeconds = personalDuration.inSeconds.remainder(60);
    String durationString = '$personalHours:$personalMinutes:$personalSeconds';

    FirebaseFirestore.instance
        .collection('/Users/$uId/workTime')
        .doc(docId!)
        .set({
      'endPersonal': personalEnd as DateTime,
      'personalDuration': durationString,
    }, SetOptions(merge: true));
  }
}
