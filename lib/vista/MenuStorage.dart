import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tuttorial_1/vista/MenuControlador.dart';

import '../menu/animation_route.dart';
import 'MenuStorageGaleria.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MenuStorage());
}

class MenuStorage extends StatelessWidget {
  const MenuStorage({Key? key}) : super(key: key);

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
          title: Text('AaaAAAAaAAAaaA'),
          actions: [
            InkWell(
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onTap: () {
                  Navigator.push(context, Animation_route(MenuControlador()))
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
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: button(index: 1, text: 'Videos'),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: button(index: 2, text: 'Files'),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(150.0),
              child: ListView(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                                    context,
                                    Animation_route(
                                        MenuStorageGaleria("Unit 1", tipo)))
                                .whenComplete(
                                    () => Navigator.of(context).pop());
                          },
                          icon: const Icon(Icons.library_add),
                          label: const Text('UNIT 1'))),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                                    context,
                                    Animation_route(
                                        MenuStorageGaleria("Unit 2", tipo)))
                                .whenComplete(
                                    () => Navigator.of(context).pop());
                          },
                          icon: const Icon(Icons.library_add),
                          label: const Text('UNIT 2'))),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                          onPressed: () {
                             Navigator.push(
                                    context,
                                    Animation_route(
                                        MenuStorageGaleria("Unit 3", tipo)))
                                .whenComplete(
                                    () => Navigator.of(context).pop());
                          },
                          icon: const Icon(Icons.library_add),
                          label: const Text('UNIT 3'))),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                          onPressed: () {
                             Navigator.push(
                                    context,
                                    Animation_route(
                                        MenuStorageGaleria("Unit 4", tipo)))
                                .whenComplete(
                                    () => Navigator.of(context).pop());
                          },
                          icon: const Icon(Icons.library_add),
                          label: const Text('UNIT 4'))),
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
