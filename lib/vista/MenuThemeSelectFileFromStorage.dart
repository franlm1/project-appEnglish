import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tuttorial_1/vista/FormFileFromStorage.dart';
import 'package:tuttorial_1/vista/MenuControlador.dart';

import '../menu/animation_route.dart';
import 'ShowFileFromStorage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MenuThemeSelectFileFromStorage());
}

class MenuThemeSelectFileFromStorage extends StatelessWidget {
  const MenuThemeSelectFileFromStorage({Key? key}) : super(key: key);

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
        body: MenuStorage_(),
        appBar: AppBar(
          title: Text('Select yout theme'),
          actions: [
            InkWell(
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onTap: () {
                  Navigator.push(
                          context,
                          Animation_route(
                              FormFileFromStorage('Select a file', "")))
                      .whenComplete(() => Navigator.of(context).pop());
                }),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}

class MenuStorage_ extends StatefulWidget {
  @override
  State<MenuStorage_> createState() => MenuStorageState();
}

class MenuStorageState extends State<MenuStorage_> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference mainCollection;
  String tipo = "Videos";
  int selectedIndex = 0;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                                  context,
                                  Animation_route(
                                      const ShowFileFromStorage('Theme 1')))
                              .whenComplete(() => Navigator.of(context).pop());
                        },
                        icon: const Icon(Icons.library_add),
                        label: const Text('THEME 1'))),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                                  context,
                                  Animation_route(
                                      const ShowFileFromStorage('Theme 2')))
                              .whenComplete(() => Navigator.of(context).pop());
                        },
                        icon: const Icon(Icons.library_add),
                        label: const Text('THEME 2'))),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                                  context,
                                  Animation_route(
                                      const ShowFileFromStorage('Theme 3')))
                              .whenComplete(() => Navigator.of(context).pop());
                        },
                        icon: const Icon(Icons.library_add),
                        label: const Text('THEME 3'))),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                                  context,
                                  Animation_route(
                                      const ShowFileFromStorage('Theme 4')))
                              .whenComplete(() => Navigator.of(context).pop());
                        },
                        icon: const Icon(Icons.library_add),
                        label: const Text('THEME 4'))),
              ],
            ),
          ),
        ),
      ],
    );
  }

  int? _selectedValueIndex = 1;
  Widget button({required String text, required int index}) {
    return InkWell(
      splashColor: Colors.cyanAccent,
      onTap: () {
        setState(() {
          _selectedValueIndex = index;
          if (index == 1) {
            tipo = "Videos";
          } else {
            tipo = "Archivos";
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        color: index == _selectedValueIndex ? Colors.red : Colors.white,
        child: Text(
          text,
          style: TextStyle(
            color: index == _selectedValueIndex ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
