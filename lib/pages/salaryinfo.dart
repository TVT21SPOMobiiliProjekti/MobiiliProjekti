import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SalaryInfo extends StatefulWidget {
  const SalaryInfo({Key? key}) : super(key: key);

  @override
  State<SalaryInfo> createState() => _SalaryInfoState();
}

class _SalaryInfoState extends State<SalaryInfo> {


  
 

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar(
          title: const Text("Salary information"),
          centerTitle: true,
        ),
        body: Stack(children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/homepage_background.png'),
                fit: BoxFit.cover,
              ),
            ),
            padding: const EdgeInsets.only(left: 10),
            child: ListView(
              children: [
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: const [
                    Text(
                      "Tehtävänimike: Putkiasentaja",
                      style: TextStyle(
                        backgroundColor: Colors.orange,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: const [
                    Text(
                      "Viikkotyöaika: 38h",
                      style: TextStyle(
                        backgroundColor: Colors.orange,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: const [
                    Text(
                      "Tuntipalkka: 20/h",
                      style: TextStyle(
                        backgroundColor: Colors.orange,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: const [
                    Text(
                      "Vuosilomat: 30 päivää",
                      style: TextStyle(
                        backgroundColor: Colors.orange,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                 Row(
                  children: [
                    Text(
                      'Työtunnit:',
                      style: TextStyle(
                        backgroundColor: Colors.orange,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]));
  }
}
