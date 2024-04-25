import 'package:chat_app/constant.dart';
import 'package:chat_app/helper/showsnackbar.dart';
import 'package:chat_app/screens/chatpage.dart';
import 'package:chat_app/screens/register.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Login extends StatefulWidget {
  Login({super.key});
  static String id = 'login';
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formkey = GlobalKey();

  bool isLoading = false;
  String? email, password;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
          backgroundColor: kprimarycolor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Form(
              key: formkey,
              child: ListView(children: [
                SizedBox(
                  height: 75,
                ),
                Image.asset(
                  'assets/images/scholar.png',
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Scholar Chat',
                      style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 75,
                ),
                Row(
                  children: [
                    const Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Textfield(
                  onchanged: (data) {
                    email = data;
                  },
                  hinttext: 'email',
                ),
                SizedBox(
                  height: 15,
                ),
                Textfield(
                  obsecuretext: true,
                  onchanged: (data) {
                    password = data;
                  },
                  hinttext: 'password',
                ),
                SizedBox(
                  height: 20,
                ),
                CustomButton(
                  ontap: () async {
                    if (formkey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await loginUser();
                        Navigator.pushNamed(context, Chatpage.id , arguments: email);
                      } on FirebaseAuthException catch (ex) {
                        if (ex.code == 'user-not-found') {
                          showSnackbar(context, 'user not found');
                        } else if (ex.code == 'wrong-password') {
                          showSnackbar(context, 'wrong password');
                        }
                      } catch (ex) {
                        showSnackbar(context, 'error ');
                      }
                      isLoading = false;
                      setState(() {});
                    }
                  },
                  title: 'login',
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'dont have an account?',
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegisterPage.id);
                      },
                      child: Text(
                        '   register',
                        style: TextStyle(color: Color(0xffCCF4F0)),
                      ),
                    )
                  ],
                ),
              ]),
            ),
          )),
    );
  }

  Future<void> loginUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
