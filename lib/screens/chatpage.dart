import 'package:chat_app/constant.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/widgets/chatbubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Chatpage extends StatelessWidget {
  static String id = 'chatpage';
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kmessagescollection);
  TextEditingController controller = TextEditingController();
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kMessage, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messagelist = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagelist.add(Message.fromJason(snapshot.data!.docs[i]));
          }
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kprimarycolor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    klogo,
                    height: 50,
                  ),
                  Text('scholar chat')
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      reverse: true,
                      controller: _controller,
                      itemCount: messagelist.length,
                      itemBuilder: (context, index) {
                        return messagelist[index].id == email
                            ? Chatbubble(message: messagelist[index])
                            : Chatbubbleforfriend(message: messagelist[index]);
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) {
                      messages.add(
                        {
                          kMessage: data,
                          kcreatedAt: DateTime.now(),
                          'id': email
                        },
                      );
                      controller.clear();
                      _controller.animateTo(0,
                          duration: Duration(seconds: 1), curve: Curves.easeIn);
                    },
                    decoration: InputDecoration(
                        hintText: 'Send Message',
                        suffixIcon: Icon(
                          Icons.send,
                          color: kprimarycolor,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: kprimarycolor))),
                  ),
                )
              ],
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
