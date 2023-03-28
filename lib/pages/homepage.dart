import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../utility/router.dart' as route;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? email;

  @override
  void initState() {
    super.initState();
    email = FirebaseAuth.instance.currentUser?.email;
    print(FirebaseAuth.instance.currentUser?.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.grey.shade800),
              child: const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/pfp_placeholder.jpg'),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home_rounded),
              title: const Text('Home'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
                leading: const Icon(Icons.calendar_month_rounded),
                title: const Text('Calendar'),
                onTap: () =>
                    null //Navigator.pushNamed(context, route.calendarPage),
                ),
            ListTile(
                leading: const Icon(Icons.message_rounded),
                title: const Text('Messages'),
                onTap: () =>
                    null //Navigator.pushNamed(context, route.messagePage),
                ),
            ListTile(
              leading: const Icon(Icons.payment_rounded),
              title: const Text('Salary information'),
              onTap: () => Navigator.pushNamed(context, route.salaryInfo),
            ),
            ListTile(
              leading: const Icon(Icons.person_rounded),
              title: const Text('Profile'),
              onTap: () => Navigator.pushNamed(context, route.profilePage),
            ),
            ListTile(
                leading: const Icon(Icons.menu),
                title: const Text('Menu'),
                onTap: () => Navigator.pushNamed(context, route.menuPage)),
            ListTile(
              leading: const Icon(Icons.privacy_tip_outlined),
              title: const Text('AdminHomePage'),
              onTap: () => Navigator.pushNamed(context, route.adminHomePage),
            ),
            ListTile(
              leading: const Icon(Icons.settings_rounded),
              title: const Text('Settings'),
              onTap: () => Navigator.pushNamed(context, route.settingsPage),
            ),
          ],
        ),
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
          Text(
            'Welcome back, $email!',
            style: Theme.of(context).textTheme.displayLarge,
            textAlign: TextAlign.center,
          ),
          Align(
            alignment: const Alignment(0, 0.5),
            child: ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, route.menuPage),
              child: const Text('Start your day!'),
            ),
          ),
          Align(
            alignment: const Alignment(0, 0.7),
            child: ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, route.salaryInfo),
              child: const Text('Salary information'),
            ),
          ),
        ],
      ),
    );
  }
}
