import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tuttorial_1/add/add_alumno.dart';


import '../vista/Frans/MenuControlador.dart';
import '../vista/Frans/MenuCursos.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String role = 'Student';
 
  
  @override
  void initState() {
    super.initState();
    _checkRole();
  }
  
  void _checkRole() async {
  final usuario = FirebaseAuth.instance.currentUser;
  final DocumentSnapshot snap = await FirebaseFirestore.instance.collection('Usuarios').doc().get();

    setState(() {
      role = snap['role'];
    });

    if(role == 'Student'){
      navigateNext(MenuCursos());
    } else if(role == 'Teacher'){
      navigateNext(MenuControlador());
    }
  }

  void navigateNext(Widget route) {
    Timer(Duration(milliseconds: 500), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => route));
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome'),
          ],
        ),
      ),
    );
  }
}
