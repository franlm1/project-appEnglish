import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tuttorial_1/vista/MenuGaleria.dart';
import 'package:tuttorial_1/vista/MenuThemeSelectFileFromStorage.dart';
import 'package:tuttorial_1/vista/ShowFileFromStorage.dart';
import 'package:tuttorial_1/vista/SelectFileToStotage.dart';
import 'package:tuttorial_1/vista/ShowFilesFromCloud.dart';
import '../menu/animation_route.dart';
import 'MenuMovil.dart';
import 'FormFileFromStorage.dart';

//MENU PRINCIPAL
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MenuControlador());
}

class MenuControlador extends StatelessWidget {
  const MenuControlador({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MENU CONTROLADOR',
      theme: ThemeData(
        primarySwatch: Colors.red,
        brightness: Brightness.light,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('STORAGE GALLERY MENU'),
          automaticallyImplyLeading: false,
          actions: [
            InkWell(
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onTap: () {
                  Navigator.push(context,
                          Animation_route(MenuThemeSelectFileFromStorage()))
                      .whenComplete(() => Navigator.of(context).pop());
                }),
            const SizedBox(width: 10),
          ],
        ),
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
  //TODO
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                            context, Animation_route(SelecFileToStorage()))
                        .whenComplete(() => Navigator.of(context).pop());
                  },
                  icon: const Icon(Icons.upload_file),
                  label: const Text('SUBIR ARCHIVOS'))),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                            context, Animation_route(FormFileFromStorage("Select a file","")))
                        .whenComplete(() => Navigator.of(context).pop());
                  },
                  icon: const Icon(Icons.library_add),
                  label: const Text('AÑADIR CONTENIDOS'))),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(context, Animation_route(ShowFileFromCloud()))
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
