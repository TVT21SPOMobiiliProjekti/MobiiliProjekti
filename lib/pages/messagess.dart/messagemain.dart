import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'messagepage.dart';
import 'styles.dart';
import 'widgets.dart';
import '/utility/router.dart' as route;

class MessageMain extends StatefulWidget {
  const MessageMain({Key? key}) : super(key: key);
  @override
  State<MessageMain> createState() => _MessageMain();
}

class _MessageMain extends State<MessageMain> {
  final firestore = FirebaseFirestore.instance;
  bool open = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade600,
        title: const Text('Flash Chat'),
        elevation: 0,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
                onPressed: () {
                  setState(() {
                    open == true ? open = false : open = true;
                  });
                },
                icon: Icon(
                  open == true ? Icons.close_rounded : Icons.search_rounded,
                  size: 30,
                )),
          )
        ],
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
              onTap: () => Navigator.pushReplacementNamed(context, route.homePage),
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
              onTap: () => Navigator.pushNamed(context, route.messagemain),
            ),
            ListTile(
                leading: const Icon(Icons.payment_rounded),
                title: const Text('Salary information'),
                onTap: () =>
                    null //Navigator.pushNamed(context, route.financePage),
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
              leading: const Icon(Icons.settings_rounded),
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
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(0),
                  child: Container(
                    color: Theme.of(context).appBarTheme.backgroundColor?.withOpacity(0.7),
                    padding: const EdgeInsets.all(8),
                    height: 160,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 10),
                          child: Text(
                            'Recent Users',
                            style: Styles.h1(),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          height: 80,
                          child: StreamBuilder(
                              stream: firestore.collection('Users').snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                List data = !snapshot.hasData
                                    ? []
                                    : snapshot.data!.docs
                                        .where(((element) => element['email']
                                            .toString()
                                            .contains(FirebaseAuth
                                                .instance.currentUser!.uid)))
                                        .toList();
                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: data.length,
                                  itemBuilder: (context, i) {
                                    List users = data[i]['Users'];
                                    var friend = users.where((element) =>
                                        element !=
                                        FirebaseAuth.instance.currentUser!.uid);
                                    var user = friend.isNotEmpty
                                        ? friend.first
                                        : users
                                            .where((element) =>
                                                element ==
                                                FirebaseAuth
                                                    .instance.currentUser!.uid)
                                            .first;
                                    return FutureBuilder(
                                      future: firestore
                                          .collection('Users')
                                          .doc(user)
                                          .get(),
                                      builder: (context, AsyncSnapshot snap) {
                                        return !snap.hasData
                                            ? Container()
                                            : ChatWidgets.circleProfile(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) {
                                                        return MessagePage(
                                                            id: user,
                                                            fname: snap
                                                                .data['fname']);
                                                      },

                                                    ),
                                                  );
                                                },
                                                fname: snap.data['email']);
                                      },
                                    );
                                  },
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    decoration: Styles.friendsBox(context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Text(
                            'Contacts',
                            style: Styles.h1().copyWith(color: Colors.orange),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: StreamBuilder(
                                stream:
                                    firestore.collection('Users').snapshots(),
                                builder: (context, snapshot) {
                                  List data = !snapshot.hasData
                                      ? []
                                      : snapshot.data!.docs
                                          .where((element) => element['fname']
                                              .toString()
                                              .contains(FirebaseAuth
                                                  .instance.currentUser!.uid))
                                          .toList();
                                  return ListView.builder(
                                    itemCount: data.length,
                                    itemBuilder: (context, i) {
                                      List users = data[i]['email'];
                                      var friend = users
                                          .where((element) =>
                                              element !=
                                              FirebaseAuth
                                                  .instance.currentUser!.uid)
                                          .toList();
                                      var user = friend.isNotEmpty
                                          ? friend.first
                                          : users
                                              .where((element) =>
                                                  element ==
                                                  FirebaseAuth.instance
                                                      .currentUser!.uid)
                                              .first;
                                      return FutureBuilder(
                                        future: firestore
                                            .collection('Chats')
                                            .doc(user)
                                            .get(),
                                        builder: (context, AsyncSnapshot snap) {
                                          return !snap.hasData
                                              ? Container()
                                              : ChatWidgets.card(
                                                  title: snap.data['email'],
                                                  subtitle: data[i]
                                                      ['last_message'],
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) {
                                                          return MessagePage(
                                                            id: user,
                                                            fname: snap
                                                                .data['email'],
                                                          );
                                                        },
                                                      ),
                                                    );
                                                  },
                                                );
                                        },
                                      );
                                    },
                                  );
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            ChatWidgets.searchBar(open)
          ],
        ),
      ),
    );
  }
}
