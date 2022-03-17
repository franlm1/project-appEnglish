import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tuttorial_1/main.dart';
import 'package:tuttorial_1/menu/menu_lateral.dart';
import '../menu/animation_route.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(AddTarea());

class AddTarea extends StatelessWidget {
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
      home: const HomePageTarea(title: 'Registrar Tarea'),
      routes: const <String, WidgetBuilder>{},
    );
  }
}

class HomePageTarea extends StatelessWidget {
  final String title;
  const HomePageTarea({Key? key, required this.title}) : super(key: key);

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
        body: TareaForm(),
        drawer: MenuLateral());
  }
}

class TareaForm extends StatefulWidget {
  @override
  TareaFormState createState() => TareaFormState();
}

class TareaFormState extends State<TareaForm> {
  String dropdownValueCurso = 'Curso 1';
  String dropdownValueModulo = 'Modulo 1';
  final _formKey = GlobalKey<FormState>();
  var curso = TextEditingController();
  var modulo = TextEditingController();
  List<String> spinnerCurso = ['Curso 1', 'Curso 2', 'Curso 3', 'Curso 4'];
  List<String> spinnerModulo = ['Modulo 1', 'Modulo 2', 'Modulo 3', 'Modulo 4'];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            child: Column(children: [
              DropdownButton<String>(
                
                  value: dropdownValueCurso,
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.red, fontSize: 18),
                  underline: Container(
                    height: 2,
                    color: Colors.pink,
                  ),
                  items: spinnerCurso.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                          );
                          }).toList(),
                  onChanged: (String? data) {
                    setState(() {
                      dropdownValueCurso = data!;
                    });
                   
                  }),
            ]),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            child: Column(children: [
              DropdownButton<String>(
                  value: dropdownValueModulo,
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.red, fontSize: 18),
                  underline: Container(
                    height: 2,
                    color: Colors.pink,
                  ),
                  items: spinnerModulo.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                          );
                          }).toList(),
                  onChanged: (String? data) {
                    setState(() {
                      dropdownValueModulo = data!;
                    });
                   
                  }),
            ]),
          )
        ],
      ),
    );
  }
}
