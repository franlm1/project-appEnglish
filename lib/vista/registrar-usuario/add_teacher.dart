// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



import '../../util/animation_route.dart';
import '../MenuControlador.dart';
import '../login/welcome_screen.dart';







void main() => runApp(AddTeacher());

class AddTeacher extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Registrar',
      theme: ThemeData(
        primarySwatch: Colors.red,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.pink,
        brightness: Brightness.light,
      ),
      home: const HomePage(title: 'Registrar'),
      routes: const <String, WidgetBuilder>{},
    );
  }
}

class HomePage extends StatelessWidget {
  final String title;

  const HomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: [
            InkWell(
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
                onTap: () {
                  Navigator.push(context, Animation_route(MenuControlador()))
                      .whenComplete(() => Navigator.of(context).pop());
                }),
            const SizedBox(width: 10),
          ],
        ),
        body: AlumnoForm(),
       );
  }
}

class AlumnoForm extends StatefulWidget {
  @override
  AlumnoFormState createState() => AlumnoFormState();
}

class AlumnoFormState extends State<AlumnoForm> {
  final _formKey = GlobalKey<FormState>();
  var email = TextEditingController();
  var password = TextEditingController();
  var name = TextEditingController();
  var apellido = TextEditingController();
  List<String> spinnerRol = ['Teacher'];
 
  late String dropdownValueRol;
    @override
  void initState() {
    dropdownValueRol = spinnerRol[0];
    super.initState();
  }

  
  
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            child: TextFormField(
              keyboardType: TextInputType.text,
              style: const TextStyle(fontSize: 20.0),
              decoration: InputDecoration(
                  labelText: "Enter Nombre,",
                  fillColor: Colors.black,
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(),
                  )),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor ingrese el nombre';
                }
              },
              controller: name,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            child: TextFormField(
              keyboardType: TextInputType.text,
              style: const TextStyle(fontSize: 20.0),
              decoration: InputDecoration(
                  labelText: "Enter Apellido,",
                  fillColor: Colors.black,
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(),
                  )),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor ingrese el apellido';
                }
              },
              controller: apellido,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(fontSize: 20.0),
              decoration: InputDecoration(
                labelText: "Enter Email",
                fillColor: Colors.black,
                prefixIcon: const Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor ingrese el email';
                } else {
                  final RegExp regex = RegExp(
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

                  if (regex.hasMatch(value)) {
                  } else {
                    return 'Invalid Email';
                  }
                }
              },
              controller: email,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            child: TextFormField(
              obscureText: true,
              style: const TextStyle(fontSize: 20.0),
              decoration: InputDecoration(
                labelText: "Enter password",
                fillColor: Colors.black,
                prefixIcon: const Icon(Icons.enhanced_encryption),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor ingrese el password';
                } else {
                  if (6 > value.length) {
                    return 'mayor de 6 caracteres';
                  } else {}
                }
              },
              controller: password,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
            child: MaterialButton(
              minWidth: 200.0,
              height: 60.0,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  registrar(context);
                }
              },
              color: Colors.lightBlue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              child: setUpButtonChild(),
            ),
          ),
       
        ],
      ),
    );
  }

  // SPINNER DEL CURSO

  int _state = 0;
  Widget setUpButtonChild() {
    if (_state == 0) {
      return const Text(
        "Registrar",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      );
    } else if (_state == 1) {
      return const CircularProgressIndicator(
        valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
      );
    } else {
      return const Text(
        "Registrar",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      );
    }
  }

  registrar(BuildContext context) async {
    final _auth = FirebaseAuth.instance;
    final _db = FirebaseFirestore.instance;
    

    // /TODO Implementar email esta en uso.
    await _auth
        .createUserWithEmailAndPassword(
            email: email.text, password: password.text)
        .then((value) {

            DocumentReference ref1 = _db.collection('Usuarios').doc(email.text);
            ref1.set({'Nombre': name.text, 'Apellido': apellido.text, 'Email': email.text, 'Rol': spinnerRol.first})


      .then((value) {
        Navigator.push(context, Animation_route(WelcomeScreen()))
            .whenComplete(() => Navigator.of(context).pop());
      });

      // ignore: invalid_return_type_for_catch_error
    }).catchError((e) => {
              Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text(e.message))),
            });
  }
}


/*       final alumno = <String, dynamic>{
          'nombre': name.text,
          'email':email.text,
        };
        final alumno2 = <String, dynamic>{
        'alumnos' = alumno
        }; */
/* 
          final alu = <String, dynamic>{
          'url': widget.url,
          'name': widget.nameFile,
          'idCurso':Modules.nameCourse,
          'idModulo':Modules.name
        };
        CollectionReference users = FirebaseFirestore.instance.collection('users');
Future<void> deleteField() {
  return users
    .doc('ABC123')
    .update({'age': FieldValue.delete()})
    .then((value) => print("User's Property Deleted"))
    .catchError((error) => print("Failed to delete user's property: $error"));
} */
 //[{email.text:FieldValue.arrayUnion([])}])})

