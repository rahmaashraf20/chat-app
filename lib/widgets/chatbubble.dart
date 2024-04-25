import 'package:chat_app/constant.dart';
import 'package:chat_app/models/message.dart';
import 'package:flutter/material.dart';

class Chatbubble extends StatelessWidget {
  const Chatbubble({
    super.key, required this.message,
  });
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.only(left: 16, top: 25, bottom: 25, right: 16),
        margin: EdgeInsets.all(16),
        decoration: const BoxDecoration(
            color: kprimarycolor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        child:  Text(
          message.message,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}


class Chatbubbleforfriend extends StatelessWidget {
  const Chatbubbleforfriend({
    super.key, required this.message,
  });
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.only(left: 16, top: 25, bottom: 25, right: 16),
        margin: EdgeInsets.all(16),
        decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20))),
        child:  Text(
          message.message,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

