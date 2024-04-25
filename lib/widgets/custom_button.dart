import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
   CustomButton({this.ontap,required this.title});
  String title;
  VoidCallback ? ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        height: 40,
        width: double.infinity,
        child: Center(child: Text(title)),
      ),
    );
  }
}
