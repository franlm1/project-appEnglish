import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tuttorial_1/add/add_alumno.dart';
import 'package:tuttorial_1/screens/welcome_screen.dart';

import '../../menu/animation_route.dart';
import 'MenuCloud.dart';
import 'MenuGaleria.dart';
import 'MenuMovil.dart';
import 'MenuStorage.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MenuCursos());
}

class MenuCursos extends StatelessWidget {
  const MenuCursos({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      
      title: 'MENU CURSOS',
      theme:  ThemeData(
        primarySwatch: Colors.red,
        brightness: Brightness.light,
      ),
       home:  MenuCursos(),
      
    );
  }
}

class body extends StatefulWidget {
  const body({Key? key}) : super(key: key);
  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(200),
      child: ListView(
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(context, Animation_route(MenuMovil()))
                    .whenComplete(() => Navigator.of(context).pop());
                  },
                  icon: const Icon(Icons.upload_file),
                  label: const Text('1st COURSE'))),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(context, Animation_route(MenuStorage()))
                        .whenComplete(() => Navigator.of(context).pop());
                  },
                  icon: const Icon(Icons.library_add),
                  label: const Text('2nd COURSE'))),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(context, Animation_route(Galeria()))
                        .whenComplete(() => Navigator.of(context).pop());
                  },
                  icon: const Icon(Icons.rectangle_outlined),
                  label: const Text('3rd COURSE'))),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                  onPressed: () {Navigator.push(context, Animation_route(AddAlumno()))
                        .whenComplete(() => Navigator.of(context).pop());
                        },
                  icon: const Icon(Icons.person),
                  label: const Text('4th COURSE'))),
        ],
      ),
    );
  }
}
