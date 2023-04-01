import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SalaryInfo extends StatefulWidget {
  const SalaryInfo({Key? key}) : super(key: key);

  @override
  State<SalaryInfo> createState() => _SalaryInfoState();
}

class _SalaryInfoState extends State<SalaryInfo> {
  final _userInfo = Hive.box('userData');
  final _nameController = TextEditingController();

  bool _editingName = false;

  void _toggleEditing(String condition) {
    if (condition == 'Tuntipalkka:') {
      setState(() {
        _editingName = !_editingName;
      });
    }
  }

  void _saveName() {
    _toggleEditing('Tuntipalkka:');
    _userInfo.put('Tuntipalkka:', _nameController.text);
  }

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
                  children: [
                    const Text('Tuntipalkka:'),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: TextFormField(
                          controller: _nameController,
                          enabled: _editingName,
                          decoration: InputDecoration(
                            hintText: _userInfo.get('Tuntipalkka:'),
                            hintStyle: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onSaved: (value) {
                            _nameController.text = value!;
                          }),
                    ),
                    IconButton(
                      onPressed: () => _toggleEditing('Tuntipalkka:'),
                      icon: _editingName
                          ? const Icon(Icons.cancel)
                          : const Icon(Icons.edit),
                    ),
                    if (_editingName)
                      IconButton(
                        onPressed: _saveName,
                        icon: const Icon(Icons.save),
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
                  children: const [
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
