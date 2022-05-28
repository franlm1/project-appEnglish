import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tuttorial_1/vista/MenuControlador.dart';
import '../menu/animation_route.dart';
import 'package:firebase_core/firebase_core.dart';

import 'MenuStorage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class MenuCloud extends StatefulWidget {
  final String titulo, descripcion, url, tipo;

  const MenuCloud(this.titulo, this.descripcion, this.url, this.tipo);

  @override
  State<MenuCloud> createState() => _MenuMovil_State();
}

class _MenuMovil_State extends State<MenuCloud> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  final List<String> itemsModulos = [
    'Modules 1',
    'Modules 2',
    'Modules 3',
    'Modules 4'
  ];
  final List<String> itemsUnit = ['Unit 1', 'Unit 2', 'Unit 3', 'Unit 4'];

  String dropdownValueUnit = 'Unit 1';
  String dropdownValueModule = 'Modules 1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Navigator.push(context, Animation_route(MenuStorage()))
                      .whenComplete(() => Navigator.of(context).pop());
                }),
            const SizedBox(width: 10),
          ],
        ),
        body: Form(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Text(" Cloud Menu ",
                        style: TextStyle(fontSize: 30, color: Colors.red)),
                  ),
                ),
                SizedBox(
                    child: Container(
                  width: 400.0,
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: dropButtonFormFieldUnit()),
                )),
                SizedBox(
                    child: Container(
                  width: 400.0,
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: dropButtonFormFieldModel()),
                )),
                SizedBox(
                    child: Container(
                  width: 400.0,
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: elevatedButton()),
                )),
              ]),
        ));
  }

  Widget dropButtonFormFieldUnit() {
    return DropdownButtonFormField(
      value: 'Unit 1',
      icon: const Icon(Icons.arrow_downward, color: Colors.red),
      elevation: 20,
      style: const TextStyle(color: Colors.red),
      items: itemsUnit.map((itemsUnit) {
        return DropdownMenuItem(
          value: itemsUnit,
          child: Text(itemsUnit),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValueUnit = newValue!;
        });
      },
    );
  }

  Widget dropButtonFormFieldModel() {
    return DropdownButtonFormField(
      value: 'Unit 1',
      icon: const Icon(Icons.arrow_downward, color: Colors.red),
      elevation: 20,
      style: const TextStyle(color: Colors.red),
      items: itemsUnit.map((itemsUnit) {
        return DropdownMenuItem(
          value: itemsUnit,
          child: Text(itemsUnit),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValueModule = newValue!;
        });
      },
    );
  }

  Widget elevatedButton() {
    return ElevatedButton.icon(
        onPressed: () {
          try {
           
            firestore
                .doc('Modulos/' + dropdownValueModule + '_' + dropdownValueUnit)
                .update({
              widget.tipo: FieldValue.arrayUnion([
                {
                  'titulo': widget.titulo,
                  'descripcion': widget.descripcion,
                  'url': widget.url
                }
              ])
            });
            Navigator.push(context, Animation_route(MenuStorage()))
                .whenComplete(() => Navigator.of(context).pop());
          } on Exception {
            print("No se pudo insertar");
          }
          setState(() {});
        },
        icon: const Icon(Icons.library_add),
        label: const Text('Gallery'));
  }
}
//firebase storage
