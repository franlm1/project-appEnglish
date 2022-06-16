import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../../util/animation_route.dart';
import 'FormFileFromStorage.dart';
import 'package:tuttorial_1/vista/MenuControlador.dart';


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
              //  'Grammar', 'Vocabulary', 'Pronunciation', 'Listening'
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                                  context,
                                  Animation_route(
                                      const ShowFileFromStorage('Grammar')))
                              .whenComplete(() => Navigator.of(context).pop());
                        },
                        icon: const Icon(Icons.library_add),
                        label: const Text('Grammar'))),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                                  context,
                                  Animation_route(
                                      const ShowFileFromStorage('Vocabulary')))
                              .whenComplete(() => Navigator.of(context).pop());
                        },
                        icon: const Icon(Icons.library_add),
                        label: const Text('Vocabulary'))),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                                  context,
                                  Animation_route(
                                      const ShowFileFromStorage('Pronunciation')))
                              .whenComplete(() => Navigator.of(context).pop());
                        },
                        icon: const Icon(Icons.library_add),
                        label: const Text('Pronunciation'))),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                                  context,
                                  Animation_route(
                                      const ShowFileFromStorage('Listening')))
                              .whenComplete(() => Navigator.of(context).pop());
                        },
                        icon: const Icon(Icons.library_add),
                        label: const Text('Listening'))),
              ],
            ),
          ),
        ),
      ],
    );
  }

}
