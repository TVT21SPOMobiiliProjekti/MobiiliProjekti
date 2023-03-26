import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SalaryInfo extends StatelessWidget {
  const SalaryInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Salary information"),
          centerTitle: true,
        ),
        body: Column(children: <Widget>[
          Row(
            children: const [
              SizedBox(
                height: 70,
              ),
              Text("Tehtävänimike: Automaatioasentaja",
                  style: TextStyle(
                    backgroundColor: Colors.grey,
                    fontSize: 24,
                  ),
            ),
            ],
          ),
          Row(
            children: const [
              Text("Viikkotyöaika: 38h",
              style: TextStyle(
                backgroundColor: Colors.grey,
                fontSize: 24
              ),),
              

            ],
          )
        ]));
  }
}
