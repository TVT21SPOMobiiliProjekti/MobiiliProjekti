import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
  dynamic info = [];
  late Timestamp ts;
  late DateTime dt;

  @override
  void initState() {
    super.initState();
    uID = _userInfo.get("uid");
    _workHours();
  }

  void _workHours() async {
    workHistory.collection('/Users/$uID/workTime').get().then((value) {
      for (var docSnapshot in value.docs) {
        setState(() {
           info = docSnapshot.id;
           ts = docSnapshot.get('startLunch');  // saa tietyn tiedon jos haluaa
           dt = ts.toDate();
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Workhistory'),
          centerTitle: true,
        ),
        body:  ListView(
          children: [
            ExpansionTile(
              title: ListTile(
                title: Text( 
                  '$info'
                ),
              ),
              children: [
                Text(
                  '$dt'+' startLunch',
                )
              ],
            ),
          ],
        )
        );
  }
}
