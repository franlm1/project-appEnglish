import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../assets/rounded.dart';
import '../../util/animation_route.dart';
import 'login_screen_student.dart';
import 'login_screen_teacher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(WelcomeScreen());
}

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    
  
    return Center(
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.purple, Colors.orange])),
                child: Scaffold(
                    backgroundColor: Colors.transparent,
      
          body: Center(
            child: Padding(
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
          
          ),
      ),
    );
  }
}

