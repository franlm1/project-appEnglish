import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tuttorial_1/clases/Item.dart';
import 'package:tuttorial_1/vista/MenuControlador.dart';
import '../menu/animation_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'MenuThemeSelectFileFromStorage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class FormFileFromStorage extends StatefulWidget {
  final String nameFile;
  final String url;
  const FormFileFromStorage(this.nameFile, this.url);

  @override
  State<FormFileFromStorage> createState() => _MenuMovil_State();
}

class _MenuMovil_State extends State<FormFileFromStorage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String dropdownValueCourse = 'Course 1';
  String dropdownValueModule = 'Modules 1';

  List<Map> itemsModules = [
    {"value": 'm1', "text": 'Modules 1'},
    {"value":'m2', "text": 'Modules 2'},
    {"value":'m3', "text": 'Modules 3'},
    {"value":'m4', "text": 'Modules 4'},
    {"value":'m5', "text": 'Modules 5'},
    {"value":'m6', "text": 'Modules 6'}

  ];
  final List<String> itemsCourse = [
    'Course 1',
    'Course 2',
    'Course 3',
    'Course 4'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Form file from storage'),
          automaticallyImplyLeading: false,
          actions: [
            InkWell(
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onTap: () {
                  Navigator.push(
                          context, Animation_route(const MenuControlador()))
                      .whenComplete(() => Navigator.of(context).pop());
                }),
            const SizedBox(width: 10),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            child: Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                SizedBox(
                    child: Container(
                  width: 400.0,
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: dropButtonCourse()),
                )),
                SizedBox(
                    child: Container(
                  width: 400.0,
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: dropButtonModule()),
                )),
                SizedBox(
                  child: Container(
                      width: 400.0,
                      child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: widget.nameFile,
                                hintStyle: const TextStyle(color: Colors.red),
                                suffixIcon: IconButton(
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                            context,
                                            Animation_route(
                                                const MenuThemeSelectFileFromStorage()))
                                        .whenComplete(
                                            () => Navigator.of(context).pop());
                                  },
                                )),
                          ))),
                ),
                SizedBox(
                    child: Container(
                  width: 400.0,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      child: const Text('Upload File'),
                      onPressed: uploadFile,
                    ),
                  ),
                )),
              ]),
            ),
          ),
        ));
  }

  Widget dropButtonCourse() {
    return DropdownButtonFormField(
      value: 'Course 1',
      icon: const Icon(Icons.arrow_downward, color: Colors.red),
      elevation: 20,
      style: const TextStyle(color: Colors.red),
      items: itemsCourse.map((itemsCourse) {
        return DropdownMenuItem(
          value: itemsCourse,
          child: Text(itemsCourse),

          
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValueCourse = newValue!;
        });
      },
    );
  }

  Widget dropButtonModule() {
    return DropdownButtonFormField(
        value: 'Modules 1',
        icon: const Icon(Icons.arrow_downward, color: Colors.red),
        elevation: 20,
        style: const TextStyle(color: Colors.red),
        items: itemsModules
            .map((item) =>
                DropdownMenuItem(value: item['value'], child: item['text']))
            .toList(),
        onChanged: (v) => setState(() {
          
        }));
  }

  Widget elevatedButton() {
    return ElevatedButton.icon(
        onPressed: () {
          try {
            addItemToFirestoreCloud();
            showMyDialog();
          } catch (e) {}
        },
        icon: const Icon(Icons.library_add),
        label: const Text('Gallery'));
  }

  Future<void> showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(''),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                  'Select a file',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.push(
                      context, Animation_route(const MenuControlador()))
                  .whenComplete(() => Navigator.of(context).pop()),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  addItemToFirestoreCloud() {
    Map<String, dynamic> cad = {"titulo": "", "descripcion": "", "url": ""};

    firestore.doc('Modulos/' + dropdownValueModule).set({
      "widget.tipo": FieldValue.arrayUnion([cad])
    }, SetOptions(merge: true));

    setState(() {});
  }

  Future uploadFile() async {
    if (widget.nameFile != "Select a file") {
      final file = <String, dynamic>{
        'url': widget.url,
        'name': widget.nameFile
      };
      firestore.collection('Cursos').add({'name': dropdownValueCourse}).then(
          (DocumentReference document) {
        firestore
            .collection('Modulos')
            .add({'name': dropdownValueModule, 'idCurso': document.id}).then(
                (DocumentReference doc) {
          firestore.collection('Archivos').add({
            'url': widget.url,
            'name': widget.nameFile,
            'idModulo': doc.id,
            'idCurso': document.id
          }).then((DocumentReference doc) {
            Navigator.push(
                    context, Animation_route(const FormFileFromStorage("", "")))
                .whenComplete(() => Navigator.of(context).pop());
          });
        });
      });
    } else {
      showMyDialog();
    }
  }
}
