import 'package:chat_app/constant.dart';
import 'package:chat_app/helper/showsnackbar.dart';
import 'package:chat_app/screens/chatpage.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});
  static String id = 'registerpage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email;

  String? password;

  GlobalKey<FormState> formkey = GlobalKey();

  bool isLoading = false;

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
              child: Column(children: [
                Spacer(
                  flex: 1,
                ),
                Image.asset('assets/images/scholar.png'),
                const Text(
                  'Scholar Chat',
                  style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Spacer(
                  flex: 1,
                ),
                Row(
                  children: [
                    const Text(
                      'REGISTER',
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
                        await registerUser();
                        Navigator.pushNamed(context, Chatpage.id);
                      } on FirebaseAuthException catch (ex) {
                        if (ex.code == 'weak-password') {
                          showSnackbar(context, 'weak password');
                        } else if (ex.code == 'email-already-in-use') {
                          showSnackbar(context, 'already exist email');
                        }
                      } catch (ex) {
                        showSnackbar(context, 'error ');
                      }
                      isLoading = false;
                      setState(() {});
                    }
                  },
                  title: 'register',
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'already have an account',
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        '   login',
                        style: TextStyle(color: Color(0xffCCF4F0)),
                      ),
                    )
                  ],
                ),
                Spacer(
                  flex: 2,
                )
              ]),
            ),
          )),
    );
  }

  Future<void> registerUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
