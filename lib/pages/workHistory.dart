import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Workhistory extends StatefulWidget {
  const Workhistory({super.key});

  @override
  State<Workhistory> createState() => _WorkhistoryState();
}

class _WorkhistoryState extends State<Workhistory> {
  FirebaseFirestore workHistory = FirebaseFirestore.instance;
  final _userInfo = Hive.box('userData');
  String? uID;
  Map? _map;
  dynamic values = [];

  @override
  void initState() {
    super.initState();
    uID = _userInfo.get("uid");
    _workHours();
  }

  void _workHours() async {
    workHistory.collection('/Users/$uID/workTime').get().then((value) {
      for (var docSnapshot in value.docs) {
        _map = docSnapshot.data();
      }
      print(_map);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Workhistory'),
          centerTitle: true,
        ),
        body: Container(
            child: ListView(
          children: [
            Card(
              child: ListTile(
                
              ),
            )
          ],
        )));
  }
}
