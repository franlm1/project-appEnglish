import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tuttorial_1/vista/MenuGaleria.dart';
import 'package:tuttorial_1/vista/MenuStorage.dart';
import '../menu/animation_route.dart';
import 'MenuCloud.dart';
import 'MenuMovil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MenuControlador());
}

class MenuControlador extends StatelessWidget {
  const MenuControlador({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      
      title: 'MENU CONTROLADOR',
      theme:  ThemeData(
        primarySwatch: Colors.red,
        brightness: Brightness.light,
      ),
      home: const Scaffold(
        body: body(),
      ),
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
                  label: const Text('SUBIR ARCHIVOS'))),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(context, Animation_route(MenuStorage()))
                        .whenComplete(() => Navigator.of(context).pop());
                  },
                  icon: const Icon(Icons.library_add),
                  label: const Text('AÑADIR CONTENIDOS'))),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(context, Animation_route(Galeria()))
                        .whenComplete(() => Navigator.of(context).pop());
                  },
                  icon: const Icon(Icons.rectangle_outlined),
                  label: const Text('GALERIA'))),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.person),
                  label: const Text('REGISTRAR USUARIOS'))),
        ],
      ),
    );
  }
}
