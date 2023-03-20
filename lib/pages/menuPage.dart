import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import './homepage.dart';
import '../utility/router.dart' as route;

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Menu"),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 70,
          ),
          Center(
            child: Text(
              "Tuntisaldo:",
              style: TextStyle(
                fontSize: 30,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ),
          const SizedBox(
            height: 150,
          ),
          Center(
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.orange),
                  minimumSize: MaterialStateProperty.all(const Size(200, 50))),
              onPressed: () => ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Töissä"),
                  padding: EdgeInsets.only(left: 220.0),
                  backgroundColor: Colors.orange,)),
              child: const Text("Aloita työ"),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.orange),
                  minimumSize: MaterialStateProperty.all(const Size(200, 50))),
              onPressed: () => ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Lounaalle"),
                  padding: EdgeInsets.only(left: 220.0),
                  backgroundColor: Colors.orange,)),
              child: const Text("Lounas"),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.orange),
                  minimumSize: MaterialStateProperty.all(const Size(200, 50))),
              onPressed: () => ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("->"),
                  padding: EdgeInsets.only(left: 220.0),
                  backgroundColor: Colors.orange)),
              child: const Text("Palkkatiedot"),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.orange),
                  minimumSize: MaterialStateProperty.all(const Size(200, 50))),
              onPressed: () =>
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Kirjauduttu ulos!"),
                padding: EdgeInsets.only(left: 220.0),
                  backgroundColor: Colors.orange
              )),
              child: const Text("Päätä työ"),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Center(
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.orange),
                    minimumSize:
                        MaterialStateProperty.all(const Size(200, 50))),
                onPressed: () {
                  Navigator.pushNamed(context, route.homePage);
                },
                child: const Text("Takaisin")),
          ),
        ],
      ),
    );
  }
}
