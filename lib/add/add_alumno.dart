import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tuttorial_1/main.dart';
import 'package:tuttorial_1/menu/menu_lateral.dart';

import '../menu/animation_route.dart';

void main() => runApp(AddAlumno());

class AddAlumno extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Registrar',
      theme: ThemeData(
        primarySwatch: Colors.pink,
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
                  Navigator.push(context, Animation_route(MyApp()))
                      .whenComplete(() => Navigator.of(context).pop());
                }),
            const SizedBox(width: 10),
          ],
        ),
        body: AlumnoForm(),
        drawer: MenuLateral());
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
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
            child: Column(children: [
              Card(
                semanticContainer: true,
                child: Image.network(
                  'https://scontent.falc1-1.fna.fbcdn.net/v/t1.18169-9/58675_334588940027861_6571281867888589763_n.png?_nc_cat=111&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=yijQMh_P2tUAX-LfYtY&_nc_ht=scontent.falc1-1.fna&oh=00_AT8l5Kmk7i2FoW27Fvpp8B2aF4aivTFxcefk2mR3h8tpfA&oe=6257FF2E',
                  fit: BoxFit.fill,
                ),
                elevation: 0,
                margin: const EdgeInsets.all(0),
              ),
            ]),
          ),
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
              validator: validateEmail,
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
              validator: validatePassword,
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
                if (_formKey.currentState!.validate()){
                  
                }
              },
              color: Colors.lightBlue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              child: setUpButtonChild(),
            ),
          )
        ],
      ),
    );
  }

  int _state = 0;
  Widget setUpButtonChild() {
    if (_state == 0) {
      return const Text(
        "Registrar",
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      );
    } else if (_state == 1) {
      return const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
      );
    } else {
      return const Text(
        "Registrar",
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      );
    }
  }

  String validateEmail(String? value) {
    String check = "";
    final RegExp regex  =
       RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (value!.isEmpty) {
      check = 'Por favor ingrese el email';
    } else {
      if (!regex.hasMatch(value!)) {
        check = 'Enter Valid Email';
      }
    }
    return check;
  }

  String validatePassword(String? value) {
    String check = "";
    if (value!.isEmpty) {
      check = 'Por favor ingrese el passwpord';
    } else {
      if (6 > value!.length) {
        check = 'Por favor ingrese un passwpord de 6 caracteres';
      }
    }
    return check;
  }
  
}
