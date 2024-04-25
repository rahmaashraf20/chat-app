import 'package:flutter/material.dart';

class Textfield extends StatelessWidget {
  Textfield({this.hinttext, this.onchanged , this.obsecuretext=false});
  String? hinttext;
  Function(String)? onchanged;
  bool ? obsecuretext;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText:obsecuretext! ,
      validator: (data) {
        if (data!.isEmpty) return 'field is required';
      },
      onChanged: onchanged,
      decoration: InputDecoration(
          hintText: hinttext,
          hintStyle: TextStyle(color: Colors.white),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white))),
    );
  }
}
