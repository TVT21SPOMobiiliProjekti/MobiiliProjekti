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
  String? docId;

  void startTimer() {
    setState(() {
      time = DateTime.now();
    });
  }

  @override
  void initState() {
    super.initState();
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
                  child: const Text("Aloita työ"),
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
                  child: const Text("Lounas"),
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
                  child: const Text("Lopeta lounas"),
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
                  child: const Text("Oma meno"),
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
                  child: const Text("Lopeta oma meno"),
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
                  child: const Text("Päätä työ"),
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
                    child: const Text("Takaisin")),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void startWork() async {
    setState(() {
      docId = time.toString();
      _timeStampInfo.put("hour", docId);
    });
    FirebaseFirestore.instance
        .collection('/Users/${_timeStampInfo.get('uid')}/workTime')
        .doc(docId)
        .set({
      'startWork': time,
    });
  }

  void endWork() async {
    
    FirebaseFirestore.instance
        .collection('/Users/${_timeStampInfo.get('uid')}/workTime')
        .doc(_timeStampInfo.get("hour"))
        .set({
      'endWork': time,
    }, SetOptions(merge: true));
  }

  void startLunch() async {
    FirebaseFirestore.instance
        .collection('/Users/${_timeStampInfo.get('uid')}/workTime')
        .doc(_timeStampInfo.get("hour"))
        .set({
      'startLunch': time,
    }, SetOptions(merge: true));
  }

  void endLunch() async {
    FirebaseFirestore.instance
        .collection('/Users/${_timeStampInfo.get('uid')}/workTime')
        .doc(_timeStampInfo.get("hour"))
        .set({
      'endLunch': time,
    }, SetOptions(merge: true));
  }

  void startPersonal() async {
    FirebaseFirestore.instance
        .collection('/Users/${_timeStampInfo.get('uid')}/workTime')
        .doc(_timeStampInfo.get("hour"))
        .set({
      'startPersonal': time,
    }, SetOptions(merge: true));
  }

  void endPersonal() async {
    FirebaseFirestore.instance
        .collection('/Users/${_timeStampInfo.get('uid')}/workTime')
        .doc(_timeStampInfo.get("hour"))
        .set({
      'endPersonal': time,
    }, SetOptions(merge: true));
  }
}
