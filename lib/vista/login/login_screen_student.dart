import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tuttorial_1/vista/galeria/MenuGaleriaGaleria.dart';
import 'package:tuttorial_1/vista/galeria/SelectCurseModule.dart';
import 'package:tuttorial_1/vista/login/welcome_screen.dart';

import '../../assets/rounded.dart';
import '../../util/animation_route.dart';




//code for designing the UI of our text field where the user writes his email id or password

const kTextFieldDecoration = InputDecoration(
    hintText: 'Enter a value',
    hintStyle: TextStyle(color: Colors.grey),
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ));

class LoginScreenStudent extends StatefulWidget {
  @override
  _LoginScreenStudentState createState() => _LoginScreenStudentState();
}

final _auth = FirebaseAuth.instance;


class _LoginScreenStudentState extends State<LoginScreenStudent> {
  
  String role = 'Student';
  late String email;
  late String password;
  bool showSpinner = false;
  @override
  void initState(){
    
  }


  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          title: Text("Studet login"),
          actions: [
            InkWell(
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.red,
                ),
                onTap: () {
                  Navigator.push(context, Animation_route(WelcomeScreen()))
                      .whenComplete(() => Navigator.of(context).pop());
                }),
            const SizedBox(width: 10),
          ],
        ),
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                    //Do something with the user input.
                  },
                  
                  decoration:   kTextFieldDecoration.copyWith(
                    hintText: 'Enter your email',
                  )),
              SizedBox(
                height: 15.0,
              ),
              TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                    //Do something with the user input.
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your password.')),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                  colour: Colors.red,
                  title: 'Log In',
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
              
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (user != null) {
                                  _checkRole();
                      }
                    } catch (e) {
                      print(e);
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  }),
            ],
          ),
        ),
      ),
    );
  }
  

  void _checkRole() async {
  
  final DocumentSnapshot snap = await FirebaseFirestore.instance.collection('Usuarios').doc(email).get();
  
  var datos = snap.data();

 
   print(datos.toString().split(','));
   var role = datos.toString().split(',');
   print(role[4].contains("Student"));
   
   var course= role[3].toString().split(':')[1].trim();

   var studen= false;




    if(role[4].contains("Student")){
       studen=false;
      navigateNext(SelectCourseModule(course,studen));
    } else {
      studen=true;
      (){
       
      showDialog(
          context: context,
          builder: (BuildContext context) {
          return AlertDialog(
          title: new Text("Alert!!"),
          content: new Text("You are trying to log in as"),
          actions: <Widget>[
        BackButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  },
);
    
    };
    }
  }
  
  
  void navigateNext(Widget route) {
    Timer(Duration(milliseconds: 500), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => route));
    });
  }
}
