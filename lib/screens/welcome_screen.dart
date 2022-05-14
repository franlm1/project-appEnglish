import 'package:flutter/material.dart';
import 'package:tuttorial_1/add/add_task.dart';
import 'package:tuttorial_1/assets/rounded_button.dart';
import 'package:tuttorial_1/screens/login_screen_student.dart';
import 'package:tuttorial_1/screens/login_screen_teacher.dart';
import '../menu/animation_route.dart';
import '../menu/menu_lateral.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.purple, Colors.orange])),
              child: Scaffold(
                  backgroundColor: Colors.transparent,
        drawer: MenuLateral(),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 100),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                RoundedButton(
                  colour: Colors.lightBlueAccent,
                  title: 'Student Log In',
                  onPressed: () {
                Navigator.push(context, Animation_route(LoginScreenStudent()))
                   ;
                  },
                ),
                RoundedButton(
                    colour: Color(0xFFF44336),
                    title: 'Teacher Log In',
                    onPressed: () {
                      Navigator.push(context, Animation_route(LoginScreenTeacher()));
                    }),
              ]),
        ),
        
        ),
    );
  }
}
