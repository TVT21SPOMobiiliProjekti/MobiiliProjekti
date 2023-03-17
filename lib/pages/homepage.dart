import 'package:flutter/material.dart';
import '../utility/router.dart' as route;

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                  onTap: () => null//Navigator.pushNamed(context, route.calendarPage),
                ),
                ListTile(
                  leading: const Icon(Icons.message_rounded),
                  title: const Text('Messages'),
                  onTap: () => null//Navigator.pushNamed(context, route.messagePage),
                ),
                ListTile(
                  leading: const Icon(Icons.payment_rounded),
                  title: const Text('Salary information'),
                  onTap: () => null//Navigator.pushNamed(context, route.financePage),
                ),
                ListTile(
                  leading: const Icon(Icons.person_rounded),
                  title: const Text('Profile'),
                  onTap: () => null//Navigator.pushNamed(context, route.profilePage),
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
                  image: AssetImage('assets/homepage_background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0, 0.5),
              child:ElevatedButton(
                style: Theme.of(context).elevatedButtonTheme.style,
                onPressed: () => null, //Navigator.pushNamed(context, route.calendarPage),
                child: const Text('Start your day!'),
              ),
            ),
             Align(
                alignment: const Alignment(0, 0.7),
                child: ElevatedButton(
                style: Theme.of(context).elevatedButtonTheme.style,
                onPressed: () => null, //Navigator.pushNamed(context, route.financePage),
                child: const Text('Salary information'),
              ),
            ),         
          ],
        ),
      );
    
  }
}
