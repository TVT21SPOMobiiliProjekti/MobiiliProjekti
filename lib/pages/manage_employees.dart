// ignore_for_file: prefer_interpolation_to_compose_strings
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EmployeeManager extends StatefulWidget {
  const EmployeeManager({Key? key}) : super(key: key);

  @override
  State<EmployeeManager> createState() => _EmployeeManagerState();
}

class _EmployeeManagerState extends State<EmployeeManager> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Manager'),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/employee_manager_bcgrnd.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Users').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }
      
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
      
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
      
                return ListTile(
                  title: Text(data['fname'],
                      style: Theme.of(context).textTheme.displayLarge),
                  subtitle: Text(data['email'], style: const TextStyle(color: Colors.white)),
                  trailing: data['isWorking']
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : const Icon(Icons.cancel, color: Colors.red),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        icon: const Icon(Icons.person),
                        title: Text(data['fname'] + ' ' + data['lname'],
                            style: Theme.of(context).textTheme.displayLarge),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            data['isAdmin']
                                ? Text('Admin',
                                    style: Theme.of(context).textTheme.bodyLarge)
                                : Text('Employee',
                                    style: Theme.of(context).textTheme.bodyLarge),
                            const SizedBox(height: 10),
                            data['isWorking']
                                ? Text('Currently at work',
                                    style: Theme.of(context).textTheme.bodyLarge)
                                : Text('Not Working right now',
                                    style: Theme.of(context).textTheme.bodyLarge),
                            const SizedBox(height: 20),
                            Text("Email: " + data['email'],
                                style: Theme.of(context).textTheme.displayMedium),
                            Text("Phonenumber: " + data['phone'],
                                style: Theme.of(context).textTheme.displayMedium),
                          ],
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Close'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text('Ok'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                  onLongPress: () {
                    //Select multiple tiles for deletion
                  },
                );
              }).toList(),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Employees',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.delete_outline_rounded),
            label: 'Delete Employee',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add Employee',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).iconTheme.color,
        onTap: _onItemTapped,
      ),
    );
  }
}
