import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'styles.dart';
import 'widgets.dart';

class MessagePage1 extends StatefulWidget {
  final String id;
  const MessagePage1({Key? key, required this.id}) : super(key: key);

  @override
  State<MessagePage1> createState() => _MessagePage1State();
}

class _MessagePage1State extends State<MessagePage1> {
  var ChatId;
  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;
    return Scaffold(
      backgroundColor: Colors.grey.shade600,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade600,
        title: const Text('John Doe'),
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
                Text(
                  'Chats',
                  style: Styles.h1(),
                ),
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
                            .where((element) =>
                                element['Users'].contains(widget.id) &&
                                element['Users'].contains(
                                    FirebaseAuth.instance.currentUser!.uid))
                            .toList();
                        QueryDocumentSnapshot? data =
                            allData.isNotEmpty ? allData.first : null;
                            if(data != null){
                              ChatId = data.id;
                            }
                        return data == null
                            ? Container()
                            : ListView.builder(
                                itemCount: data!['Messages'].length,
                                reverse: true,
                                itemBuilder: (context, i) {
                                  return ChatWidgets.messagesCard(
                                      i,
                                      'Firebase projects are containers for your app Apps in a project share features like Real-time Database and Analytics',
                                      '04:51 pm');
                                },
                              );
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
              if(ChatId != null){

              }else{
                Map<String, dynamic> data = {
                  'Message' : controller.text.trim(),
                  'sender' : FirebaseAuth.instance.currentUser!.uid,
                  'date_time' : DateTime.now(),
              };
              firestore.collection('Chats').add({
                'Users' : [widget.id, FirebaseAuth.instance.currentUser!.uid],
              }).then((value)async{
                value.collection('Messages').add(data);
              });
              }
            }),
          )
        ],
      ),
    );
  }
}
