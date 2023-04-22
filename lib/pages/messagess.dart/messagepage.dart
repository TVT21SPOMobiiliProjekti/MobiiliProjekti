import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'styles.dart';
import 'widgets.dart';

class MessagePage extends StatefulWidget {
  final String id;
  final String fname;
  const MessagePage({Key? key, required this.id, required this.fname})
      : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  var ChatId;
  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;
    return Scaffold(
      backgroundColor: Colors.grey.shade600,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade600,
        title: Text(widget.fname),
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StreamBuilder(
                    stream: firestore
                        .collection('Users')
                        .doc(widget.id)
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                            snapshot) {
                      return !snapshot.hasData
                          ? Container()
                          : Text(
                              'Chats',
                              style: Styles.h1(),
                            );
                    }),
                const Spacer(),
                Text(
                  'Last seen: 04:50',
                  style: Styles.h1().copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Colors.white70),
                ),
                const Spacer(),
                const SizedBox(
                  width: 50,
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: Styles.friendsBox(context),
              child: StreamBuilder(
                  stream: firestore.collection('Chats').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      if (snapshot.data!.docs.isNotEmpty) {
                        List<QueryDocumentSnapshot?> allData = snapshot
                            .data!.docs
                            .where((element) => element['Users'].contains(
                                FirebaseAuth.instance.currentUser!.uid))
                            .toList();
                        print(allData);
                        QueryDocumentSnapshot? data =
                            allData.isNotEmpty ? allData.first : null;
                        if (data != null) {
                          ChatId = data.id;
                        }
                        return data == null
                            ? Container()
                            : StreamBuilder(
                                stream: data.reference
                                    .collection('Messages')
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snap) {
                                  return !snap.hasData
                                      ? Container()
                                      : ListView.builder(
                                          itemCount: snap.data!.docs.length,
                                          reverse: true,
                                          itemBuilder: (context, i) {
                                            return ChatWidgets.messagesCard(
                                                snap.data!.docs[i]['sender'] !=
                                                    FirebaseAuth.instance
                                                        .currentUser!.uid,
                                                snap.data!.docs[i]['Message']);
                                          },
                                        );
                                });
                      } else {
                        return Center(
                          child: Text(
                            'No Messages',
                            style: Styles.h1().copyWith(color: Colors.grey),
                          ),
                        );
                      }
                    } else {
                      return const Center(
                          child: CircularProgressIndicator(color: Colors.grey));
                    }
                  }),
            ),
          ),
          Container(
            color: Colors.white,
            child: ChatWidgets.messageField(onSubmit: (controller) {
              if (controller.text.toString() != '') {
                if (ChatId != null) {
                  Map<String, dynamic> data = {
                    'Message': controller.text.trim(),
                    'sender': FirebaseAuth.instance.currentUser!.uid,
                  };
                  firestore.collection('Chats').doc(ChatId).update({
                    'last_message': controller.text,
                  });
                  firestore
                      .collection('Chats')
                      .doc(ChatId)
                      .collection('Messages')
                      .add(data);
                } else {
                  Map<String, dynamic> data = {
                    'Message': controller.text.trim(),
                    'sender': FirebaseAuth.instance.currentUser!.uid,
                  };
                  firestore.collection('Chats').add({
                    'Users': [
                      widget.id,
                      FirebaseAuth.instance.currentUser!.uid
                    ],
                    'last_message': controller.text,
                  }).then((value) async {
                    value.collection('Messages').add(data);
                  });
                }
                controller.clear();
              }
            }),
          )
        ],
      ),
    );
  }
}
