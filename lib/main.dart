import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/screens/chatpage.dart';
import 'package:chat_app/screens/login.dart';
import 'package:chat_app/screens/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      routes: {
      
        RegisterPage.id :(context) => RegisterPage(),
        Chatpage.id :(context) => Chatpage(),
        Login.id:(context) => Login()
      },initialRoute: Login.id,
      home: Login(),
    );
  }
}