import 'package:flutter/material.dart';


import '../menu/animation_route.dart';
import '../screens/login_screen_student.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton(
      {required this.colour, required this.title, required this.onPressed});
  final Color colour;
  final String title;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          //Go to login screen.
          minWidth: 440.0,
          height: 277.0,
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
        ),
      ),
    );
  }
}